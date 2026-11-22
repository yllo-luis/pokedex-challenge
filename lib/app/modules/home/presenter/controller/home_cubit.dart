import 'dart:async';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/states/failure_state.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/states/home_state.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_basic_paginated_pokemon_usecase.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_pokemon_per_url_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBasicPaginatedPokemonUseCase getBasicPaginatedPokemonsUsecase;
  final GetPokemonPerUrlUseCase getPokemonPerUrlUsecase;

  HomeCubit(
    super.initialState, {
    required this.getBasicPaginatedPokemonsUsecase,
    required this.getPokemonPerUrlUsecase,
  });

  List<String> listOfUrlsToFetch = List.empty(growable: true);

  Future<void> goToNextPage() async {
    if (state.isLoading == true) return;
    emit(state.copyWith(isLoading: true));

    try {
      final value = await getBasicPaginatedPokemonsUsecase
          .getBasicPaginatedPokemon(offset: state.currentPage ?? 0);

      listOfUrlsToFetch.clear();

      for (var element in value) {
        if (element.url != null && element.url?.isNotEmpty == true) {
          listOfUrlsToFetch.add(
            element.url!,
          );
        }
      }

      if (state is! FailureState) {
        final pokemons = await _getPokemonByUrl();

        emit(
          state.copyWith(
            currentPage: (state.currentPage ?? 0) + 10,
            pokemonData: HomeVo(
              listPokemons: [
                ...?state.pokemonData?.listPokemons,
                ...pokemons,
              ],
              sortTypeEnum: state.pokemonData?.sortTypeEnum ??
                  HomeSortTypeEnum.sortAlphabet,
              isSearchModeEnabled: false,
            ),
            isLoading: false,
          ),
        );
      }
    } catch (error) {
      emit(
        FailureState(
          exception: error is Exception ? error : Exception(error.toString()),
          pokemonData: state.pokemonData,
          currentPage: state.currentPage,
          isLoading: false,
        ),
      );
    }
  }

  Future<List<PokemonHomeVo>> _getPokemonByUrl() async {
    List<PokemonHomeVo> result = List.empty(growable: true);

    await Future.forEach(listOfUrlsToFetch, (element) async {
      if (state is! FailureState) {
        final value =
            await getPokemonPerUrlUsecase.getPokemonPerUrl(url: element);
        result.add(
          PokemonHomeVo.fromEntity(entity: value),
        );
      }
    });

    return result;
  }

  List<PokemonHomeVo> _filterListPerAlphabet() {
    List<PokemonHomeVo> currentPokemonsList =
        state.pokemonData?.listPokemons ?? List.empty();

    if (currentPokemonsList.isNotEmpty) {
      currentPokemonsList.sort((a, b) => a.name!.compareTo(b.name!));
    }

    return currentPokemonsList;
  }

  List<PokemonHomeVo> _filterListPerId() {
    List<PokemonHomeVo> currentPokemonsList =
        state.pokemonData?.listPokemons ?? List.empty();

    if (currentPokemonsList.isNotEmpty) {
      currentPokemonsList.sort((a, b) => a.id!.compareTo(b.id!));
    }

    return currentPokemonsList;
  }

  void updatePokemonExibition(HomeSortTypeEnum value) {
    switch (value) {
      case HomeSortTypeEnum.sortAlphabet:
        final pokemonList = _filterListPerAlphabet();

        emit(
          state.copyWith(
            pokemonData: state.pokemonData?.copyWith(
              sortTypeEnum: value,
              listPokemons: pokemonList,
            ),
          ),
        );
      case HomeSortTypeEnum.sortId:
        final pokemonList = _filterListPerId();

        emit(
          state.copyWith(
            pokemonData: state.pokemonData?.copyWith(
              sortTypeEnum: value,
              listPokemons: pokemonList,
            ),
          ),
        );
    }
  }
}

import 'dart:async';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_basic_paginated_pokemons_usecase.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_pokemon_per_url_usecase.dart';

class HomeController {
  final HomeStore homeStore;
  final GetBasicPaginatedPokemonsUseCase getBasicPaginatedPokemonsUsecase;
  final GetPokemonPerUrlUseCase getPokemonPerUrlUsecase;

  const HomeController({
    required this.homeStore,
    required this.getBasicPaginatedPokemonsUsecase,
    required this.getPokemonPerUrlUsecase,
  });

  Future<void> init() async {
    Future.microtask(
      () => goToNextPage(),
    ).whenComplete(() {
      Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          if (homeStore.isLoadingNewPage == false) {
            await loadNewPage();
          }
        },
      );
    });
  }

  Future<void> loadNewPage() async {
    homeStore.isLoadingNewPage = true;
    await goToNextPage();
  }

  Future<void> goToNextPage() async {
    await getBasicPaginatedPokemonsUsecase
        .getBasicPaginatedPokemons(offset: homeStore.currentPage)
        .then(
      (value) {
        value.forEach((element) {
          if (element.url != null && element.url?.isNotEmpty == true) {
            homeStore.listOfUrlsToFetch.add(
              element.url!,
            );
          }
        });
      },
      onError: (error) {
        homeStore.currentPokemons.addError(error);
      },
    ).whenComplete(() async {
      if (homeStore.currentPokemons.hasError == false) {
        await getPokemonByUrl();
        homeStore.currentPage = homeStore.currentPage + 10;
      }
    });
  }

  Future<void> getPokemonByUrl() async {
    List<PokemonHomeVo> result = List.empty(growable: true);
    await Future.forEach(homeStore.listOfUrlsToFetch, (element) async {
      if (homeStore.currentPokemons.hasError == false) {
        await getPokemonPerUrlUsecase.getPokemonPerUrl(url: element).then(
          (value) {
            result.add(
              PokemonHomeVo.fromEntity(entity: value),
            );
          },
        );
      }
    });
    homeStore.currentPokemons.add(
      HomeVo(
        listPokemons: result,
        sortTypeEnum: HomeSortTypeEnum.sortAlphabet,
        isSearchModeEnabled: false,
      ),
    );
    homeStore.isLoadingNewPage = false;
  }

  void changeFilterType({required HomeSortTypeEnum homeSortTypeEnum}) {
    final currentHomeVo = homeStore.currentPokemons.value;
    homeStore.currentPokemons.add(
      currentHomeVo.copyWith(sortTypeEnum: homeSortTypeEnum),
    );
    switch (homeSortTypeEnum) {
      case HomeSortTypeEnum.sortAlphabet:
        filterListPerAlphabet();
        break;
      case HomeSortTypeEnum.sortId:
        filterListPerId();
        break;
    }
  }

  void filterListPerAlphabet() {
    HomeVo? currentVo = homeStore.currentPokemons.valueOrNull;
    if (currentVo != null) {
      currentVo.listPokemons.sort((a, b) => a.name!.compareTo(b.name!));
      homeStore.currentPokemons.add(
        currentVo.copyWith(
          listPokemons: currentVo.listPokemons,
        ),
      );
    }
  }

  void filterListPerId() {
    HomeVo? currentVo = homeStore.currentPokemons.valueOrNull;
    if (currentVo != null) {
      currentVo.listPokemons.sort((a, b) => a.id!.compareTo(b.id!));
      homeStore.currentPokemons.add(
        currentVo.copyWith(
          listPokemons: currentVo.listPokemons,
        ),
      );
    }
  }
}

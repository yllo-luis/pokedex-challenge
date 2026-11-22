import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_cubit.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/states/failure_state.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/states/home_state.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_redirect_resource_response.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_response.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_basic_paginated_pokemon_usecase.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_pokemon_per_url_usecase.dart';

import 'home_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetBasicPaginatedPokemonUseCase>(),
  MockSpec<GetPokemonPerUrlUseCase>(),
])
void main() {
  late MockGetBasicPaginatedPokemonUseCase mockGetBasicPaginatedPokemonUseCase;
  late MockGetPokemonPerUrlUseCase mockGetPokemonPerUrlUseCase;
  late HomeCubit homeCubit;

  final fakeResources = [
    PokemonRedirectResourceResponse(
      name: 'bulbasaur',
      url: 'https://pokeapi.co/api/v2/pokemon/1/',
    ),
    PokemonRedirectResourceResponse(
      name: 'ivysaur',
      url: 'https://pokeapi.co/api/v2/pokemon/2/',
    ),
  ];

  final fakePokemonResponseBulbasaur = PokemonResponse(
    id: 1,
    name: 'bulbasaur',
    height: 7,
    weight: 69,
    moves: [],
    stats: [],
    types: [],
    officialArtwork: '',
  );

  final fakePokemonResponseIvysaur = PokemonResponse(
    id: 2,
    name: 'ivysaur',
    height: 10,
    weight: 130,
    moves: [],
    stats: [],
    types: [],
    officialArtwork: '',
  );

  final pokemonBulbasaur = PokemonHomeVo(
    id: 1,
    name: 'Bulbasaur',
  );

  final pokemonCharmander = PokemonHomeVo(
    id: 4,
    name: 'Charmander',
  );

  final pokemonSquirtle = PokemonHomeVo(
    id: 7,
    name: 'Squirtle',
  );

  setUp(() {
    mockGetBasicPaginatedPokemonUseCase = MockGetBasicPaginatedPokemonUseCase();
    mockGetPokemonPerUrlUseCase = MockGetPokemonPerUrlUseCase();
    homeCubit = HomeCubit(
      HomeState.initial(),
      getBasicPaginatedPokemonsUsecase: mockGetBasicPaginatedPokemonUseCase,
      getPokemonPerUrlUsecase: mockGetPokemonPerUrlUseCase,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit Unit Tests', () {
    test('initial state should be HomeState.initial()', () {
      expect(homeCubit.state.currentPage, 0);
      expect(homeCubit.state.isLoading, false);
      expect(homeCubit.state.pokemonData, isNull);
    });

    group('goToNextPage', () {
      test('should do nothing when state.isLoading is true', () async {
        final loadingCubit = HomeCubit(
          HomeState(isLoading: true, currentPage: 0, pokemonData: null),
          getBasicPaginatedPokemonsUsecase: mockGetBasicPaginatedPokemonUseCase,
          getPokemonPerUrlUsecase: mockGetPokemonPerUrlUseCase,
        );

        await loadingCubit.goToNextPage();

        verifyNever(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(
          offset: anyNamed('offset'),
        ));
        expect(loadingCubit.state.isLoading, isTrue);
        loadingCubit.close();
      });

      test('should fetch paginated pokemons and pokemon details successfully', () async {
        when(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(offset: 0))
            .thenAnswer((_) async => fakeResources);
        when(mockGetPokemonPerUrlUseCase.getPokemonPerUrl(url: 'https://pokeapi.co/api/v2/pokemon/1/'))
            .thenAnswer((_) async => fakePokemonResponseBulbasaur);
        when(mockGetPokemonPerUrlUseCase.getPokemonPerUrl(url: 'https://pokeapi.co/api/v2/pokemon/2/'))
            .thenAnswer((_) async => fakePokemonResponseIvysaur);

        final states = <HomeState>[];
        homeCubit.stream.listen(states.add);

        await homeCubit.goToNextPage();
        await pumpEventQueue();

        expect(states.length, 2);
        expect(states[0].isLoading, isTrue);
        expect(states[1].isLoading, isFalse);
        expect(states[1].currentPage, 10);
        expect(states[1].pokemonData?.listPokemons.length, 2);
        expect(states[1].pokemonData?.listPokemons[0].name, 'bulbasaur');
        expect(states[1].pokemonData?.listPokemons[1].name, 'ivysaur');
        expect(states[1].pokemonData?.sortTypeEnum, HomeSortTypeEnum.sortAlphabet);
        expect(states[1].pokemonData?.isSearchModeEnabled, isFalse);
        expect(homeCubit.listOfUrlsToFetch, [
          'https://pokeapi.co/api/v2/pokemon/1/',
          'https://pokeapi.co/api/v2/pokemon/2/',
        ]);
      });

      test('should append new pokemons to existing list when fetching next page', () async {
        final existingVo = HomeVo(
          listPokemons: [pokemonBulbasaur],
          sortTypeEnum: HomeSortTypeEnum.sortId,
          isSearchModeEnabled: false,
        );
        final customCubit = HomeCubit(
          HomeState(currentPage: 10, isLoading: false, pokemonData: existingVo),
          getBasicPaginatedPokemonsUsecase: mockGetBasicPaginatedPokemonUseCase,
          getPokemonPerUrlUsecase: mockGetPokemonPerUrlUseCase,
        );

        when(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(offset: 10))
            .thenAnswer((_) async => [fakeResources[1]]);
        when(mockGetPokemonPerUrlUseCase.getPokemonPerUrl(url: 'https://pokeapi.co/api/v2/pokemon/2/'))
            .thenAnswer((_) async => fakePokemonResponseIvysaur);

        await customCubit.goToNextPage();

        expect(customCubit.state.currentPage, 20);
        expect(customCubit.state.pokemonData?.listPokemons.length, 2);
        expect(customCubit.state.pokemonData?.listPokemons[0].name, 'Bulbasaur');
        expect(customCubit.state.pokemonData?.listPokemons[1].name, 'ivysaur');
        expect(customCubit.state.pokemonData?.sortTypeEnum, HomeSortTypeEnum.sortId);

        customCubit.close();
      });

      test('should filter out null or empty URLs when populating listOfUrlsToFetch', () async {
        final resourcesWithInvalidUrls = [
          PokemonRedirectResourceResponse(name: 'noUrl', url: null),
          PokemonRedirectResourceResponse(name: 'emptyUrl', url: ''),
          PokemonRedirectResourceResponse(
            name: 'valid',
            url: 'https://pokeapi.co/api/v2/pokemon/1/',
          ),
        ];

        when(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(offset: 0))
            .thenAnswer((_) async => resourcesWithInvalidUrls);
        when(mockGetPokemonPerUrlUseCase.getPokemonPerUrl(url: 'https://pokeapi.co/api/v2/pokemon/1/'))
            .thenAnswer((_) async => fakePokemonResponseBulbasaur);

        await homeCubit.goToNextPage();

        expect(homeCubit.listOfUrlsToFetch, ['https://pokeapi.co/api/v2/pokemon/1/']);
        verify(mockGetPokemonPerUrlUseCase.getPokemonPerUrl(url: 'https://pokeapi.co/api/v2/pokemon/1/'))
            .called(1);
      });

      test('should emit FailureState when getBasicPaginatedPokemonUseCase throws an error', () async {
        when(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(offset: 0))
            .thenThrow(Exception('Network error'));

        final states = <HomeState>[];
        homeCubit.stream.listen(states.add);

        await homeCubit.goToNextPage();
        await pumpEventQueue();

        expect(states.length, 2);
        expect(states[0].isLoading, isTrue);
        expect(states[1], isA<FailureState>());
        final failure = states[1] as FailureState;
        expect(failure.isLoading, isFalse);
        expect(failure.exception.toString(), contains('Network error'));
      });

      test('should emit FailureState when getPokemonPerUrlUseCase throws an error', () async {
        when(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(offset: 0))
            .thenAnswer((_) async => fakeResources);
        when(mockGetPokemonPerUrlUseCase.getPokemonPerUrl(url: anyNamed('url')))
            .thenThrow(Exception('Fetch details error'));

        final states = <HomeState>[];
        homeCubit.stream.listen(states.add);

        await homeCubit.goToNextPage();
        await pumpEventQueue();

        expect(states.length, 2);
        expect(states[0].isLoading, isTrue);
        expect(states[1], isA<FailureState>());
        final failure = states[1] as FailureState;
        expect(failure.isLoading, isFalse);
        expect(failure.exception.toString(), contains('Fetch details error'));
      });

      test('should wrap non-Exception errors in Exception when FailureState is emitted', () async {
        when(mockGetBasicPaginatedPokemonUseCase.getBasicPaginatedPokemon(offset: 0))
            .thenThrow('String error');

        await homeCubit.goToNextPage();

        expect(homeCubit.state, isA<FailureState>());
        final failure = homeCubit.state as FailureState;
        expect(failure.exception, isA<Exception>());
        expect(failure.exception.toString(), contains('String error'));
      });
    });

    group('updatePokemonExibition', () {
      test('should sort pokemons alphabetically when sortAlphabet is selected', () {
        final initialVo = HomeVo(
          listPokemons: [pokemonCharmander, pokemonBulbasaur, pokemonSquirtle],
          sortTypeEnum: HomeSortTypeEnum.sortId,
          isSearchModeEnabled: false,
        );
        final customCubit = HomeCubit(
          HomeState(currentPage: 0, isLoading: false, pokemonData: initialVo),
          getBasicPaginatedPokemonsUsecase: mockGetBasicPaginatedPokemonUseCase,
          getPokemonPerUrlUsecase: mockGetPokemonPerUrlUseCase,
        );

        customCubit.updatePokemonExibition(HomeSortTypeEnum.sortAlphabet);

        expect(customCubit.state.pokemonData?.sortTypeEnum, HomeSortTypeEnum.sortAlphabet);
        final list = customCubit.state.pokemonData?.listPokemons;
        expect(list?[0].name, 'Bulbasaur');
        expect(list?[1].name, 'Charmander');
        expect(list?[2].name, 'Squirtle');

        customCubit.close();
      });

      test('should sort pokemons by ID when sortId is selected', () {
        final initialVo = HomeVo(
          listPokemons: [pokemonSquirtle, pokemonBulbasaur, pokemonCharmander],
          sortTypeEnum: HomeSortTypeEnum.sortAlphabet,
          isSearchModeEnabled: false,
        );
        final customCubit = HomeCubit(
          HomeState(currentPage: 0, isLoading: false, pokemonData: initialVo),
          getBasicPaginatedPokemonsUsecase: mockGetBasicPaginatedPokemonUseCase,
          getPokemonPerUrlUsecase: mockGetPokemonPerUrlUseCase,
        );

        customCubit.updatePokemonExibition(HomeSortTypeEnum.sortId);

        expect(customCubit.state.pokemonData?.sortTypeEnum, HomeSortTypeEnum.sortId);
        final list = customCubit.state.pokemonData?.listPokemons;
        expect(list?[0].id, 1);
        expect(list?[1].id, 4);
        expect(list?[2].id, 7);

        customCubit.close();
      });

      test('should handle null pokemonData gracefully when updating exhibition', () {
        homeCubit.updatePokemonExibition(HomeSortTypeEnum.sortAlphabet);

        expect(homeCubit.state.pokemonData, isNull);
      });
    });
  });
}

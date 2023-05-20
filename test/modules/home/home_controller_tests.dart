import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_redirect_resource_response.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_response.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service_contract.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_basic_paginated_pokemons_usecase.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_pokemon_per_url_usecase.dart';

import 'home_controller_tests.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PokemonServiceContract>(),
])
void main() {
  late GetPokemonPerUrlUseCase mockGetPokemonPerUrlUsecase;
  late GetBasicPaginatedPokemonsUseCase mockBasicPaginatedPokemonsUseCase;
  late HomeStore homeStore;
  late HomeController homeController;
  late MockPokemonServiceContract mockPokemonServiceContract;

  final List<PokemonRedirectResourceResponse> fakeResource = List.from([
    PokemonRedirectResourceResponse(
      name: '',
      url: 'https://pokeapi.co/api/v2/pokemon/0/',
    ),
  ]);

  final PokemonResponse fakeResponse = PokemonResponse();

  final List<PokemonHomeVo> fakePokemonList = List.from([
    PokemonHomeVo(
      name: 'Kaede',
      moves: List.empty(),
      officialArtwork: '',
      weight: 65,
      types: List.empty(),
      stats: List.empty(),
      height: 160,
      id: 20,
    ),
    PokemonHomeVo(
      name: 'Yllo',
      moves: List.empty(),
      officialArtwork: '',
      weight: 65,
      types: List.empty(),
      stats: List.empty(),
      height: 160,
      id: 0,
    ),
  ]);

  group(('Home controller tests'), () {
    setUp(() {
      mockPokemonServiceContract = MockPokemonServiceContract();
      mockBasicPaginatedPokemonsUseCase = GetBasicPaginatedPokemonsUseCase(
          pokemonService: mockPokemonServiceContract);
      mockGetPokemonPerUrlUsecase =
          GetPokemonPerUrlUseCase(pokemonService: mockPokemonServiceContract);
      homeStore = HomeStore();
      homeController = HomeController(
        homeStore: homeStore,
        getBasicPaginatedPokemonsUsecase: mockBasicPaginatedPokemonsUseCase,
        getPokemonPerUrlUsecase: mockGetPokemonPerUrlUsecase,
      );
    });

    test('Verifing the loading of pages when is requested', () async {
      when(mockPokemonServiceContract.getBasicPaginatedPokemons(
              offset: homeStore.currentPage))
          .thenAnswer(
        (_) => Future.value(fakeResource),
      );
      when(
        mockPokemonServiceContract.getPokemonByUrl(
          url: fakeResource.first.url!,
        ),
      ).thenAnswer(
        (_) => Future.value(fakeResponse),
      );

      homeController.loadNewPage().whenComplete(() {
        expect(homeStore.currentPage, 10);
        expect(homeStore.currentPokemons.valueOrNull, isNotNull);
      });

      expect(homeController.homeStore.isLoadingNewPage, isTrue);
    });

    test('Verify sort method - Pokemon id', () {
      homeStore.currentPokemons.add(
        HomeVo(
          listPokemons: fakePokemonList,
          sortTypeEnum: HomeSortTypeEnum.sortId,
          isSearchModeEnabled: false,
        ),
      );

      homeController.changeFilterType(
        homeSortTypeEnum: HomeSortTypeEnum.sortId,
      );

      expect(homeStore.currentPokemons.valueOrNull, isNotNull);
      expect(homeStore.currentPokemons.value.listPokemons.first.id, 0);
    });

    test('Verify sort method - Pokemon alphabet', () {
      homeStore.currentPokemons.add(
        HomeVo(
          listPokemons: fakePokemonList,
          sortTypeEnum: HomeSortTypeEnum.sortAlphabet,
          isSearchModeEnabled: false,
        ),
      );

      homeController.changeFilterType(
        homeSortTypeEnum: HomeSortTypeEnum.sortAlphabet,
      );

      expect(homeStore.currentPokemons.valueOrNull, isNotNull);
      expect(homeStore.currentPokemons.value.listPokemons.first.id, 20);
    });
  });
}

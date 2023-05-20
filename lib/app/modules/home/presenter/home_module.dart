import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/pages/details_page.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/pages/home_page.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_basic_paginated_pokemons_usecase.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_pokemon_per_url_usecase.dart';

class HomeModule extends Module {
  @override
  static String route = '/home';

  @override
  List<Bind> binds = List.from([
    Bind.lazySingleton<GetBasicPaginatedPokemonsUseCase>(
      (i) => GetBasicPaginatedPokemonsUseCase(
        pokemonService: i(),
      ),
    ),
    Bind.lazySingleton<GetPokemonPerUrlUseCase>(
      (i) => GetPokemonPerUrlUseCase(
        pokemonService: i(),
      ),
    ),
    Bind.lazySingleton<HomeStore>(
      (i) => HomeStore(),
    ),
    Bind.lazySingleton<HomeController>(
      (i) => HomeController(
        homeStore: i(),
        getBasicPaginatedPokemonsUsecase: i(),
        getPokemonPerUrlUsecase: i(),
      ),
    ),
  ]);

  @override
  List<ModularRoute> get routes => List.from(
        [
          ChildRoute(
            Modular.initialRoute,
            child: (context, args) => const HomePage(),
          ),
          ChildRoute(
            route + DetailsPage.route,
            child: (context, args) => DetailsPage(initialPokemon: args.data as PokemonHomeVo),
          )
        ],
      );
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/pages/details_page.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/pages/home_page.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_basic_paginated_pokemons_usecase.dart';
import 'package:pokedex_challenge/domain/use_case/module/home/get_pokemon_per_url_usecase.dart';

import '../../../../data/modules/home/service/pokemon_service.dart';

class HomeModule extends Module {
  static String route = '/home';

  @override
  void binds(Injector i) {
    i.addLazySingleton<GetBasicPaginatedPokemonsUseCase>(
      () => GetBasicPaginatedPokemonsUseCase(pokemonService: Modular.get<PokemonService>()),
    );
    i.addLazySingleton<GetPokemonPerUrlUseCase>(
      () => GetPokemonPerUrlUseCase(pokemonService: Modular.get<PokemonService>()),
    );
    i.addLazySingleton<HomeStore>(() => HomeStore());
    i.addLazySingleton<HomeController>(
      () => HomeController(
        homeStore: Modular.get<HomeStore>(),
        getBasicPaginatedPokemonsUsecase: Modular.get<GetBasicPaginatedPokemonsUseCase>(),
        getPokemonPerUrlUsecase: Modular.get<GetPokemonPerUrlUseCase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const HomePage(),
    );
    r.child(
      route + DetailsPage.route,
      child: (context) => DetailsPage(
        initialPokemon: r.args.data as PokemonHomeVo,
      ),
    );
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/home_module.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<PokemonService>(
      () => PokemonService(),
    );
  }

  @override
  void routes(RouteManager r) {
    r.module(
      Modular.initialRoute,
      module: HomeModule(),
    );
  }
}

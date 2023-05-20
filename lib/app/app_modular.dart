import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/home_module.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service_contract.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => List.from(
        [
          Bind.lazySingleton<PokemonServiceContract>(
            (i) => PokemonService(),
          )
        ],
      );

  @override
  List<ModularRoute> get routes => List.from(
        [
          ModuleRoute(
            Modular.initialRoute,
            module: HomeModule(),
          ),
        ],
      );
}

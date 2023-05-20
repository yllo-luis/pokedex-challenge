import 'package:pokedex_challenge/data/modules/home/response/pokemon_response.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service_contract.dart';

class GetPokemonPerUrlUseCase {
  final PokemonServiceContract pokemonService;

  GetPokemonPerUrlUseCase({
    required this.pokemonService,
  });

  Future<PokemonResponse> getPokemonPerUrl({required String url}) async =>
      pokemonService.getPokemonByUrl(
        url: url,
      );
}

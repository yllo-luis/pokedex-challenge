import 'package:pokedex_challenge/data/modules/home/response/pokemon_redirect_resource_response.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_response.dart';

abstract class PokemonServiceContract {
  Future<List<PokemonRedirectResourceResponse>> getBasicPaginatedPokemons({
    int limit = 10,
    required int offset,
  });

  Future<PokemonResponse> getPokemonByUrl({required String url});
}

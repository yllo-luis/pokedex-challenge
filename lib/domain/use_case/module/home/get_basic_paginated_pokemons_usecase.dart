import 'package:pokedex_challenge/data/modules/home/response/pokemon_redirect_resource_response.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service_contract.dart';

class GetBasicPaginatedPokemonsUseCase {
  final PokemonServiceContract pokemonService;

  GetBasicPaginatedPokemonsUseCase({required this.pokemonService});

  Future<List<PokemonRedirectResourceResponse>> getBasicPaginatedPokemons({
    required int offset,
  }) async =>
      await pokemonService.getBasicPaginatedPokemons(offset: offset);
}

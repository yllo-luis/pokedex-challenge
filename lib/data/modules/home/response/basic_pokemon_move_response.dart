import 'package:pokedex_challenge/data/modules/home/response/pokemon_redirect_resource_response.dart';
import 'package:pokedex_challenge/domain/entity/basic_pokemon_move_entity.dart';

class BasicPokemonMoveResponse extends BasicPokemonMoveEntity {
  BasicPokemonMoveResponse({
    super.move,
  });

  factory BasicPokemonMoveResponse.fromJson(dynamic json) {
    return BasicPokemonMoveResponse(
      move: PokemonRedirectResourceResponse.fromJson(json['move']),
    );
  }
}

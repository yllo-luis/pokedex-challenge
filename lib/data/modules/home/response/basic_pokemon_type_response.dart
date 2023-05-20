import 'package:pokedex_challenge/core/utils/app_utils.dart';
import 'package:pokedex_challenge/domain/entity/basic_pokemon_type_entity.dart';

class BasicPokemonTypeResponse extends BasicPokemonTypeEntity {
  BasicPokemonTypeResponse({
    super.type,
  });

  factory BasicPokemonTypeResponse.fromJson(dynamic json) {
    return BasicPokemonTypeResponse(
      type: AppUtils.parseEnumFromJson(name: json['type']['name']),
    );
  }
}

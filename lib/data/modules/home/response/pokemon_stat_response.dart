import 'package:pokedex_challenge/core/utils/app_utils.dart';
import 'package:pokedex_challenge/domain/entity/pokemon_stat_entity.dart';

class PokemonStatResponse extends PokemonStatEntity {
  PokemonStatResponse({
    super.baseStat,
    super.effort,
    super.stat,
  });

  factory PokemonStatResponse.fromJson(dynamic json) {
    return PokemonStatResponse(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: AppUtils.parseStatsEnumFromJson(name: json['stat']['name'])
    );
  }
}

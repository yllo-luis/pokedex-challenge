import 'package:pokedex_challenge/core/constants/app_constants_utils.dart';
import 'package:pokedex_challenge/core/enums/pokemon_stats_enum.dart';
import 'package:pokedex_challenge/core/enums/pokemon_type_enum.dart';
import 'package:pokedex_challenge/core/extensions/string_utils.dart';
import 'package:pokedex_challenge/domain/entity/basic_pokemon_move_entity.dart';

class AppUtils {
  static PokemonTypeEnum parseEnumFromJson({required String name}) {
    return PokemonTypeEnum.values.lastWhere(
      (element) => element.name == name,
      orElse: () => PokemonTypeEnum.normal,
    );
  }

  static String parseEnumToName({required PokemonTypeEnum pokemonTypeEnum}) {
    String name = PokemonTypeEnum.values
        .lastWhere(
          (element) => element == pokemonTypeEnum,
        )
        .name;
    return name.upperCaseFirstLetter(target: name);
  }

  static PokemonStatsEnum parseStatsEnumFromJson({required String name}) {
    return PokemonStatsEnum.values.lastWhere(
      (element) => element.getApiName() == name,
    );
  }

  static String iterateHabilitiesAndConcat({
    required List<BasicPokemonMoveEntity> moves,
    bool shouldBeTotalLength = false,
  }) {
    String result = AppConstantsUtils.emptyString;

    for (int i = 0; i < (shouldBeTotalLength == true ? moves.length : 2); i++) {
      result =
          '$result\n${moves[i].move?.name ?? AppConstantsUtils.emptyString}';
    }
    return result;
  }
}

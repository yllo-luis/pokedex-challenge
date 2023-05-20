import 'dart:ui';

import 'package:pokedex_challenge/core/constants/app_constants_utils.dart';
import 'package:pokedex_challenge/core/enums/pokemon_stats_enum.dart';
import 'package:pokedex_challenge/core/enums/pokemon_type_enum.dart';
import 'package:pokedex_challenge/core/extensions/string_utils.dart';
import 'package:pokedex_challenge/domain/entity/basic_pokemon_move_entity.dart';

class AppUtils {
  static Color getCorrectColorPerPokemonType({
    required PokemonTypeEnum pokemonTypeEnum,
  }) {
    switch (pokemonTypeEnum) {
      case PokemonTypeEnum.normal:
        return const Color(0xFFAAA67F);
      case PokemonTypeEnum.fighting:
        return const Color(0xFFC12239);
      case PokemonTypeEnum.flying:
        return const Color(0xFFA891EC);
      case PokemonTypeEnum.ground:
        return const Color(0xFFDEC16B);
      case PokemonTypeEnum.poison:
        return const Color(0xFFA43E9E);
      case PokemonTypeEnum.rock:
        return const Color(0xFFB69E31);
      case PokemonTypeEnum.bug:
        return const Color(0xFFA7B723);
      case PokemonTypeEnum.ghost:
        return const Color(0xFF70559B);
      case PokemonTypeEnum.steel:
        return const Color(0xFFB7B9D0);
      case PokemonTypeEnum.fire:
        return const Color(0xFFF57D31);
      case PokemonTypeEnum.water:
        return const Color(0xFF6493EB);
      case PokemonTypeEnum.grass:
        return const Color(0xFF74CB48);
      case PokemonTypeEnum.electric:
        return const Color(0xFFF9CF30);
      case PokemonTypeEnum.psychic:
        return const Color(0xFFFB5584);
      case PokemonTypeEnum.ice:
        return const Color(0xFF9AD6DF);
      case PokemonTypeEnum.dragon:
        return const Color(0xFF7037FF);
      case PokemonTypeEnum.dark:
        return const Color(0xFF75574C);
      case PokemonTypeEnum.fairy:
        return const Color(0xFFE69EAC);
    }
  }

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
      (element) => element.name == name.replaceAll('-', '_'),
    );
  }

  static String parseStatsToTitleGraph({
    required PokemonStatsEnum pokemonTypeEnum,
  }) {
    switch (pokemonTypeEnum) {
      case PokemonStatsEnum.hp:
        return 'HP';
      case PokemonStatsEnum.attack:
        return 'ATK';
      case PokemonStatsEnum.defense:
        return 'DEF';
      case PokemonStatsEnum.special_attack:
        return 'SATK';
      case PokemonStatsEnum.special_defense:
        return 'SDEF';
      case PokemonStatsEnum.speed:
        return 'SPD';
    }
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

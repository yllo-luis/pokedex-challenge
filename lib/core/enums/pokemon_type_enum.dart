import 'dart:ui';

enum PokemonTypeEnum {
  normal,
  fighting,
  flying,
  ground,
  poison,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy
}

extension PokemonTypeEnumUtils on PokemonTypeEnum {
  Color getCorrectColorPerPokemonType() {
    switch (this) {
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
}

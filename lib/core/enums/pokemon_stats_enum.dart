enum PokemonStatsEnum {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
  speed,
}

extension PokemonStatsEnumUtils on PokemonStatsEnum {
  String getApiName() {
    switch (this) {
      case PokemonStatsEnum.hp:
        return "hp";
      case PokemonStatsEnum.attack:
        return "attack";
      case PokemonStatsEnum.defense:
        return "defense";
      case PokemonStatsEnum.specialAttack:
        return "special-attack";
      case PokemonStatsEnum.specialDefense:
        return "special-defense";
      case PokemonStatsEnum.speed:
        return "speed";
    }
  }

  String parseStatsToTitleGraph() {
    switch (this) {
      case PokemonStatsEnum.hp:
        return 'HP';
      case PokemonStatsEnum.attack:
        return 'ATK';
      case PokemonStatsEnum.defense:
        return 'DEF';
      case PokemonStatsEnum.specialAttack:
        return 'SATK';
      case PokemonStatsEnum.specialDefense:
        return 'SDEF';
      case PokemonStatsEnum.speed:
        return 'SPD';
    }
  }
}

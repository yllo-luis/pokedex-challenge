import 'package:pokedex_challenge/core/enums/pokemon_stats_enum.dart';

class PokemonStatEntity {
  final int? baseStat;
  final int? effort;
  final PokemonStatsEnum? stat;

  PokemonStatEntity({
    this.baseStat,
    this.effort,
    this.stat,
  });
}

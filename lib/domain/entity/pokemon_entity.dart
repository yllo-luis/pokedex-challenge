import 'package:pokedex_challenge/domain/entity/basic_pokemon_move_entity.dart';
import 'package:pokedex_challenge/domain/entity/pokemon_stat_entity.dart';
import 'package:pokedex_challenge/domain/entity/basic_pokemon_type_entity.dart';

class PokemonEntity {
  final int? height;
  final int? id;
  final List<BasicPokemonMoveEntity>? moves;
  final String? name;
  final List<PokemonStatEntity>? stats;
  final List<BasicPokemonTypeEntity>? types;
  final int? weight;
  final String? officialArtwork;

  PokemonEntity({
    this.height,
    this.id,
    this.moves,
    this.name,
    this.stats,
    this.types,
    this.weight,
    this.officialArtwork,
  });
}

import 'package:pokedex_challenge/domain/entity/pokemon_entity.dart';

class PokemonHomeVo extends PokemonEntity {
  PokemonHomeVo({
    super.id,
    super.height,
    super.moves,
    super.name,
    super.stats,
    super.types,
    super.weight,
    super.officialArtwork,
  });

  factory PokemonHomeVo.fromEntity({
    required PokemonEntity entity,
  }) {
    return PokemonHomeVo(
      id: entity.id,
      height: entity.height,
      moves: entity.moves,
      name: entity.name,
      stats: entity.stats,
      types: entity.types,
      weight: entity.weight,
      officialArtwork: entity.officialArtwork,
    );
  }

  PokemonHomeVo copyWith({
    required PokemonHomeVo pokemonHomeVo,
  }) {
    return PokemonHomeVo(
      id: pokemonHomeVo.id,
      height: pokemonHomeVo.height,
      moves: pokemonHomeVo.moves,
      name: pokemonHomeVo.name,
      stats: pokemonHomeVo.stats,
      types: pokemonHomeVo.types,
      weight: pokemonHomeVo.weight,
      officialArtwork: pokemonHomeVo.officialArtwork,
    );
  }
}

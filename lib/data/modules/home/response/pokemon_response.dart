import 'package:pokedex_challenge/data/modules/home/response/basic_pokemon_move_response.dart';
import 'package:pokedex_challenge/data/modules/home/response/basic_pokemon_type_response.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_stat_response.dart';
import 'package:pokedex_challenge/domain/entity/pokemon_entity.dart';

class PokemonResponse extends PokemonEntity {
  PokemonResponse({
    super.height,
    super.id,
    super.moves,
    super.name,
    super.stats,
    super.types,
    super.weight,
    super.officialArtwork,
  });

  factory PokemonResponse.fromJson({required dynamic json}) {
    return PokemonResponse(
      id: json['id'],
      height: json['height'],
      name: json['name'],
      moves: List<BasicPokemonMoveResponse>.from(json['moves']
          .map(
            (moves) => BasicPokemonMoveResponse.fromJson(moves),
          )
          .toList()),
      stats: List<PokemonStatResponse>.from(json['stats']
          .map(
            (stats) => PokemonStatResponse.fromJson(stats),
          )
          .toList()),
      types: List<BasicPokemonTypeResponse>.from(json['types']
          .map(
            (types) => BasicPokemonTypeResponse.fromJson(types),
          )
          .toList()),
      weight: json['weight'],
      officialArtwork: json['sprites']['other']['official-artwork']
          ['front_default'],
    );
  }
}

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';

class HomeVo {
  List<PokemonHomeVo> listPokemons;
  HomeSortTypeEnum sortTypeEnum;
  bool isSearchModeEnabled;

  HomeVo({
    required this.listPokemons,
    required this.sortTypeEnum,
    required this.isSearchModeEnabled,
  });

  HomeVo copyWith({
    List<PokemonHomeVo>? listPokemons,
    HomeSortTypeEnum? sortTypeEnum,
    bool? isSearchModeEnabled,
  }) {
    return HomeVo(
      listPokemons: listPokemons ?? this.listPokemons,
      sortTypeEnum: sortTypeEnum ?? this.sortTypeEnum,
      isSearchModeEnabled: isSearchModeEnabled ?? this.isSearchModeEnabled,
    );
  }
}

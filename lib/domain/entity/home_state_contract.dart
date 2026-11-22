import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';

abstract class HomeStateContract {
  final HomeVo? pokemonData;
  final int? currentPage;
  final bool? isLoading;

  HomeStateContract({this.pokemonData, this.currentPage, this.isLoading});
}

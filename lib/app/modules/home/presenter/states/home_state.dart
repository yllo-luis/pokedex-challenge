import 'package:pokedex_challenge/domain/entity/home_state_contract.dart';

import '../VOs/home_vo.dart';

class HomeState extends HomeStateContract {
  HomeState({super.pokemonData, super.currentPage = 0, super.isLoading});

  HomeState copyWith({HomeVo? pokemonData, int? currentPage, bool? isLoading}) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      pokemonData: pokemonData ?? this.pokemonData,
    );
  }

  factory HomeState.initial() {
    return HomeState(
      pokemonData: null,
      isLoading: false,
      currentPage: 0,
    );
  }
}

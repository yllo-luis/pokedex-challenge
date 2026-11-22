import 'package:pokedex_challenge/domain/entity/home_state_contract.dart';

import '../VOs/home_vo.dart';

class HomeState extends HomeStateContract {
  HomeState({super.pokemonData, super.currentPage = 0, super.isLoading});

  HomeState copyWith({HomeVo? pokemonDate, int? currentPage, bool? isLoading}) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      pokemonData: pokemonDate ?? this.pokemonData,
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

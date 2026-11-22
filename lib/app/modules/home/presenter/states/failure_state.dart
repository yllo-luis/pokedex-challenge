import 'package:pokedex_challenge/domain/entity/failure_state_contract.dart';
import 'home_state.dart';

class FailureState extends HomeState implements FailureStateContract {
  @override
  Exception? exception;

  FailureState({
    this.exception,
    super.pokemonData,
    super.currentPage,
    super.isLoading,
  });
}
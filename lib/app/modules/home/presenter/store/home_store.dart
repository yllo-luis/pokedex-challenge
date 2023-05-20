import 'dart:async';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';
import 'package:rxdart/rxdart.dart';

class HomeStore {
  int currentPage = 0;

  List<String> listOfUrlsToFetch = List.empty(growable: true);

  late BehaviorSubject<HomeVo> currentPokemons;


  bool isLoadingNewPage = false;

  HomeStore() {
    currentPokemons = BehaviorSubject();
  }

  Stream get getCurrentPokemons => currentPokemons.stream;
  StreamSink get getCurrentPokemonsSink => currentPokemons.sink;
}

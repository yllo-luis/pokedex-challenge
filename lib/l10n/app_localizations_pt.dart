// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get onErrorTitle => 'Parece que um erro critico ocorreu!';

  @override
  String get onErrorSubtitle =>
      'Estamos trabalhando o mais rápido possível para resolver o problema :3';

  @override
  String get onErrorOnLoadingTitle =>
      'Parece que ocorreu um erro enquanto carregavamos seus itens! Tente novamente mais tarde';

  @override
  String get appTitle => 'Pokédex';

  @override
  String get homeSearchBarHint => 'Pesquisar';

  @override
  String get homeSortDialogTitle => 'Ordenar por:';

  @override
  String get homeSortOptionId => 'Número';

  @override
  String get homeSortOptionName => 'Nome';

  @override
  String get homeDetailsAbout => 'Sobre';

  @override
  String get homeDetailsWeight => 'Peso';

  @override
  String get homeDetailsHeight => 'Altura';

  @override
  String get homeDetailsMoves => 'Jogadas';

  @override
  String get homeDetailsBaseStats => 'Estatísticas básicas';

  @override
  String get homePageLoadingNewPokemons => 'Carregando novos pokemons!';

  @override
  String get featureWillBeImplementedFuture =>
      'Este recurso será implementado no futuro!';
}

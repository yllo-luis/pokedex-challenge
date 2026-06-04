// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onErrorTitle => 'It seems that a critical error has occurred!';

  @override
  String get onErrorSubtitle =>
      'We are working as fast as possible to solve the problem :3';

  @override
  String get onErrorOnLoadingTitle =>
      'It looks like an error occurred while loading your items! Try again later';

  @override
  String get appTitle => 'Pokédex';

  @override
  String get homeSearchBarHint => 'Search';

  @override
  String get homeSortDialogTitle => 'Sort by:';

  @override
  String get homeSortOptionId => 'Number';

  @override
  String get homeSortOptionName => 'Name';

  @override
  String get homeDetailsAbout => 'About';

  @override
  String get homeDetailsWeight => 'Weight';

  @override
  String get homeDetailsHeight => 'Height';

  @override
  String get homeDetailsMoves => 'Moves';

  @override
  String get homeDetailsBaseStats => 'Base Stats';

  @override
  String get homePageLoadingNewPokemons => 'Loading new pokemons!';

  @override
  String get featureWillBeImplementedFuture =>
      'This feature will be implemented in the future!';
}

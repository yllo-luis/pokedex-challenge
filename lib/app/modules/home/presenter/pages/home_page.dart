import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_cubit.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/states/failure_state.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/states/home_state.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/widgets/home_searchbar.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/widgets/pokemon_container.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';
import 'package:pokedex_challenge/core/utils/widget_utils/neuphorfic_container.dart';

import '../../../../../core/constants/app_constants_utils.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widgets/home_dialogs.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeCubit = Modular.get<HomeCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        homeCubit.goToNextPage();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.appTitle ??
              AppConstantsUtils.emptyString,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        titleSpacing: 20,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/app_icons/bigger_pokeball.png',
          ),
        ),
        leadingWidth: 40,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: homeCubit,
        listener: (context, state) {
          if (state is FailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)?.onErrorOnLoadingTitle ??
                      AppConstantsUtils.emptyString,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return _MountPageBody(
            homeCubit: homeCubit,
            state: state,
          );
        },
      ),
    );
  }
}

class _MountPageBody extends StatelessWidget {
  final HomeCubit homeCubit;
  final HomeState state;

  const _MountPageBody({
    required this.homeCubit,
    required this.state,
  });

  List<PokemonHomeVo> get getPokemonsList =>
      state.pokemonData?.listPokemons ?? List.empty();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 16.0,
            right: 16.0,
            bottom: 24.0,
          ),
          child: Row(
            children: [
              const HomeSearchbar(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: () => HomeDialogs.showFilterDialog(
                    context: context,
                    value: state.pokemonData?.sortTypeEnum ??
                        HomeSortTypeEnum.sortAlphabet,
                    onChanged: (value) {
                      homeCubit.updatePokemonExibition(value);
                      Navigator.pop(context);
                    },
                  ),
                  child: NeumorphicContainer(
                    color: Colors.white,
                    child: Text(
                      state.pokemonData?.sortTypeEnum ==
                              HomeSortTypeEnum.sortAlphabet
                          ? 'A'
                          : '#',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            decoration: state.pokemonData?.sortTypeEnum ==
                                    HomeSortTypeEnum.sortAlphabet
                                ? TextDecoration.underline
                                : null,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 12.0,
              right: 12.0,
              bottom: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: AnimatedSwitcher(
              duration: AppConstantsUtils.defaultAnimationDuration,
              child: state.isLoading == false
                  ? NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        onLoadingNewPage(notification, context);
                        return true;
                      },
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.6),
                        ),
                        itemBuilder: (context, index) {
                          return PokemonContainer(
                            pokemonHomeVo: getPokemonsList[index],
                            // onTap: () => Modular.to.pushNamed(
                            //   HomeModule.route + DetailsPage.route,
                            //   arguments: getPokemonsList[index],
                            // ),
                            onTap: () => null,
                          );
                        },
                        padding: EdgeInsets.zero,
                        itemCount: getPokemonsList.length,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }

  void onLoadingNewPage(ScrollNotification notification, BuildContext context) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        homeCubit.state.isLoading == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.homePageLoadingNewPokemons ??
                AppConstantsUtils.emptyString,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );

      homeCubit.goToNextPage();
    }
  }
}

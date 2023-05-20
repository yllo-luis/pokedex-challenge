import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/home_module.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/widgets/home_searchbar.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/widgets/pokemon_container.dart';
import 'package:pokedex_challenge/core/enums/home_search_type_enum.dart';
import 'package:pokedex_challenge/core/utils/widget_utils/neuphorfic_container.dart';

import '../../../../../core/constants/app_constants_utils.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).appTitle,
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
      body: StreamBuilder<HomeVo>(
        stream: controller.homeStore.currentPokemons,
        builder: (context, pokemonListSnapshot) {
          if (pokemonListSnapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context).onErrorOnLoadingTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            );
          }
          return _mountPageBody(
            homeVo: pokemonListSnapshot.data,
            homeController: this.controller,
            isLoading:
                pokemonListSnapshot.connectionState == ConnectionState.waiting,
          );
        },
      ),
    );
  }
}

class _mountPageBody extends StatelessWidget {
  final HomeVo? homeVo;
  final HomeController homeController;
  final bool isLoading;

  const _mountPageBody({
    super.key,
    required this.homeVo,
    required this.homeController,
    this.isLoading = true,
  });

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
                  onTap: () => showFilterDialog(context),
                  child: NeumorphicContainer(
                    color: Colors.white,
                    child: Text(
                      homeVo?.sortTypeEnum == HomeSortTypeEnum.sortAlphabet
                          ? 'A'
                          : '#',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            decoration: homeVo?.sortTypeEnum ==
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
              child: isLoading == false
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
                            pokemonHomeVo: homeVo!.listPokemons[index],
                            onTap: () => Modular.to.pushNamed(
                              HomeModule.route + DetailsPage.route,
                              arguments: homeVo!.listPokemons[index],
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        itemCount: homeVo?.listPokemons.length ?? 0,
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
        homeController.homeStore.isLoadingNewPage == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).homePageLoadingNewPokemons,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
      homeController.loadNewPage();
    }
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppLocalizations.of(context).homeSortDialogTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RadioListTile<HomeSortTypeEnum>(
                  title: Text(
                    AppLocalizations.of(context).homeSortOptionId,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: HomeSortTypeEnum.sortId,
                  groupValue: homeController
                      .homeStore.currentPokemons.value.sortTypeEnum,
                  activeColor: Theme.of(context).scaffoldBackgroundColor,
                  onChanged: (HomeSortTypeEnum? value) {
                    homeController.changeFilterType(homeSortTypeEnum: value!);
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<HomeSortTypeEnum>(
                  title: Text(
                    AppLocalizations.of(context).homeSortOptionName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: HomeSortTypeEnum.sortAlphabet,
                  groupValue: homeController
                      .homeStore.currentPokemons.value.sortTypeEnum,
                  onChanged: (HomeSortTypeEnum? value) {
                    homeController.changeFilterType(homeSortTypeEnum: value!);
                    Navigator.pop(context);
                  },
                  activeColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

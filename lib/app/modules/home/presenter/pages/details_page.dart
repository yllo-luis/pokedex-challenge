import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/widgets/pokemon_details_chart.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/widgets/pokemon_details_data_container.dart';
import 'package:pokedex_challenge/core/constants/app_constants_utils.dart';
import 'package:pokedex_challenge/core/extensions/string_utils.dart';
import 'package:pokedex_challenge/core/utils/app_utils.dart';
import 'package:pokedex_challenge/core/utils/widget_utils/container_divider.dart';
import 'package:pokedex_challenge/core/utils/widget_utils/pill_container.dart';

class DetailsPage extends StatefulWidget {
  static const String route = '/details';

  final PokemonHomeVo initialPokemon;

  const DetailsPage({super.key, required this.initialPokemon});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final controller = Modular.get<HomeController>();
  final ScrollController scrollController = ScrollController();

  late Color currentColor = AppUtils.getCorrectColorPerPokemonType(
    pokemonTypeEnum: widget.initialPokemon.types!.first.type!,
  );

  late PokemonHomeVo currentPokemon = widget.initialPokemon;

  bool isFirst = false;
  bool isLast = false;

  @override
  void initState() {
    validatePosition();
    super.initState();
  }

  void validatePosition() {
    final List currentPokemons =
        controller.homeStore.currentPokemons.value.listPokemons;
    isFirst = currentPokemons.indexOf(currentPokemon) == 0;
    isLast =
        currentPokemons.indexOf(currentPokemon) == currentPokemons.length - 1;
  }

  void advanceToNextPokemon() {
    final List currentPokemons =
        controller.homeStore.currentPokemons.value.listPokemons;
    int currentIndex = currentPokemons.indexWhere(
      (element) => currentPokemon.id == element.id,
    );
    if (isLast == false) {
      setState(() {
        currentPokemon = currentPokemons[currentIndex + 1];
        currentColor = AppUtils.getCorrectColorPerPokemonType(
          pokemonTypeEnum: currentPokemon.types!.first.type!,
        );
        validatePosition();
      });
    }
  }

  void backToLastPokemon() {
    final List currentPokemons =
        controller.homeStore.currentPokemons.value.listPokemons;
    int currentIndex = currentPokemons.indexWhere(
      (element) => currentPokemon.id == element.id,
    );
    if (isFirst == false) {
      setState(() {
        currentPokemon = currentPokemons[currentIndex - 1];
        currentColor = AppUtils.getCorrectColorPerPokemonType(
          pokemonTypeEnum: currentPokemon.types!.first.type!,
        );
        validatePosition();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: AnimatedContainer(
          duration: AppConstantsUtils.defaultAnimationDuration,
          color: currentColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: _MountContainerBody(
                  pokemonHomeVo: currentPokemon,
                ),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: _MountPokeballIcon(),
              ),
              Positioned(
                top: 75,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                        onTap: () => setState(() => backToLastPokemon()),
                        child: AnimatedSwitcher(
                          duration: AppConstantsUtils.defaultAnimationDuration,
                          child: isFirst == false
                              ? const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.network(
                          currentPokemon.officialArtwork!,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => advanceToNextPokemon()),
                      child: AnimatedSwitcher(
                        duration: AppConstantsUtils.defaultAnimationDuration,
                        child: isLast == false
                            ? const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _MountTopBar(
                  pokemonHomeVo: currentPokemon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MountContainerBody extends StatelessWidget {
  final PokemonHomeVo pokemonHomeVo;

  const _MountContainerBody({
    required this.pokemonHomeVo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        4.0,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 54.0,
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: PillContainer(
                              textToShow: AppUtils.parseEnumToName(
                                pokemonTypeEnum:
                                    pokemonHomeVo.types![index].type!,
                              ),
                              colorToShow:
                                  AppUtils.getCorrectColorPerPokemonType(
                                pokemonTypeEnum:
                                    pokemonHomeVo.types![index].type!,
                              ),
                            ),
                          );
                        },
                        itemCount: pokemonHomeVo.types?.length ?? 0,
                      ),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).homeDetailsAbout,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppUtils.getCorrectColorPerPokemonType(
                          pokemonTypeEnum: pokemonHomeVo.types!.first.type!,
                        ),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _MountPokemonAbout(
                    pokemonHomeVo: pokemonHomeVo,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    AppLocalizations.of(context).homeDetailsBaseStats,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppUtils.getCorrectColorPerPokemonType(
                            pokemonTypeEnum: pokemonHomeVo.types!.first.type!,
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: PokemonDetailsChart(pokemonHomeVo: pokemonHomeVo),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MountPokemonAbout extends StatelessWidget {
  final PokemonHomeVo pokemonHomeVo;

  const _MountPokemonAbout({
    required this.pokemonHomeVo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PokemonDetailsDataContainer(
            title: AppLocalizations.of(context).homeDetailsWeight,
            data: pokemonHomeVo.weight.toString(),
            measure: 'Kg',
            icon: Icons.monitor_weight_outlined,
          ),
        ),
        const ContainerDivider(
          height: 60,
        ),
        Expanded(
          child: PokemonDetailsDataContainer(
            title: AppLocalizations.of(context).homeDetailsHeight,
            data: pokemonHomeVo.height.toString(),
            measure: 'm',
            icon: Icons.height,
          ),
        ),
        const ContainerDivider(
          height: 60,
        ),
        _MountPokemonMoves(
          pokemonHomeVo: pokemonHomeVo,
        )
      ],
    );
  }
}

class _MountPokemonMoves extends StatelessWidget {
  const _MountPokemonMoves({
    required this.pokemonHomeVo,
  });

  final PokemonHomeVo pokemonHomeVo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: 115,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              AppUtils.iterateHabilitiesAndConcat(
                moves: pokemonHomeVo.moves ?? List.empty(),
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
          Center(
            child: Text(
              AppLocalizations.of(context).homeDetailsMoves,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black.withOpacity(0.7),
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class _MountPokeballIcon extends StatelessWidget {
  const _MountPokeballIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 9.0,
      ),
      child: Opacity(
        opacity: 0.1,
        child: SvgPicture.asset(
          'assets/app_icons/Pokeball.svg',
        ),
      ),
    );
  }
}

class _MountTopBar extends StatelessWidget {
  final PokemonHomeVo pokemonHomeVo;

  const _MountTopBar({
    required this.pokemonHomeVo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Text(
            (pokemonHomeVo.name ?? AppConstantsUtils.emptyString)
                .upperCaseFirstLetter(
              target: pokemonHomeVo.name ?? AppConstantsUtils.emptyString,
            ),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(),
          Text(
            '#${pokemonHomeVo.id ?? 333}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

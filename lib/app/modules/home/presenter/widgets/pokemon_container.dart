import 'package:flutter/material.dart';

import 'package:pokedex_challenge/core/extensions/string_utils.dart';
import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/core/constants/app_constants_utils.dart';

class PokemonContainer extends StatelessWidget {
  final Function onTap;
  final PokemonHomeVo pokemonHomeVo;

  const PokemonContainer({
    super.key,
    required this.onTap,
    required this.pokemonHomeVo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    right: 8.0,
                  ),
                  child: Text(
                    '#${pokemonHomeVo.id ?? 333}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      (pokemonHomeVo.name ?? AppConstantsUtils.emptyString).upperCaseFirstLetter(target: pokemonHomeVo.name ?? AppConstantsUtils.emptyString),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: pokemonHomeVo.officialArtwork != null
                    ? Image.network(
                        pokemonHomeVo.officialArtwork!,
                        height: 60,
                      )
                    : Image.asset(
                        'assets/app_icons/placeholder_pokemon.png',
                        height: 60,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:pokedex_challenge/app/modules/home/presenter/VOs/pokemon_home_vo.dart';
import 'package:pokedex_challenge/core/constants/app_constants_utils.dart';
import 'package:pokedex_challenge/core/utils/app_utils.dart';

class PokemonDetailsChart extends StatelessWidget {
  const PokemonDetailsChart({
    super.key,
    required this.pokemonHomeVo,
  });

  final PokemonHomeVo pokemonHomeVo;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(
            show: false,
          ),
          alignment: BarChartAlignment.center,
          groupsSpace: 32,
          gridData: FlGridData(show: false),
          maxY: 500,
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 65,
              getTitlesWidget: (value, meta) {
                return _GetTitle(
                  pokemonHomeVo: pokemonHomeVo,
                  index: value.toInt(),
                );
              },
            )),
          ),
          barGroups: getBarGroups(),
        ),
        swapAnimationDuration: AppConstantsUtils.defaultAnimationDuration,
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    return List.generate(
      pokemonHomeVo.stats?.length ?? 0,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: pokemonHomeVo.stats![index].baseStat!.roundToDouble(),
              color: AppUtils.getCorrectColorPerPokemonType(
                pokemonTypeEnum: pokemonHomeVo.types!.first.type!,
              ),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                fromY: 0,
                toY: 500,
                color: AppUtils.getCorrectColorPerPokemonType(
                  pokemonTypeEnum: pokemonHomeVo.types!.first.type!,
                ).withOpacity(0.3),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GetTitle extends StatelessWidget {
  const _GetTitle({
    required this.pokemonHomeVo,
    required this.index,
  });

  final PokemonHomeVo pokemonHomeVo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: SizedBox(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                AppUtils.parseStatsToTitleGraph(
                  pokemonTypeEnum: pokemonHomeVo.stats![index].stat!,
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 12,
                      color: AppUtils.getCorrectColorPerPokemonType(
                        pokemonTypeEnum: pokemonHomeVo.types!.first.type!,
                      ),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              pokemonHomeVo.stats![index].baseStat!.toString(),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex_challenge/core/constants/app_constants_utils.dart';

class PokemonDetailsDataContainer extends StatelessWidget {
  final String title;
  final String data;
  final IconData? icon;
  final String? measure;

  const PokemonDetailsDataContainer({
    super.key,
    required this.title,
    required this.data,
    this.icon,
    this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: icon != null ? 12.0 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Offstage(
                    offstage: icon == null,
                    child: Icon(icon),
                  ),
                ),
                Text(
                  '${((double.tryParse(data) ?? 0) / 10)} ${measure ?? AppConstantsUtils.emptyString}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black.withOpacity(0.7),
                ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants_utils.dart';
import '../../../../../core/enums/home_search_type_enum.dart';
import '../../../../../l10n/app_localizations.dart';

class HomeDialogs {
  static Future<void> showFilterDialog(
      {required BuildContext context,
      required HomeSortTypeEnum value,
      required Function(HomeSortTypeEnum) onChanged}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppLocalizations.of(context)?.homeSortDialogTitle ??
                AppConstantsUtils.emptyString,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: RadioGroup<HomeSortTypeEnum>(
              groupValue: value,
              onChanged: (value) => value != null ? onChanged(value) : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RadioListTile<HomeSortTypeEnum>(
                    title: Text(
                      AppLocalizations.of(context)?.homeSortOptionId ??
                          AppConstantsUtils.emptyString,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    value: HomeSortTypeEnum.sortId,
                    activeColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  RadioListTile<HomeSortTypeEnum>(
                    title: Text(
                      AppLocalizations.of(context)?.homeSortOptionName ??
                          AppConstantsUtils.emptyString,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    value: HomeSortTypeEnum.sortAlphabet,
                    activeColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

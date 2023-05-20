import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSearchbar extends StatefulWidget {
  const HomeSearchbar({super.key});

  @override
  State<HomeSearchbar> createState() => _HomeSearchbarState();
}

class _HomeSearchbarState extends State<HomeSearchbar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        shadowColor: Colors.black,
        elevation: 10,
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            hintText: AppLocalizations.of(context).homeSearchBarHint,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}

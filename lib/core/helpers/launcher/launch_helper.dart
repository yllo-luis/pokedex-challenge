import 'package:url_launcher/url_launcher.dart';

import 'launcher_contract.dart';

class LaunchHelper implements LauncherContract {
  @override
  Future<void> launchCellPhone({required String numberToLaunch}) async {
    final phoneToLaunch = Uri(
      scheme: 'tel',
      path: numberToLaunch,
    );

    launchUrl(phoneToLaunch);
  }

  @override
  Future<void> launchUserBrowser({required Uri uriToLaunch}) async => await launchUrl(
    uriToLaunch
  );
}
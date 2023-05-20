extension StringUtils on String {
  String upperCaseFirstLetter({required String target}) {
    return target[0].toUpperCase() + target.substring(1);
  }
}
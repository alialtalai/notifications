enum Flavor {
  FIREBASE,
  HUAWEI,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.FIREBASE:
        return 'notifications';
      case Flavor.HUAWEI:
        return 'notifications';
      default:
        return 'title';
    }
  }

}

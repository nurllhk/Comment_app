import 'dart:io';

class AdHelper {
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4316948893098839/8167671300";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4316948893098839/8167671300";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }
  static String get openingAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4316948893098839/3701235692";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4316948893098839/3701235692";
    } else {
      throw new UnsupportedError("Unsupported Platform");
    }
  }

}
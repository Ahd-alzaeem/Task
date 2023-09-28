import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionChecker {
  static late ConnectivityResult connectivityResult = ConnectivityResult.none;
  static final Connectivity _connectivity = Connectivity();

  static bool get isConnected =>
      connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.ethernet;

  static Future<void> initConnectivity() async {
    connectivityResult = await _connectivity.checkConnectivity();

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectivityResult = result;
    });
  }
}

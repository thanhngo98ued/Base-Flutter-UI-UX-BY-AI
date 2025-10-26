import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> get isNetworkAvailable async {
  final result = await Connectivity().checkConnectivity();

  return _isNetworkAvailable(result);
}

Stream<bool> get onConnectivityChanged {
  return Connectivity().onConnectivityChanged.map((event) {
    return _isNetworkAvailable(event);
  });
}

bool _isNetworkAvailable(List<ConnectivityResult> result) {
  if (result.length == 1 && result.first == ConnectivityResult.none) {
    return false;
  }
  return true;
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImplementer implements NetworkInfo {
  NetworkInfoImplementer(this._connectivity);
  final Connectivity _connectivity;
  @override
  Future<bool> get isConnected =>
      _connectivity.checkConnectivity().then((value) {
        if (value.contains(ConnectivityResult.mobile) ||
            value.contains(ConnectivityResult.wifi)) {
          return true;
        } else {
          return false;
        }
      });
}

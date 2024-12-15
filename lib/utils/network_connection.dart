import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';


class NetworkConnection {

  bool connected = false;
  String cType = "none";
  StreamController connectionStatusController =  StreamController.broadcast();
  Stream get connectionChange => connectionStatusController.stream;

  static  final NetworkConnection _connectivity =  new NetworkConnection._internal();

  NetworkConnection._internal();

  factory NetworkConnection() => _connectivity;

  Connectivity connectivity = Connectivity();

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result != ConnectivityResult.wifi && result != ConnectivityResult.mobile) {
      connected = false;
    } else {
      connected = true;
    }
    connectivity.onConnectivityChanged.listen(checkConnectivity);
  }

  void dispose() {
    connectionStatusController.close();
  }

  Future<bool> isWifi() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return Future.value(result == ConnectivityResult.wifi);
  }

  checkConnectivity (result) {
    connectionStatusController.add(connected);
    if (result == ConnectivityResult.mobile) {
      cType = "MobileData";
    } else if (result == ConnectivityResult.wifi) {
      cType = "WifiNetwork";
    } else {
      cType = "none";
    }
    print("Connection Type :  $cType");

  }

  bool isConnected () => connected;



}
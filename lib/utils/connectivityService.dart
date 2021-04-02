import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectivityResult> connectionStatusController =
      StreamController<ConnectivityResult>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((result) {
      connectionStatusController.add(result);
    });
  }
}

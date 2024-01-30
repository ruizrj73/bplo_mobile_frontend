import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkConnectionController extends GetxController {
  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  RxBool hasInternetConnection = false.obs;

  Future<bool> checkConnectionStatus() async {
    bool ret = true;
    if (connectionStatus == null) {
      ret = false;
    } else {
      if (connectionStatus.value == ConnectivityResult.none) {
        ret = false;
      }
    }
    
    hasInternetConnection.value = ret;
    hasInternetConnection.refresh();
    return ret;
  }
}
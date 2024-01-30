// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  RxBool locationServiceEnabled = false.obs;
  
  requestPermission() async {
    await Permission.location.isGranted.then((_permission) async {
      if (!_permission) {
        await Permission.location.request().then((value) async {
          if (value == PermissionStatus.granted) {
            locationServiceEnabled.value = true;
          } else {
            locationServiceEnabled.value = false;
          }
        });
      }
    });
    
    await Permission.contacts.request();
  }
}
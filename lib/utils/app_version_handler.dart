import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionHandler extends GetxController{
  RxString packageVersion = "".obs;
  RxString packageBuildNumber = "".obs;
  RxString packageName = "".obs;

  Future<void> setAppVersion() async {
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      packageVersion.value = packageInfo.version;
      packageBuildNumber.value = packageInfo.buildNumber;
      packageName.value = packageInfo.packageName;
      refresh();
    });
  }
}
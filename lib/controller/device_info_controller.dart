import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

import '../utils/app_version_handler.dart';

class DeviceInfoController extends GetxController {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final AppVersionHandler appVersionHandler = Get.find();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  String deviceType = "";
  String osVersion = "";
  String deviceModel = "";
  String manufacturer = "";

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    } else if (Platform.isLinux) {
      deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
    } else if (Platform.isMacOS) {
      deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
    } else if (Platform.isWindows) {
      deviceData = _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    deviceType = "Android";
    osVersion = build.version.release;
    deviceModel = build.model;
    manufacturer = build.manufacturer;
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    deviceType = "IOS";
    osVersion = data.systemVersion;
    deviceModel = data.model;
    manufacturer = "Apple";
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
    };
  }

  void setDeviceOsVersion() {
    // saveDeviceInfo(
    //   manufacturer + " " + deviceModel, 
    //   deviceType, 
    //   osVersion, 
    //   appVersionHandler.packageVersion.value
    // );

    // getAppOsVersion().then((value) {
    //   if (value == "null") {
    //     addAppOsVersion();
    //   } else {
    //     var currVersion = jsonEncode(<String, Object>{
    //       "deviceType": deviceInfoController.deviceType,
    //       "appVersion": appVersionHandler.packageVersion.value,
    //       "appType": "Consumer",
    //       "userId": consumerController.userId.value,
    //       "userType": "Consumer",
    //       "osversion": deviceInfoController.osVersion,
    //       "deviceModel": deviceInfoController.deviceModel,
    //       "manufacturer": deviceInfoController.manufacturer
    //     });

    //     if (value != currVersion) {
    //       var prevVersion = jsonDecode(value);
    //       updateAppOsVersion(prevVersion["id"]);
    //     }
    //   }
    // });
  }
}
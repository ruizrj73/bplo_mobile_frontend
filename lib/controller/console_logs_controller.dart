import 'package:get/get.dart';

class ConsoleLogsController extends GetxController {
  Rx<LogsList> consoleLogs = LogsList().obs;

  @override
  void onInit() {
    super.onInit();

    consoleLogs.value.logs ??= [];
  }
}

class LogsList {
  List<String> logs = [];

  LogsList({this.logs});
}
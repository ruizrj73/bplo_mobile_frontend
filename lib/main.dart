// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lgu_bplo/controller/account_controller.dart';
import 'package:lgu_bplo/controller/device_info_controller.dart';
import 'package:lgu_bplo/controller/console_logs_controller.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/controller/permission_controller.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/firebase_options.dart';
import 'package:lgu_bplo/utils/app_version_handler.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/firebase_messaging_handler.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:lgu_bplo/view/account_option_view.dart';
import 'package:lgu_bplo/view/account_profile_view.dart';
import 'package:lgu_bplo/view/app_load_view.dart';
import 'package:lgu_bplo/view/business_application/business_application_view.dart';
import 'package:lgu_bplo/view/change_password_view.dart';
import 'package:lgu_bplo/view/create_account_view.dart';
import 'package:lgu_bplo/view/forgot_password_view.dart';
import 'package:lgu_bplo/view/help_center_view.dart';
import 'package:lgu_bplo/view/home_view.dart';
import 'package:lgu_bplo/view/inbox_view.dart';
import 'package:lgu_bplo/view/login_view.dart';
import 'package:lgu_bplo/view/message_detail_view.dart';
import 'package:lgu_bplo/view/otp_view.dart';
import 'package:lgu_bplo/view/privacy_policy_view.dart';
import 'package:lgu_bplo/view/reset_password_view.dart';
import 'package:lgu_bplo/view/terms_and_conditions_view.dart';
import 'package:lgu_bplo/view/transactions_view.dart';
import 'package:lgu_bplo/view/user_profile_view.dart';
import 'package:restart_app/restart_app.dart';

Future<void> main() async {
  await GetStorage.init();
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  initFirebase();

  runApp(MyApp());
}

initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    FirebaseMessagingHandler firebaseMessagingHandler = Get.find();
    print("Firebase initialized");

    firebaseMessagingHandler.initBackgroundMessageHandler();
    
    firebaseMessagingHandler.requestPermission();
    firebaseMessagingHandler.getToken();
  });
}

void configLoading() {
  EasyLoading.instance
    ..userInteractions = false
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 30.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = ThemeColor.primary
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.white.withOpacity(.5)
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String currentNetConnection = "";
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsBinding.instance?.addObserver(this);
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppVersionHandler appVersionHandler = Get.find();
      appVersionHandler.setAppVersion();
      // ignore: invalid_use_of_protected_member
      appVersionHandler.refresh();

      PermissionController permissionController = Get.find();
      permissionController.requestPermission();
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _connectivitySubscription?.cancel();

    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      currentNetConnection = result.toString();
    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    if (result == ConnectivityResult.none) {
      _updateConnectionStatus(result);
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    NetworkConnectionController networkConnectionController = Get.find();

    if (networkConnectionController != null) {
      networkConnectionController.connectionStatus.value = result;
    }

    String status = "";
    String msg = "";
    if (currentNetConnection == result.toString() && 
        result != ConnectivityResult.none) return;
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    currentNetConnection = result.toString();
    
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        if (Get.currentRoute == PageRoutes.AppLoad) {
          Restart.restartApp();
        }
        status = "You're now online.";
        msg = "Internet connection has been restored.";
        break;
      case ConnectivityResult.none:
        status = "You are currently offline.";
        msg = "Please connect to the internet.";
        break;
      default:
        status = 'Failed to get connectivity.';
        msg = "Internet connection issue.";
        break;
    }
    Get.snackbar(status, msg,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      colorText: Colors.white,
      backgroundColor: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        result == ConnectivityResult.none ? Feather.wifi_off : Feather.wifi,
        color: result == ConnectivityResult.none ? Colors.red : const Color(0xffFFDE00),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put<NetworkConnectionController>(NetworkConnectionController(), permanent: true);
    Get.put<ConsoleLogsController>(ConsoleLogsController(), permanent: true);
    Get.put<FileController>(FileController(), permanent: true);
    Get.put<PermissionController>(PermissionController(), permanent: true);
    Get.put<AccountController>(AccountController(), permanent: true);
    Get.put<MainController>(MainController(), permanent: true);
    Get.put<AppVersionHandler>(AppVersionHandler(), permanent: true);
    Get.put<DeviceInfoController>(DeviceInfoController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<FirebaseMessagingHandler>(FirebaseMessagingHandler(), permanent: true);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: NetworkBinding(),
      builder: EasyLoading.init(),
      title: Env.projectName,
      // theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.transparent
        ),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue
        ).copyWith(
          secondary: const Color(0xffFFDE00)
        )
      ),
      routingCallback: (Routing route) {
        if (route.isBack) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
      },
      getPages: [
        GetPage(name: PageRoutes.AppLoad, page: () => const AppLoadView()),
        GetPage(name: PageRoutes.Home, page: () => const HomeView()),
        GetPage(name: PageRoutes.Login, page: () => const LoginView()),
        GetPage(name: PageRoutes.CreateAccount, page: () => const CreateAccountView()),
        GetPage(name: PageRoutes.UserProfile, page: () => const UserProfileView()),
        GetPage(name: PageRoutes.ForgotPassword, page: () => const ForgotPasswordView()),
        GetPage(name: PageRoutes.ChangePassword, page: () => const ChangePasswordView()),
        // GetPage(name: PageRoutes.ChangeNumber, page: () => const ChangeNumberView()),
        GetPage(name: PageRoutes.ResetPassword, page: () => const ResetPasswordView()),
        GetPage(name: PageRoutes.Otp, page: () => const OtpView()),
        
        GetPage(name: PageRoutes.AccountInbox, page: () => const InboxView()),
        GetPage(name: PageRoutes.MessageDetail, page: () => const MessageDetailView()),
        GetPage(name: PageRoutes.AccountTransaction, page: () => const TransactionsView()),
        GetPage(name: PageRoutes.AccountOption, page: () => const AccountOptionView()),
        GetPage(name: PageRoutes.HelpCenter, page: () => const HelpCenterView()),
        GetPage(name: PageRoutes.PrivacyPolicy, page: () => const PrivacyPolicyView()),
        GetPage(name: PageRoutes.TermsOfService, page: () => const TermsAndConditionsView()),
        GetPage(name: PageRoutes.AccountProfile, page: () => const AccountProfileView()),
        // GetPage(name: PageRoutes.AccountActivity, page: () => const AccountActivityView()),
        // GetPage(name: PageRoutes.ActivityHistory, page: () => const ActivityHistoryView())

        GetPage(name: PageRoutes.BusinessPermitApplication, page: () => const BusinessApplicationView()),
      ],
      initialRoute: PageRoutes.AppLoad,
    );
  }
}
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  GetStorage storage = GetStorage();
  RxBool isLoggedIn = false.obs;

  void saveFirebaseToken(String token) {
    storage.write('FirebaseToken', token);
  }

  String getFirebaseToken() {
    String token = "";
    token = storage.hasData("FirebaseToken") ? storage.read("FirebaseToken") : "";
    return token;
  }

  void saveAccessToken(String token) {
    storage.write('AccessToken', token);
  }

  String getAccessToken() {
    String token = "";
    token = storage.hasData("AccessToken") ? storage.read("AccessToken") : "";
    return token;
  }

  void saveRefreshToken(String token) {
    storage.write('Token', token);
  }

  String getRefreshToken() {
    String token = "";
    token = storage.hasData("RefreshToken") ? storage.read("RefreshToken") : "";
    return token;
  }

  void saveUserId(String userId) {
    storage.write('UserId', userId);
  }

  String getUserId() {
    String userId = "";
    userId = storage.hasData("UserId") ? storage.read("UserId") : "";
    return userId;
  }

  void savePassword(String password) {
    storage.write('Password', password);
  }

  String getPassword() {
    String password = "";
    password = storage.hasData("Password") ? storage.read("Password") : "";
    return password;
  }

  void saveMobileNumber(String mobileNumber) {
    storage.write('MobileNumber', mobileNumber);
  }

  String getMobileNumber() {
    String mobileNumber = "";
    mobileNumber = storage.hasData("MobileNumber") ? storage.read("MobileNumber") : "";
    return mobileNumber;
  }

  void setIsLoggedIn(bool _isLoggedIn) {
    isLoggedIn.value = _isLoggedIn;
    storage.write('IsLoggedIn', _isLoggedIn);
  }

  bool getIsLoggedIn() {
    bool isLoggedIn = false;
    isLoggedIn = storage.hasData("IsLoggedIn") ? storage.read("IsLoggedIn") : false;
    return isLoggedIn;
  }

  Future<void> clearStorage() async {
    await storage.remove("AccessToken");
    await storage.remove("Token");
    await storage.remove("UserId");
    await storage.remove("Password");
    await storage.remove("MobileNumber");
    await storage.remove("IsLoggedIn");
  }
}
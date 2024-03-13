// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/model/message_model.dart';
import 'package:lgu_bplo/model/user_info.dart';

class UserController extends GetxController {
  UserInfo userInfo;
  RxString id = "".obs;
  RxString username = "".obs;
  RxString password = "".obs;
  RxString empId = "".obs;
  RxString firstname = "".obs;
  RxString middlename = "".obs;
  RxString lastname = "".obs;
  RxString suffix = "".obs;
  RxString email = "".obs;
  RxString contactnumber = "".obs;
  RxString userType = "".obs;
  RxString typeId = "".obs;
  RxString typeName = "".obs;
  RxBool hasNewMessage = false.obs;
  RxBool hasNewTransaction = false.obs;
  Rx<BusinessApplication> activeBusinessApplication = BusinessApplication().obs;
  Rx<BusinessApplication> selectedBusinessApplication = BusinessApplication().obs; // used for comparing previous and current entry (if not the same, popup confirmation)
  Rx<BusinessApplicationList> listBusinessApplication = BusinessApplicationList().obs;
  RxString applicationType = "New".obs;
  Rx<MessageList> listMessages = MessageList().obs;
  Rx<MessageModel> activeMessage = MessageModel().obs;

  setUserInfo(UserInfo _userInfo) => userInfo = _userInfo;
  setId(String _id) => id.value = _id;
  setUsername(String _username) => username.value = _username;
  setPassword(String _password) => password.value = _password;
  setEmpId(String _empId) => empId.value = _empId;
  setFirstName(String _firstname) => firstname.value = _firstname;
  setMiddleName(String _middlename) => middlename.value = _middlename;
  setLastName(String _lastname) => lastname.value = _lastname;
  setSuffix(String _suffix) => suffix.value = _suffix;
  setEmail(String _email) => email.value = _email;
  setContactNumber(String _contactnumber) => contactnumber.value = _contactnumber;
  setUserType(String _userType) => userType.value = _userType;
  setTypeId(String _typeId) => typeId.value = _typeId;
  setTypeName(String _typeName) => typeName.value = _typeName;

  UserInfo getUserInfo() => userInfo;
  String getId() => id.value;
  String getUsername() => username.value;
  String getPassword() => password.value;
  String getEmpId() => empId.value;
  String getFirstName() => firstname.value;
  String getMiddleName() => middlename.value;
  String getLastName() => lastname.value;
  String getSuffix() => suffix.value;
  String getEmail() => email.value;
  String getContactNumber() => contactnumber.value;
  String getUserType() => userType.value;
  String getTypeId() => typeId.value;
  String getTypeName() => typeName.value;
  String getFullName() {
    String _name = "";

    _name += firstname.value.capitalize;
    _name += middlename.value == "" ? "" : " ${middlename.value.substring(0,1).toUpperCase()}.";
    _name += " ${lastname.value.capitalize}";
    _name += suffix.value == "" ? "" : " ${suffix.value.capitalize}";

    return _name;
  }

  void clearState() {
    id.value = "";
    username.value = "";
    password.value = "";
    empId.value = "";
    firstname.value = "";
    middlename.value = "";
    lastname.value = "";
    suffix.value = "";
    email.value = "";
    contactnumber.value = "";
    userType.value = "";
    typeId.value = "";
    typeName.value = "";
  }
}
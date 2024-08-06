import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/model/app_status.dart';
import 'package:lgu_bplo/model/application_status_model.dart';
import 'package:lgu_bplo/model/application_type_model.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/model/business_type_model.dart';
import 'package:lgu_bplo/model/payment_mode_model.dart';
import 'package:lgu_bplo/model/setup_line_business_model.dart';
import 'package:lgu_bplo/utils/firebase_messaging_handler.dart';
import 'package:lgu_bplo/utils/local_db.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

class PreBackendCall {
  final UserController userController = Get.find();
  final NetworkConnectionController networkConnectionController = Get.find();
  final FirebaseMessagingHandler firebaseMessagingHandler = Get.find();

  Future<bool> pregetUserInfo(String userId) async {
    bool retVal = false;

    if (userController.getConnectivityStatus() == "Online") {
      await networkConnectionController.checkConnectionStatus().then((connResult) async {
        if (connResult) {
          await getUserInfo(userId.toString()).then((value) {
            if (value != "Fail" && userController.getId() != "") {
              firebaseMessagingHandler.saveToken();
              retVal = true;
            }
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localUserInfo(userId).then((data) {
        if (data != null) {
          userController.setUserInfo(data);
          userController.setId(data.id);
          userController.setUsername(data.username);
          userController.setEmpId(data.empId);
          userController.setFirstName(data.firstname);
          userController.setMiddleName(data.middlename);
          userController.setLastName(data.lastname);
          userController.setSuffix(data.suffix);
          userController.setEmail(data.email);
          userController.setContactNumber(data.contactnumber);
          userController.setUserType(data.userType);
          userController.setTypeId(data.typeId);
          userController.setTypeName(data.typeName);
          userController.setAllowOffline(data.allowOffline);
          userController.setAllowAttach(data.allowAttach);
          retVal = true;
        }
      });
    }

    return retVal;
  }

  Future<List<BusinessApplication>> pregetListTransaction() async {
    List<BusinessApplication> retVal = [];

    if (userController.getConnectivityStatus() == "Online") {
      await getListTransactions().then((res) {
        if (res != null) {
          res.forEach((p) {
            retVal.add(BusinessApplication.fromJson(p));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localBusinessApplication().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

  

  Future<bool> pregetAppStatus() async {
    return await LocalDB().localAppStatus().then((data) {
      if (data != null) {
        userController.setConnectivityStatus(data.connectivityStatus);
        userController.setAttachmentStatus(data.attachmentStatus);
      } else {
        userController.setConnectivityStatus("Online");
        userController.setAttachmentStatus("Allowed");
        LocalDB().localInsertAppStatus(AppStatus("", "Online", "Allowed"));
      }
      return true;
    });
  }

  Future<List<PaymentModeModel>> pregetListPaymentMode() async {
    List<PaymentModeModel> retVal = [];

    if (userController.getConnectivityStatus() == "Online") {
      await getListPaymentMode().then((res) {
        if (res != null) {
          LocalDB().deleteAllPaymentMode();
          res.forEach((x) {
            retVal.add(PaymentModeModel.fromJson(x));
            LocalDB().localInsertPaymentMode(PaymentModeModel.fromJson(x));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localPaymentMode().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

  Future<List<ApplicationStatusModel>> pregetListApplicationStatus() async {
    List<ApplicationStatusModel> retVal = [];
    
    if (userController.getConnectivityStatus() == "Online") {
      await getListApplicationStatus().then((res) {
        if (res != null) {
          LocalDB().deleteAllApplicationStatus();
          res.forEach((x) {
            retVal.add(ApplicationStatusModel.fromJson(x));
            LocalDB().localInsertApplicationStatus(ApplicationStatusModel.fromJson(x));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localApplicationStatus().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

  Future<List<ApplicationTypeModel>> pregetListApplicationType() async {
    List<ApplicationTypeModel> retVal = [];
    
    if (userController.getConnectivityStatus() == "Online") {
      await getListApplicationType().then((res) {
        if (res != null) {
          LocalDB().deleteAllApplicationType();
          res.forEach((x) {
            retVal.add(ApplicationTypeModel.fromJson(x));
            LocalDB().localInsertApplicationType(ApplicationTypeModel.fromJson(x));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localApplicationType().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

  Future<List<BusinessTypeModel>> pregetListBusinessType() async {
    List<BusinessTypeModel> retVal = [];
    
    if (userController.getConnectivityStatus() == "Online") {
      await getListBusinessType().then((res) {
        if (res != null) {
          LocalDB().deleteAllBusinessType();
          res.forEach((x) {
            retVal.add(BusinessTypeModel.fromJson(x));
            LocalDB().localInsertBusinessType(BusinessTypeModel.fromJson(x));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localBusinessType().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

  Future<List<SetupLineBusiness>> pregetListLineBusiness() async {
    List<SetupLineBusiness> retVal = [];
    
    if (userController.getConnectivityStatus() == "Online") {
      await getListLineBusiness().then((res) {
        if (res != null) {
          LocalDB().deleteAllSetupLineBusiness();
          res.forEach((x) {
            retVal.add(SetupLineBusiness.fromJson(x));
            LocalDB().localInsertSetupLineBusiness(SetupLineBusiness.fromJson(x));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localSetupLineBusiness().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

  Future<List<SetupLineBusiness>> pregetListMeasurePax() async {
    List<SetupLineBusiness> retVal = [];
    
    if (userController.getConnectivityStatus() == "Online") {
      await getListMeasurePax().then((res) {
        if (res != null) {
          LocalDB().deleteAllMeasurePax();
          res.forEach((x) {
            retVal.add(SetupLineBusiness.fromJson(x));
            LocalDB().localInsertMeasurePax(SetupLineBusiness.fromJson(x));
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      await LocalDB().localMeasurePax().then((data) {
        retVal = data;
      });
    }

    return retVal;
  }

}
import 'package:get/get.dart';
import 'package:lgu_bplo/model/application_status_model.dart';
import 'package:lgu_bplo/model/application_type_model.dart';
import 'package:lgu_bplo/model/business_type_model.dart';
import 'package:lgu_bplo/model/payment_mode_model.dart';

class MainController extends GetxController {
  RxInt bottomNavIndex = 0.obs;

  List<PaymentModeModel> listPaymentMode = [];
  List<ApplicationStatusModel> listApplicationStatus = [];
  List<ApplicationTypeModel> listApplicationType = [];
  List<BusinessTypeModel> listBusinessType = [];
}
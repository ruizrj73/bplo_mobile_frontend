// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class CreateAccountView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CreateAccountView();
  @override
  CreateAccountViewState createState() => CreateAccountViewState();
}

class CreateAccountViewState extends State<CreateAccountView> {
  UserController userController = Get.find();
  NetworkConnectionController networkConnectionController = Get.find();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _contactNoController = TextEditingController();

  @override
  void initState() {
    _firstNameController.text = userController.getFirstName();
    _middleNameController.text = userController.getMiddleName();
    _lastNameController.text = userController.getLastName();
    _suffixController.text = userController.getSuffix();
    _emailAddressController.text = userController.getEmail();
    _contactNoController.text = userController.getContactNumber() != "" ? userController.getContactNumber().substring(2, 11) : "";

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: buildPage(),
      onWillPop: () {
        userController.setFirstName("");
        userController.setMiddleName("");
        userController.setLastName("");
        userController.setSuffix("");
        userController.setEmail("");
        userController.setContactNumber("");
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ThemeColor.primary,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(10)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Register Account",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("First Name :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _firstNameController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Middle Name :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _middleNameController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Last Name :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _lastNameController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Suffix :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _suffixController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Email Address :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _emailAddressController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Contact Number :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 33,
                    child: TextField(
                      controller: _contactNoController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Text("+639 "),
                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        counterText: '',
                      ),
                      maxLength: 9,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: ThemeColor.primary,
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shadowColor: ThemeColor.secondary,
                elevation: 3,
              ),
              onPressed: () async {
                preRegister();
              },
              child: Text(
                'Continue',
                style: TextStyle(
                    color: ThemeColor.primaryText,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      )
    );
  }

  preRegister() {
    FocusScope.of(context).unfocus();
    if (_firstNameController.text.trim() == "") {
      popupDialog(context, NotifHeader.error, "Firstname must not be empty.");
      return;
    }
    if (_lastNameController.text.trim() == "") {
      popupDialog(context, NotifHeader.error, "Lastname must not be empty.");
      return;
    }
    if (_emailAddressController.text.trim() == "") {
      popupDialog(context, NotifHeader.error, "Email address must not be empty.");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailAddressController.text.trim())) {
      popupDialog(context, NotifHeader.error, "Invalid email address.");
      return;
    }
    if (_contactNoController.text.trim() == "") {
      popupDialog(context, NotifHeader.error, "Contact number must not be empty.");
      return;
    }
    if (_contactNoController.text.trim().length != 9) {
      popupDialog(context, NotifHeader.error, "Invalid contact number.");
      return;
    }
    if (double.tryParse(_contactNoController.text) == null) {
      popupDialog(context, NotifHeader.error, "Invalid contact number.");
      return;
    }

    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();
        isEmailMobileNoAvailable(_emailAddressController.text.trim(), "09" + _contactNoController.text.trim()).then((value) {
          if (value["resultSuccess"]) {
            if (!value["emailAvailable"]) {
              EasyLoading.dismiss();
              popupDialog(context, NotifHeader.error, "Email address already exist.");
              return;
            } else if (!value["mobileNoAvailable"]) {
              EasyLoading.dismiss();
              popupDialog(context, NotifHeader.error, "Mobile number already exist.");
              return;
            } else {
              EasyLoading.dismiss();
              userController.setFirstName(_firstNameController.text.trim());
              userController.setMiddleName(_middleNameController.text.trim());
              userController.setLastName(_lastNameController.text.trim());
              userController.setSuffix(_suffixController.text.trim());
              userController.setEmail(_emailAddressController.text.trim());
              userController.setContactNumber("09" + _contactNoController.text.trim());
              
              Get.back(result: true);
            }
          } else {
            EasyLoading.dismiss();
            popupDialog(context, NotifHeader.error, "There is a problem in checking account availability. Please try again.");
          }
        });
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }
}

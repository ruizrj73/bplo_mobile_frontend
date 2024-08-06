// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

import '../utils/env.dart';

class AccountProfileView extends StatefulWidget {
  const AccountProfileView();

  @override
  AccountProfileViewState createState() => AccountProfileViewState();
}

class AccountProfileViewState extends State<AccountProfileView> {
  final UserController userController = Get.find();
  int ticketCount = 0;
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userNumberController = TextEditingController();
  
  @override
  void initState() {
    _userNameController.text = userController.getFullName();
    _userEmailController.text = userController.getEmail();
    _userPasswordController.text = "**********";
    _userNumberController.text = userController.getContactNumber();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryBg,
      bottomSheet: Container(
        color: Env.copyrightBgColor,
        height: 100,
        child: Center(
          child: Text(
            Env.copyrightText,
            style: TextStyle(
              fontFamily: "Poppins",
              color: Env.copyrightColor,
              fontSize: Env.copyrightSize,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ThemeColor.primaryBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor.secondary),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
            child: Text(
              "My Account",
              style: TextStyle(
                  color: ThemeColor.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              textAlign: TextAlign.center
            )
          )
        ),
      ),
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  width: 130,
                  height: 150,
                  decoration: BoxDecoration(
                    color: ThemeColor.primaryBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: ThemeColor.secondary54,
                        offset: Offset(1,1)
                      )
                    ],
                    border: Border.all(
                      color: ThemeColor.primary,
                      width: 2
                    ),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/no-image-big.png")
                    )
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 24,
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Icon(
          //       Feather.check_square,
          //       color: ThemeColor.success,
          //     ),
          //     SizedBox(width: 4),
          //     Text(
          //       "Completed : ",
          //       style: TextStyle(
          //         fontFamily: "Poppins",
          //         color: ThemeColor.success,
          //         fontSize: 20,
          //         fontWeight: FontWeight.w800,
          //       ),
          //     ),
          //     Text(
          //       "0 Tickets",
          //       style: TextStyle(
          //         fontFamily: "Poppins",
          //         color: ThemeColor.secondary,
          //         fontSize: 20,
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 16,
          ),
          TextField(
            controller: _userNameController,
            textAlignVertical: TextAlignVertical.bottom,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Feather.user,
                color: ThemeColor.secondary,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
            )
          ),
          TextField(
            controller: _userEmailController,
            textAlignVertical: TextAlignVertical.bottom,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Feather.mail,
                color: ThemeColor.secondary,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
            )
          ),
          TextField(
            controller: _userPasswordController,
            textAlignVertical: TextAlignVertical.bottom,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Feather.lock,
                color: ThemeColor.secondary,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  // Get.toNamed(PageRoutes.ChangePassword);
                },
                child: Icon(
                  Feather.edit,
                  color: ThemeColor.secondary,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
            )
          ),
          TextField(
            controller: _userNumberController,
            textAlignVertical: TextAlignVertical.bottom,
            readOnly: true,
            inputFormatters: [
              MaskedInputFormatter(
                "000 000 0000",
                allowedCharMatcher: RegExp(r'[0-9]')
              )
            ],
            decoration: InputDecoration(
              prefixIcon: Icon(
                Feather.phone,
                color: ThemeColor.secondary,
              ),
              suffixIcon: InkWell(
                onTap: (() {
                  // requestChangeMobile(userController.getId()).then((value) {
                  //   if (value == "Success") {
                  //     Get.toNamed(PageRoutes.Otp).then((value) {
                  //       if (value) {
                  //         Get.toNamed(PageRoutes.ChangeNumber).then((value) {
                  //           setState(() {
                  //             _userNumberController.text = userController.getContactNo();
                  //           });
                  //         });
                  //       }
                  //     });
                  //   }
                  // });
                }),
                child: Icon(
                  Feather.edit,
                  color: ThemeColor.secondary,
                )
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: ThemeColor.disabled
                ), 
              ),
            )
          ),
        ],
      )
    );
  }

  Widget vehicleInfoView() {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12),
            Icon(
              Feather.truck,
              size: 28,
              color: ThemeColor.secondary,
            ),
            SizedBox(width: 12),
            Text(
              "vehicleInfo.make",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              )
            ),
          ],
        ),
        Divider(thickness: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12),
            Icon(
              Feather.truck,
              size: 28,
              color: ThemeColor.secondary,
            ),
            SizedBox(width: 12),
            Text(
              "vehicleInfo.model",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              )
            ),
          ],
        ),
        Divider(thickness: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12),
            ImageIcon(
              AssetImage("assets/images/plate-number.png"),
              size: 28,
            ),
            SizedBox(width: 12),
            Text(
              "vehicleInfo.plateNo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              )
            ),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }
}

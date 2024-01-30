// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class PrivacyPolicyView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const PrivacyPolicyView();
  @override
  PrivacyPolicyViewState createState() => PrivacyPolicyViewState();
}

class PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  void initState() {
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
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationView(context),
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor.primaryText),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                  width: 15,
                  child: Icon(
                    Feather.file_text, 
                    size: 15,
                    color: ThemeColor.primaryText,
                  )
                ),
                SizedBox(width: 8),
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                      color: ThemeColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w300
                    ),
                  textAlign: TextAlign.center
                ),
              ],
            )
          )
        ),
      ),
      body: SafeArea(
        child: bodyView(),
      )
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        child: Text("This is Privacy Policy Page"),
      )
    );
  }
}

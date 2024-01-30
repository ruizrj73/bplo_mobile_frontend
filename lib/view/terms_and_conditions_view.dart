// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class TermsAndConditionsView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TermsAndConditionsView();
  @override
  TermsAndConditionsViewState createState() => TermsAndConditionsViewState();
}

class TermsAndConditionsViewState extends State<TermsAndConditionsView> {
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
                    Feather.list, 
                    size: 15,
                    color: ThemeColor.primaryText,
                  )
                ),
                SizedBox(width: 8),
                Text(
                  "Terms & Conditions",
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Registration:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(MaterialIcons.play_arrow, size: 15),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width - 55,
                child: Text(
                  "The information provided is certified as true and correct.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(MaterialIcons.play_arrow, size: 15),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width - 55,
                child: Text(
                  "Registrant should validate their account by clicking the verification link sent to the supplied email address.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(MaterialIcons.play_arrow, size: 15),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width - 55,
                child: Text(
                  "Registrant should not create multiple false accounts.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(MaterialIcons.play_arrow, size: 15),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width - 55,
                child: Text(
                  "Registrant should keep their account credentials and will not share to anyone.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          SizedBox(height: 32),
          Text(
            "Disclaimer:",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(MaterialIcons.play_arrow, size: 15),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width - 55,
                child: Text(
                  "In accordance to R.A. 10173 or Data Privacy Act, all collected information will be treated with utmost confidentiality.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}

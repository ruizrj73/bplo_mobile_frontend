// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/env.dart';
import '../utils/theme_color.dart';

class HelpCenterView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HelpCenterView();
  @override
  HelpCenterViewState createState() => HelpCenterViewState();
}

class HelpCenterViewState extends State<HelpCenterView> {
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
        backgroundColor: ThemeColor.primary,
        elevation: 0,
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
                    Feather.help_circle, 
                    size: 15,
                    color: ThemeColor.primaryText,
                  )
                ),
                SizedBox(width: 8),
                Text(
                  "Help Center",
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
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/help-center.png")
              )
            )
          ),
          Center(
            child: Text(
              "Contact Us!",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w800),
            )
          ),
          SizedBox(height: 16),
          Divider(thickness: 1),
          InkWell(
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: "09953645231",
              );
              await launchUrl(launchUri);
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 50,
                    child: Icon(
                      Feather.phone, 
                      size: 20
                    )
                  ),
                  Text(
                    "+63 995 364 5231",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline
                    ),
                  )
                ],
              )
            )
          ),
          Divider(thickness: 1),
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 50,
                  child: Icon(
                    Feather.mail, 
                    size: 20
                  )
                ),
                Text(
                  "responsivcode@gmail.com",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.underline
                  ),
                )
              ],
            )
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}

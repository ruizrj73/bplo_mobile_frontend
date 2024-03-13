// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

Widget getDialogIcon(String state) {
  switch (state) {
    case NotifHeader.success:
      return Icon(Feather.check_circle, size: 30, color: getHeaderColor(state));
      break;
    case NotifHeader.error:
      return Icon(Feather.alert_triangle, size: 30, color: getHeaderColor(state));
      break;
    case NotifHeader.information:
      return Icon(Feather.alert_circle, size: 30, color: getHeaderColor(state));
      break;
    case NotifHeader.confirm:
      return Icon(Feather.help_circle, size: 30, color: getHeaderColor(state));
      break;
    default:
      return Icon(Feather.bell, size: 30, color: getHeaderColor(state));
      break;
  }
}

Color getHeaderColor(String state) {
  switch (state) {
    case NotifHeader.success:
      return ThemeColor.success;
      break;
    case NotifHeader.error:
      return ThemeColor.warning;
      break;
    case NotifHeader.information:
    case NotifHeader.confirm:
      return ThemeColor.primary;
      break;
    default:
      return ThemeColor.secondary;
      break;
  }
}

Future<String> popupDialog(BuildContext context, String headerText, message) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      title: Row(
        children: [
          getDialogIcon(headerText),
          SizedBox(width: 8),
          Text(headerText, style: TextStyle(color: getHeaderColor(headerText))),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          message,
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 12
          )
        ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 16, bottom: 8),
          child: Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.pop(context, 'OK'),
              child: Text(
                "OK", 
                style: TextStyle(
                  color: getHeaderColor(headerText), 
                  fontWeight: FontWeight.w800, 
                  decoration: TextDecoration.underline
                )
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Future<String> popupDialogConfirmCancel(BuildContext context, String headerText, message) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Container(),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          message,
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 12
          )
        ),
      ),
      actions: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: ThemeColor.primaryBg,
                  fixedSize: Size(130, 50),
                  foregroundColor: Colors.black,
                  shadowColor: Colors.black
                ),
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w800))
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: ThemeColor.primaryNavbarBg,
                  fixedSize: Size(130, 50),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () => Navigator.pop(context, 'Confirm'),
                child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.w800))
              )
            ],
          ),
        )
      ],
    ),
  );
}

Future<String> popupDialogYesNo(BuildContext context, String headerText, message, {String additionalHeader = "", additionalMessage = ""}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      title: Row(
        children: [
          getDialogIcon(headerText),
          SizedBox(width: 8),
          Text(headerText, style: TextStyle(color: getHeaderColor(headerText))),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 12
              )
            ),
            additionalHeader == "" && additionalMessage == "" ? Container() : SizedBox(height: 32),
            additionalHeader == "" ? Container() : Text(
              additionalHeader,
              style: TextStyle(
                fontFamily: "Poppins",
                color: ThemeColor.warning,
                fontSize: 14,
                fontWeight: FontWeight.w800
              )
            ),
            additionalHeader == "" ? Container() : SizedBox(height: 8),
            additionalMessage == "" ? Container() : Text(
              additionalMessage,
              style: TextStyle(
                fontFamily: "Poppins",
                color: ThemeColor.warning,
                fontSize: 12,
              )
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(right: 16, bottom: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context, 'No'),
                  child: Text(
                    "NO", 
                    style: TextStyle(
                      color: ThemeColor.warning, 
                      fontWeight: FontWeight.w800, 
                      decoration: TextDecoration.underline
                    )
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Container(
              padding: EdgeInsets.only(right: 16, bottom: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context, 'Yes'),
                  child: Text(
                    "YES", 
                    style: TextStyle(
                      color: getHeaderColor(headerText), 
                      fontWeight: FontWeight.w800, 
                      decoration: TextDecoration.underline
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<String> popupDialogCustom(BuildContext context, String headerText, message, button1Text, button2Text) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Stack(
        children: [
          Align(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Feather.x,
                size: 30
              ),
            ),
          ),
          Center(
            child: Text(
              headerText,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800
              )
            ),
          )
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          message,
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 12
          )
        ),
      ),
      actions: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: ThemeColor.primaryBg,
                  fixedSize: Size(130, 50),
                  foregroundColor: Colors.black,
                  shadowColor: Colors.black
                ),
                onPressed: () => Navigator.pop(context, button1Text),
                child: Text(
                  button1Text, 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800
                  )
                )
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: ThemeColor.primaryNavbarBg,
                  fixedSize: Size(130, 50),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () => Navigator.pop(context, button2Text),
                child: Text(
                  button2Text, 
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800
                  )
                )
              )
            ],
          ),
        )
      ],
    ),
  );
}

Future<String> exitDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      Future.delayed(Duration(milliseconds: 1300), () {
        Navigator.pop(context);
      });
      return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.all(10),
          backgroundColor: Colors.black54,
          content: Builder(
            builder: (context) {
              return SizedBox(
                height: 30,
                width: 230,
                child: Center(
                  child: Text(
                    'Press again to exit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                  )
                )
              );
            }
          )
        ),
      );
    },
  );
}

Future<String> popupImageDialog(BuildContext context, String imageUrl) {
  double width = MediaQuery.of(context).size.width - 80;
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context)
        .modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext,
        Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.width - 10,
          color: Colors.white,
          child: CachedNetworkImage(
            width: 100,
            height: 100,
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            placeholder: (context, url) => loadingImageView(
              width,
              width
            ),
            errorWidget: (context, url, error) => errorImageView()
          )
        )
      );
    }
  );
}

Widget loadingImageView(double _width, double _height) {
  return SizedBox(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade300,
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: Colors.white
        )
      )
    )
  );
}

Widget errorImageView() {
  return Image(image: AssetImage('assets/images/passafood.png'));
}
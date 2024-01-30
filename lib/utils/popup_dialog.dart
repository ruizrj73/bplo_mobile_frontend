// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

Future<String> popupDialog(BuildContext context, String headerText, message) {
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
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: ThemeColor.primaryNavbarBg,
              fixedSize: Size(MediaQuery.of(context).size.width, 50),
              foregroundColor: ThemeColor.primaryText,
              shadowColor: Colors.black
            ),
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w800))
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

Future<String> popupDialogYesNo(BuildContext context, String headerText, message) {
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
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('No', style: TextStyle(fontWeight: FontWeight.w800))
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
                onPressed: () => Navigator.pop(context, 'Yes'),
                child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.w800))
              )
            ],
          ),
        )
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
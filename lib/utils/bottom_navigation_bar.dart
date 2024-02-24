// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

MainController mainController = Get.find();

Widget bottomNavigationView(BuildContext context) {
  return Obx(() => BottomNavigationBar(
    backgroundColor: ThemeColor.primaryBg,
    type: BottomNavigationBarType.fixed,
    iconSize: 25,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(MaterialIcons.home, size: 25),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Stack(
          children: [
            Icon(MaterialIcons.mail, size: 25),
            Positioned(
              right: 0,
              child: Obx(() => Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: userController.hasNewMessage.value ? ThemeColor.warning : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 8,
                  minHeight: 8,
                ),
              )),
            ),
          ],
        ),
        label: 'Inbox',
      ),
      BottomNavigationBarItem(
        icon: Stack(
          children: [
            Icon(MaterialIcons.description, size: 25),
            Positioned(
              right: 0,
              child: Obx(() => Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: userController.hasNewTransaction.value ? ThemeColor.warning : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 8,
                  minHeight: 8,
                ),
              )),
            ),
          ],
        ),
        label: 'Transaction',
      ),
      BottomNavigationBarItem(
        icon: Icon(MaterialIcons.account_circle, size: 25),
        label: 'Account',
      ),
    ],
    currentIndex: mainController.bottomNavIndex.value,
    selectedItemColor: ThemeColor.primary,
    unselectedItemColor: ThemeColor.disabled,
    unselectedIconTheme: IconThemeData(
      color: ThemeColor.disabled,
    ),
    selectedIconTheme: IconThemeData(
      color: ThemeColor.primary,
    ),
    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 10),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    onTap: (index) {
      navigationItemSelection(index, context);
    },
  ));
}

void navigationItemSelection(int index, BuildContext context) {
  if (mainController.bottomNavIndex.value == index) return;
  if (mainController.bottomNavIndex.value != 0) {
    Navigator.pop(context);
  }
  mainController.bottomNavIndex.value = index;
  if (index == 0) return;

  switch (index) {
    case 0:
      Get.offAllNamed(PageRoutes.Home);
      break;
    case 1:
      Get.toNamed(PageRoutes.AccountInbox);
      break;
    case 2:
      Get.toNamed(PageRoutes.AccountTransaction);
      break;
    case 3:
      Get.toNamed(PageRoutes.AccountOption);
      break;
    default:
      break;
  }
}
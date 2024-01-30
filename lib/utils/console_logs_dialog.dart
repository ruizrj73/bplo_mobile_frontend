// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/console_logs_controller.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

Future<void> popupDialogConsoleLogs(BuildContext context, {String buttonText}) {
  final _consoleLogsController = TextEditingController();
  final ConsoleLogsController consoleLogsController = Get.find();
  _consoleLogsController.text = "";

  if (consoleLogsController.consoleLogs != null) {
    List<String> _logs = consoleLogsController.consoleLogs.value.logs ?? [];

    for (var _log in _logs) {
      _consoleLogsController.text += _log;
      _consoleLogsController.text += "\n";
    }
  }

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: ThemeColor.secondary,
      titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      actionsPadding: EdgeInsets.fromLTRB(16, 4, 16, 16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Logs",
            style: TextStyle(
              fontFamily: "Poppins",
              color: ThemeColor.secondaryText,
              fontSize: 16
            )
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context, null);
            }, 
            icon: Icon(Feather.x, color: ThemeColor.secondaryText)
          ),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 1020,
        color: ThemeColor.secondary,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: ThemeColor.success),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: ThemeColor.secondary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: ThemeColor.secondary),
                    ),
                  ),
                  controller: _consoleLogsController,
                  style: TextStyle(color: ThemeColor.secondaryText),
                  minLines: 46,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  readOnly: true,
                ),
              ),
            ]
          ),
        )
      ),
      actions: <Widget>[
      ],
    ),
  );
}
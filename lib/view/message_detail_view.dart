// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class MessageDetailView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MessageDetailView();
  @override
  MessageDetailViewState createState() => MessageDetailViewState();
}

class MessageDetailViewState extends State<MessageDetailView> {
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
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor.primaryText),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Message",
          style: TextStyle(
            color: ThemeColor.primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w300
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(MaterialIcons.delete, color: ThemeColor.primaryText),
            onPressed: () async {
              await deleteMessage(userController.activeMessage.value.id).then((res) {
                if (res == "Success") {
                  userController.listMessages.value.messages.removeWhere((m) => m.id == userController.activeMessage.value.id);
                  userController.listMessages.refresh();
                  Get.back();
                }
              });
            },
          )
        ],
      ),
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ThemeColor.primaryLighter,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      "BIN: ${userController.activeMessage.value.transaction_no}", 
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Text(
                      userController.activeMessage.value.business_name, 
                      style: TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.disabledText
                      ),
                    ),
                    Text(
                      userController.activeMessage.value.remarks, 
                      style: TextStyle(
                        fontSize: 10, 
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.disabled
                      ),
                    ),
                    Text(
                      userController.activeMessage.value.message, 
                      style: TextStyle(
                        fontSize: 12, 
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.warning
                      ),
                    ),
                    Text(
                      DateFormat("EEEE MMM dd, yyyy hh:mm:ss").format(userController.activeMessage.value.savedate),
                      style: TextStyle(
                        fontSize: 12, 
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ThemeColor.primary,
                shape: BoxShape.circle
              ),
              child: Icon(Feather.mail, color: ThemeColor.primaryText, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

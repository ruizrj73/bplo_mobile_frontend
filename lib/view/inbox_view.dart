// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/model/message_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

class InboxView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const InboxView();
  @override
  InboxViewState createState() => InboxViewState();
}

class InboxViewState extends State<InboxView> {
  bool isLoadingData = false;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    EasyLoading.show();
    setState(() {
      isLoadingData = true;
    });
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await getInbox().then((res) {
        List<MessageModel> inboxTempData = [];
        if (res != null) {
          res.forEach((p) {
            inboxTempData.add(MessageModel.fromJson(p));
          });
        }
        userController.listMessages.value.messages = inboxTempData;
        userController.listMessages.refresh();

        userController.hasNewMessage.value = (userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").isNotEmpty;
        userController.hasNewMessage.refresh();

        setState(() {
          isLoadingData = false;
        });
        EasyLoading.dismiss();
      });
    });
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
        mainController.bottomNavIndex.value = 0;
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
        leading: Container(),
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
                    MaterialIcons.mail, 
                    size: 15,
                    color: ThemeColor.primaryText,
                  )
                ),
                SizedBox(width: 8),
                Text(
                  "Inbox",
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
        child: RefreshIndicator(
          displacement: 10,
          backgroundColor: ThemeColor.primary,
          color: ThemeColor.primaryText,
          onRefresh: loadData,
          child: isLoadingData ? loadingBodyView() : bodyView()
        ),
      )
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 300,
        ),
        child: (userController.listMessages.value.messages ?? []).isEmpty ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height - 450) / 2
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: SvgPicture.asset('assets/images/no-records.svg'),
              ),
              Text(
                "No Records Found",
                style: TextStyle(
                    color: ThemeColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                textAlign: TextAlign.center
              ),
              SizedBox(height: 8),
              Text(
                "When you use our services, you'll see them here.",
                style: TextStyle(
                    color: ThemeColor.disabled,
                    fontSize: 12,
                  ),
                textAlign: TextAlign.center
              )
            ],
          ),
        ) :
        Obx(() => Column(
          children: [
            SizedBox(height: 4),
            (userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").isNotEmpty ?
            Align(
              alignment: Alignment.topRight,
              child: Text(
                (userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").length > 1 ?
                "${(userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").length} unread messages" :
                "${(userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").length} unread message",
                style: TextStyle(
                  fontSize: 10,
                  color: ThemeColor.disabled
                ),
              ),
            ) : Container(),
            SizedBox(height: 4),
            Column(
              children: <Widget>[...(userController.listMessages.value.messages ?? []).map((msg) =>
                InkWell(
                  onTap: (() {
                    if (msg.messageState == "Unread") {
                      markAsReadMessage(msg.id).then((value) {
                        setState(() {
                          msg.messageState = "Read";
                        });
                      });
                    }
                    userController.activeMessage.value = msg;
                    userController.listMessages.value.messages.firstWhere((m) => m.id == msg.id).messageState = "Read";

                    userController.hasNewMessage.value = (userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").isNotEmpty;
                    userController.hasNewMessage.refresh();

                    Get.toNamed(PageRoutes.MessageDetail);
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ThemeColor.primaryBg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(0),
                      ),
                      border: Border.all(
                        width: 1,
                        color: ThemeColor.primary,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          msg.messageState == "Unread" ? Icons.mark_email_unread : Icons.mark_email_read_outlined,
                          color: msg.messageState == "Unread" ? ThemeColor.secondary : ThemeColor.disabledText,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 85,
                          padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BIN: ${msg.transaction_no}", 
                                    style: TextStyle(
                                      fontSize: 12, 
                                      fontWeight: msg.messageState == "Unread" ? FontWeight.w800 : FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    getTimeGap(msg.savedate), 
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: ThemeColor.disabled
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                msg.remarks, 
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10, 
                                  color: ThemeColor.disabledText
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).toList()]
            ),
          ],
        )),
      ),
    );
  }

  Widget loadingBodyView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Color(0xffEFEFF4),
        highlightColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffEFEFF4),
          ),
        ),
      ),
    );
  }

  String getTimeGap(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(dateTime);
    if (diff.inSeconds == 1) {
      return "just now";
    } else if (diff.inSeconds > 1 && diff.inSeconds < 60) {
      return "${diff.inSeconds} seconds ago";
    } else if (diff.inSeconds >= 60 && diff.inSeconds < 120) {
      return "1 minute ago";
    } else if (diff.inSeconds >= 120 && diff.inSeconds < 3600) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inSeconds >= 3600 && diff.inSeconds < 7200) {
      return "1 hour ago";
    } else if (diff.inSeconds >= 7200 && diff.inSeconds < 86400) {
      return "${diff.inHours} hours ago";
    } else if (diff.inSeconds >= 86400 && diff.inSeconds < 172800) {
      return "Yesterday";
    } else if (diff.inSeconds >= 172800) {
      return "${diff.inDays} days ago";
    } else {
      return "just now";
    }
  }
}

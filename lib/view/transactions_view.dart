// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TransactionsView();
  @override
  TransactionsViewState createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
  bool isLoadingData = false;
  List<BusinessApplication> businessApplication = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoadingData = true;
    });
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await getListTransactions().then((res) {
        List<BusinessApplication> businessApplicationTemp = [];
        if (res != null) {
          res.forEach((p) {
            businessApplicationTemp.add(BusinessApplication.fromJson(p));
          });
        }
        setState(() {
          businessApplication = businessApplicationTemp;
          isLoadingData = false;
        });
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
                    MaterialIcons.description, 
                    size: 15,
                    color: ThemeColor.primaryText,
                  )
                ),
                SizedBox(width: 8),
                Text(
                  "Transaction",
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
          backgroundColor: Color(0xffFFDE00),
          color: Colors.black,
          onRefresh: loadData,
          child: isLoadingData ? loadingBodyView() : bodyView()
        ),
      )
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[...(businessApplication ?? []).map((businessApp) =>
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  color: ThemeColor.primaryBg,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: .5,
                    color: ThemeColor.disabled,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: ThemeColor.secondary.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container( // Transaction Status
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: ThemeColor.warning,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "W",
                          style: TextStyle(
                            color: ThemeColor.primaryText,
                            fontSize: 25,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BIN: ${businessApp.transaction_no}", 
                                style: TextStyle(
                                  fontSize: 14, 
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  
                                },
                                child: Container(
                                  width: 60,
                                  height: 18,
                                  decoration: new BoxDecoration(
                                    color: ThemeColor.warning,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Wait List",
                                      style: TextStyle(
                                        color: ThemeColor.primaryText,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            businessApp.business_name, 
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12, 
                              fontWeight: FontWeight.w800,
                              color: ThemeColor.disabledText
                            ),
                          ),
                          Text(
                            "Documentary requirements still waiting for approval", 
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10, 
                              color: ThemeColor.disabledText
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'You are marked as ',
                                  style: TextStyle(
                                    color: ThemeColor.secondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Waiting List',
                                  style: TextStyle(
                                    color: ThemeColor.warning,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          )
        ).toList()]
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
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffEFEFF4),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file = "";
// ignore_for_file: non_constant_identifier_names, prefer_collection_literals, unnecessary_new

class MessageModel {
  String id = "";
  String user_id = "";
  String user_name = "";
  String transaction_id = "";
  String transaction_no = "";
  String business_name = "";
  String transaction_type = "";
  String transaction_status = "";
  String message = "";
  String remarks = "";
  String messageState = "";
  String status = "";
  DateTime savedate = DateTime.now();

  MessageModel({
    this.id,
    this.user_id,
    this.user_name,
    this.transaction_id,
    this.transaction_no,
    this.business_name,
    this.transaction_type,
    this.transaction_status,
    this.message,
    this.remarks,
    this.messageState,
    this.status,
    this.savedate,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    user_id = json["user_id"];
    user_name = json["user_name"];
    transaction_id = json["transaction_id"];
    transaction_no = json["transaction_no"];
    business_name = json["business_name"];
    transaction_type = json["transaction_type"];
    transaction_status = json["transaction_status"];
    message = json["message"];
    remarks = json["remarks"];
    messageState = json["messageState"];
    status = json["status"];
    savedate = DateTime.parse(json["savedate"].toString().replaceAll("Z", ""));
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["user_id"] = user_id;
    data["user_name"] = user_name;
    data["transaction_id"] = transaction_id;
    data["transaction_no"] = transaction_no;
    data["business_name"] = business_name;
    data["transaction_type"] = transaction_type;
    data["transaction_status"] = transaction_status;
    data["message"] = message;
    data["remarks"] = remarks;
    data["messageState"] = messageState;
    data["status"] = status;
    data["savedate"] = savedate;
    return data;
  }
}

class MessageList {
  List<MessageModel> messages = [];

  MessageList({this.messages});

  MessageList.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages.add(MessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (messages != null) {
      data['messages'] =
          messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class AppStatus {
  String id = "";
  String connectivityStatus = "";
  String attachmentStatus = "";

  AppStatus(
    this.id,
    this.connectivityStatus,
    this.attachmentStatus,
  );

  AppStatus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    connectivityStatus = json["connectivityStatus"];
    attachmentStatus = json["attachmentStatus"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["connectivityStatus"] = connectivityStatus;
    data["attachmentStatus"] = attachmentStatus;
    return data;
  }
}
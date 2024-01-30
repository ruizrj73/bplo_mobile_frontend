// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class PaymentModeModel {
  String id = "";
  String code = "";
  String payment_type = "";

  PaymentModeModel(
    this.id,
    this.code,
    this.payment_type,
  );

  PaymentModeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    payment_type = json["payment_type"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["payment_type"] = payment_type;
    return data;
  }
}
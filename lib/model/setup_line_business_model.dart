// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class SetupLineBusiness {
  String id = "";
  String code = "";
  String description = "";

  SetupLineBusiness(
    this.id,
    this.code,
    this.description,
  );

  SetupLineBusiness.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    description = json["description"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["description"] = description;
    return data;
  }
}
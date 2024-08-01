// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class UserInfo {
  String id = "";
  String username = "";
  String password = "";
  String empId = "";
  String firstname = "";
  String middlename = "";
  String lastname = "";
  String suffix = "";
  String email = "";
  String contactnumber = "";
  String clusterGroup = "";
  String userType = "";
  String typeId = "";
  String typeName = "";

  UserInfo(
    this.id,
    this.username,
    this.password,
    this.empId,
    this.firstname,
    this.middlename,
    this.lastname,
    this.suffix,
    this.email,
    this.contactnumber,
    this.clusterGroup,
    this.userType,
    this.typeId,
    this.typeName,
  );

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    password = json["password"];
    empId = json["empId"];
    firstname = json["firstname"];
    middlename = json["middlename"];
    lastname = json["lastname"];
    suffix = json["suffix"];
    email = json["email"];
    contactnumber = json["contactnumber"];
    clusterGroup = json["clusterGroup"];
    userType = json["userType"];
    typeId = json["typeId"];
    typeName = json["typeName"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["username"] = username;
    data["password"] = password;
    data["empId"] = empId;
    data["firstname"] = firstname;
    data["middlename"] = middlename;
    data["lastname"] = lastname;
    data["suffix"] = suffix;
    data["email"] = email;
    data["contactnumber"] = contactnumber;
    data["clusterGroup"] = clusterGroup;
    data["userType"] = userType;
    data["typeId"] = typeId;
    data["typeName"] = typeName;
    return data;
  }
}
// https://app.quicktype.io/

import 'dart:convert';

class UserModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  String uniqueWebUserId;
  String userName;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String daysTillPasswordExpires;
  String createDate;
  String twoFactorEnabled;
  String roles;
  String carepointUserId;
  String issued;
  String expires;

  UserModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.uniqueWebUserId,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.daysTillPasswordExpires,
    this.createDate,
    this.twoFactorEnabled,
    this.roles,
    this.carepointUserId,
    this.issued,
    this.expires,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    refreshToken: json["refresh_token"],
    uniqueWebUserId: json["uniqueWebUserId"],
    userName: json["userName"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    daysTillPasswordExpires: json["daysTillPasswordExpires"],
    createDate: json["createDate"],
    twoFactorEnabled: json["twoFactorEnabled"],
    roles: json["roles"],
    carepointUserId: json["carepointUserId"],
    issued: json[".issued"],
    expires: json[".expires"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "refresh_token": refreshToken,
    "uniqueWebUserId": uniqueWebUserId,
    "userName": userName,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "daysTillPasswordExpires": daysTillPasswordExpires,
    "createDate": createDate,
    "twoFactorEnabled": twoFactorEnabled,
    "roles": roles,
    "carepointUserId": carepointUserId,
    ".issued": issued,
    ".expires": expires,
  };
}

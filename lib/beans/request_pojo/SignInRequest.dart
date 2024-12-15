class SignInRequest {
  String? deviceId;
  bool? rememberMeOnThisDevice;
  String? username;
  String? password;
  String? registerId;
  String? phone;
  String? otp;
  String? text;
  String? userAgent;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? loginToken;

  SignInRequest({
    this.deviceId,
    this.rememberMeOnThisDevice,
    this.username,
    this.password,
    this.registerId,
    this.phone,
    this.otp,
    this.text,
    this.userAgent,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.loginToken,
  });

  SignInRequest.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    rememberMeOnThisDevice = json['rememberMeOnThisDevice'];
    username = json['username'];
    password = json['password'];
    registerId = json['registerId'];
    phone = json['phone'];
    otp = json['otp'];
    text = json['text'];
    userAgent = json['userAgent'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailAddress = json['emailAddress'];
    loginToken = json['loginToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['rememberMeOnThisDevice'] = this.rememberMeOnThisDevice;
    data['username'] = this.username;
    data['password'] = this.password;
    data['registerId'] = this.registerId;
    data['phone'] = this.phone;
    data['otp'] = this.otp;
    data['text'] = this.text;
    data['userAgent'] = this.userAgent;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailAddress'] = this.emailAddress;
    data['loginToken'] = this.loginToken;
    return data;
  }
}

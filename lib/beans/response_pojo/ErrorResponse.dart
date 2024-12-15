class ErrorResponse {
  int? code;
  String? message;
  String? field;

  ErrorResponse({this.code, this.message, this.field});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    field = json['field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['field'] = this.field;
    return data;
  }
}

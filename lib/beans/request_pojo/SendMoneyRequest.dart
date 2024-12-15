class SendMoneyRequest {
  String? title;
  String? body;
  int? userId;

  SendMoneyRequest({this.title, this.body, this.userId});

  SendMoneyRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['userId'] = this.userId;
    return data;
  }
}

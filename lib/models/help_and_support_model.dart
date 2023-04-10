class HelpAndSupportModel {
  bool? status;
  String? message;
  Data? data;

  HelpAndSupportModel({this.status, this.message, this.data});

  HelpAndSupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? supportEmail;
  String? supportMobileMo;
  String? supportText;

  Data({this.supportEmail, this.supportMobileMo, this.supportText});

  Data.fromJson(Map<String, dynamic> json) {
    supportEmail = json['support_email'];
    supportMobileMo = json['support_mobile_mo'];
    supportText = json['support_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['support_email'] = this.supportEmail;
    data['support_mobile_mo'] = this.supportMobileMo;
    data['support_text'] = this.supportText;
    return data;
  }
}

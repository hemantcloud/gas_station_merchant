class DiscountListModel {
  bool? status;
  String? message;
  List<DiscountListData>? data;

  DiscountListModel({this.status, this.message, this.data});

  DiscountListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DiscountListData>[];
      json['data'].forEach((v) {
        data!.add(new DiscountListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiscountListData {
  int? id;
  String? userId;
  String? title;
  String? description;

  DiscountListData({this.id, this.userId, this.title, this.description});

  DiscountListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

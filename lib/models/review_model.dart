class ReviewModel {
  bool? status;
  String? message;
  Data? data;

  ReviewModel({this.status, this.message, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
  List<Ratings>? ratings;
  int? total;

  Data({this.ratings, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Ratings {
  int? id;
  String? customerId;
  String? merchantId;
  String? starRating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  String? customerName;

  Ratings(
      {this.id,
        this.customerId,
        this.merchantId,
        this.starRating,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.customerName});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    merchantId = json['merchant_id'];
    starRating = json['star_rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['merchant_id'] = this.merchantId;
    data['star_rating'] = this.starRating;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_name'] = this.customerName;
    return data;
  }
}

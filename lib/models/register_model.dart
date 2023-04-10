class RegisterModel {
  bool? status;
  String? message;
  Data? data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  UserData? userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? uniqueId;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? profileImage;
  List<int>? categoryIds;
  String? address1;
  Null? address2;
  String? city;
  String? state;
  String? zipCode;
  String? withdrawalFrequency;
  Null? mailingAddress;
  String? federalIdentifyNum;
  String? salesTaxIdentifyNum;
  String? isDelete;
  String? isBlocked;
  String? mobileVerify;
  String? emailVerify;
  Null? emailVerifiedAt;
  String? latitude;
  String? longitude;
  Null? about;
  String? timezone;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? authToken;

  UserData(
      {this.id,
        this.uniqueId,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.countryCode,
        this.profileImage,
        this.categoryIds,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zipCode,
        this.withdrawalFrequency,
        this.mailingAddress,
        this.federalIdentifyNum,
        this.salesTaxIdentifyNum,
        this.isDelete,
        this.isBlocked,
        this.mobileVerify,
        this.emailVerify,
        this.emailVerifiedAt,
        this.latitude,
        this.longitude,
        this.about,
        this.timezone,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.authToken});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    profileImage = json['profileImage'];
    categoryIds = json['category_ids'].cast<int>();
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    withdrawalFrequency = json['withdrawal_frequency'];
    mailingAddress = json['mailing_address'];
    federalIdentifyNum = json['federal_identify_num'];
    salesTaxIdentifyNum = json['sales_tax_identify_num'];
    isDelete = json['is_delete'];
    isBlocked = json['is_blocked'];
    mobileVerify = json['mobile_verify'];
    emailVerify = json['email_verify'];
    emailVerifiedAt = json['email_verified_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    about = json['about'];
    timezone = json['timezone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['country_code'] = this.countryCode;
    data['profileImage'] = this.profileImage;
    data['category_ids'] = this.categoryIds;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['withdrawal_frequency'] = this.withdrawalFrequency;
    data['mailing_address'] = this.mailingAddress;
    data['federal_identify_num'] = this.federalIdentifyNum;
    data['sales_tax_identify_num'] = this.salesTaxIdentifyNum;
    data['is_delete'] = this.isDelete;
    data['is_blocked'] = this.isBlocked;
    data['mobile_verify'] = this.mobileVerify;
    data['email_verify'] = this.emailVerify;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['about'] = this.about;
    data['timezone'] = this.timezone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['auth_token'] = this.authToken;
    return data;
  }
}

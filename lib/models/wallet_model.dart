class WalletModel {
  bool? status;
  String? message;
  Data? data;

  WalletModel({this.status, this.message, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? totalEarning;
  Walletbalance? walletbalance;
  TransactionHistory? transactionHistory;

  Data(
      {this.id,
        this.totalEarning,
        this.walletbalance,
        this.transactionHistory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalEarning = json['total_earning'];
    walletbalance = json['walletbalance'] != null
        ? new Walletbalance.fromJson(json['walletbalance'])
        : null;
    transactionHistory = json['transaction_history'] != null
        ? new TransactionHistory.fromJson(json['transaction_history'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_earning'] = this.totalEarning;
    if (this.walletbalance != null) {
      data['walletbalance'] = this.walletbalance!.toJson();
    }
    if (this.transactionHistory != null) {
      data['transaction_history'] = this.transactionHistory!.toJson();
    }
    return data;
  }
}

class Walletbalance {
  int? id;
  String? merchantId;
  String? balance;

  Walletbalance({this.id, this.merchantId, this.balance});

  Walletbalance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['merchant_id'] = this.merchantId;
    data['balance'] = this.balance;
    return data;
  }
}

class TransactionHistory {
  List<TransactionsWalletList>? list;
  int? total;

  TransactionHistory({this.list, this.total});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <TransactionsWalletList>[];
      json['list'].forEach((v) {
        list!.add(new TransactionsWalletList.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class TransactionsWalletList {
  int? id;
  String? marchantId;
  String? merchantUniqueid;
  String? title;
  String? amount;
  String? type;
  String? createdAt;
  String? updatedAt;

  TransactionsWalletList(
      {this.id,
        this.marchantId,
        this.merchantUniqueid,
        this.title,
        this.amount,
        this.type,
        this.createdAt,
        this.updatedAt});

  TransactionsWalletList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marchantId = json['marchant_id'];
    merchantUniqueid = json['merchant_uniqueid'];
    title = json['title'];
    amount = json['amount'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marchant_id'] = this.marchantId;
    data['merchant_uniqueid'] = this.merchantUniqueid;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

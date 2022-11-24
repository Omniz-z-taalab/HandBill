class AcountModel {
  List<AccountData>? data;
  bool? status;
  String? message;

  AcountModel({this.data, this.status, this.message});

  AcountModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AccountData>[];
      json['data'].forEach((v) {
        data!.add(new AccountData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class AccountData {
  String? title;
  String? titleAr;
  String? icon;
  List<Pages>? pages;

  AccountData({this.title, this.titleAr, this.icon, this.pages});

  AccountData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleAr = json['title_ar'];
    icon = json['icon'];
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['icon'] = this.icon;
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  String? title;
  String? titleAr;
  String? icon;

  Pages({this.title, this.titleAr, this.icon});

  Pages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleAr = json['title_ar'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['icon'] = this.icon;
    return data;
  }
}

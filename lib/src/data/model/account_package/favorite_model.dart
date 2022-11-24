import 'package:hand_bill/src/data/model/product.dart';

class FavoriteModel {
  int? id;
  String? userId;
  String? productId;
  Product? product;

  FavoriteModel({this.id, this.userId, this.productId, this.product});

  FavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    product =
    json['product'] != null ? new Product.fromJson(json["product"]) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
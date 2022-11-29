// class ShippingData {
//   int? id;
//   String? shippingType;
//   String? shippingPackageDetails;
//   String? shippingLeadTime;
//   String? shippingPort;
//   String? productId;
//   String? createdAt;
//   String? updatedAt;
//   Null? detailsAr;
//
//   ShippingData(
//       {this.id,
//         this.shippingType,
//         this.shippingPackageDetails,
//         this.shippingLeadTime,
//         this.shippingPort,
//         this.productId,
//         this.createdAt,
//         this.updatedAt,
//         this.detailsAr});
//
//   ShippingData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     shippingType = json['shipping_type'];
//     shippingPackageDetails = json['shipping_package_details'];
//     shippingLeadTime = json['shipping_lead_time'];
//     shippingPort = json['shipping_port'];
//     productId = json['product_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     detailsAr = json['details_ar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['shipping_type'] = this.shippingType;
//     data['shipping_package_details'] = this.shippingPackageDetails;
//     data['shipping_lead_time'] = this.shippingLeadTime;
//     data['shipping_port'] = this.shippingPort;
//     data['product_id'] = this.productId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['details_ar'] = this.detailsAr;
//     return data;
//   }
// }

import '../../model/about_us/aboutUsModel.dart';
import 'AboutResponse.dart';
class AboutUsResponse {
  List<Videos>? videos;
  List<Banners>? banners;
  // Null? pdf;

  AboutUsResponse({this.videos, this.banners});

  AboutUsResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    // pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    // data['pdf'] = this.pdf;
    return data;
  }
}
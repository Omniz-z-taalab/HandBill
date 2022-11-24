import 'package:flutter/material.dart';

class AboutUsModel {
  List<Videos>? videos;
  Null? video;
  List<Banners>? banners;

  AboutUsModel({this.videos, this.video, this.banners});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    video = json['video'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['video'] = this.video;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String? title;
  String? name;
  String? link;

  Videos({this.title, this.name, this.link});

  Videos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}

class Banners {
  String? image;

  Banners({
    this.image,
  });

  Banners.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;

    return data;
  }
}

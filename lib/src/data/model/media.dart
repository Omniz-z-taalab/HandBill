import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';

class Media {
  String? id;
  String? name;
  String? url;
  String? thumb;
  String? icon;
  String? size;

  Media({String? url, String? thumb, String? icon}) {
    this.url = url ?? "${APIData.domainLink}images/image_default.png";
    this.thumb = thumb ?? "${APIData.domainLink}images/image_default.png";
    this.icon = icon ?? "${APIData.domainLink}images/image_default.png";
  }

  Media.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      url = jsonMap['url'] ?? imageEx;
      thumb = jsonMap['thumb'];
      icon = jsonMap['icon'];
      size = jsonMap['formated_size'];
    } catch (e) {
      url = "${APIData.domainLink}images/image_default.png";
      thumb = "${APIData.domainLink}images/image_default.png";
      icon = "${APIData.domainLink}images/image_default.png";
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formated_size"] = size;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}

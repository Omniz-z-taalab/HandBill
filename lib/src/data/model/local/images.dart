import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';

class ImageModel {
  int? _id;
  String? _url;
  String? _thump;
  String? _icon;
  String? _modelId;


  int? get id => _id;

  String? get modelId => _modelId;


  String? get thump => _thump;

  String? get icon => _icon;

  String? get url => _url;


  ImageModel(
      {int? id,
      String? modelId,
      String? thump,
      String? icon,
      String? url,
      }) {
    _id = id;
    _modelId = modelId;

    _thump = thump;
    _icon = icon;
    _url = url;

  }

  ImageModel.fromJson(dynamic json) {
    _id = json["id"];
    _modelId = json["model_id"];

    _thump = json["thump"] == null
        ? placeholder
        : APIData.domainLink + json["thump"];
    _icon =
        json["icon"] == null ? placeholder : APIData.domainLink + json["icon"];
    _url =
        json["url"] == null ? placeholder : APIData.domainLink + json["url"];

  }

  Map<dynamic, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_id"] = _modelId;

    map["thump"] = _thump;
    map["icon"] = _icon;
    map["url"] = _url;

    return map;
  }
}

// for save to local without contation

class SaveImageModel {
  int? _id;
  String? _modelId;

  String? _thump;
  String? _icon;
  String? _url;

  int? get id => _id;

  String? get modelId => _modelId;


  String? get thump => _thump;

  String? get icon => _icon;

  String? get url => _url;



  SaveImageModel(
      {int? id,
        String? modelId,

        String? thump,
        String? icon,
        String? url,
        }) {
    _id = id;
    _modelId = modelId;

    _thump = thump;
    _icon = icon;
    _url = url;
  }

  SaveImageModel.fromJson(dynamic json) {
    try {
      _id = json["id"];
      _modelId = json["model_id"];

      _thump = json["thump"];
      _icon = json["icon"];
      _url = json["url"];
    } catch (e) {
      // _thump = APIData.domainLink + json["thump"];
      // _icon = APIData.domainLink + json["icon"];
      // _url = APIData.domainLink + json["url"];
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_id"] = _modelId;

    map["thump"] = _thump;
    map["icon"] = _icon;
    map["url"] = _url;

    return map;
  }
}

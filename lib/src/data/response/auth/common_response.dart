class CommonResponse {
  bool? _status;
  String? _message;

  bool? get status => _status;
  String? get message => _message;

  CommonResponse({
      bool? status, 
      String? message}){
    _status = status;
    _message = message;
}

  CommonResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    return map;
  }

}
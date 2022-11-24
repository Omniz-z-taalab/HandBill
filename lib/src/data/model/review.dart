import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'market.dart';

class Review {
  String? id;
  String? review;
  String? rate;
  User? user;

  Review();

  Review.init(this.rate);

  Review.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      review = jsonMap['review'];
      rate = jsonMap['rate'].toString();
      user = jsonMap['user'] != null
          ? User.fromJson(jsonMap['user'])
          : User.fromJson({});
    } catch (e) {
      id = '';
      review = '';
      rate = '0';
      user = User.fromJson({});
      print(e.toString());
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["review"] = review;
    map["rate"] = rate;
    map["user_id"] = user?.id;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }

  Map ofRestaurantToMap(Market market) {
    var map = this.toMap();
    map["restaurant_id"] = market.id;
    return map;
  }

  Map ofFoodToMap(Product product) {
    var map = this.toMap();
    map["food_id"] = product.id;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.marketId == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}

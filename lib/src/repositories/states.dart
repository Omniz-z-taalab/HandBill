abstract class ShopIntresStates {}

class ShopCubitIntialStates extends ShopIntresStates {}

class ShopIntresSuccessStates extends ShopIntresStates {}

class ShopIntresLoadingState extends ShopIntresStates {}

class ShopIntresErrorStates extends ShopIntresStates {
  final String error;
  ShopIntresErrorStates(this.error);
}

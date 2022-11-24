 class ShippingInitEvent{}
 class ShippingSliderEvent extends ShippingInitEvent{
 final String? id;
 ShippingSliderEvent(this.id);
 }
 class ShippingSliderServiceEvent extends ShippingInitEvent{

 }
 class ShippingSubCategoryEvent extends ShippingInitEvent{
  final String? id;
  ShippingSubCategoryEvent(this.id);
 }
 class ShippingCategoryServiceEvent extends ShippingInitEvent{
  final String? id;
  ShippingCategoryServiceEvent(this.id);
 }
 class ShippingSubSubCategoryEvent extends ShippingInitEvent{
  final String? id;
  ShippingSubSubCategoryEvent(this.id);
 }

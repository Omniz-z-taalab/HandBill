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
  final int? id;
  ShippingCategoryServiceEvent(this.id);
 }
 class CategoryFirstServiceEvent extends ShippingInitEvent{
  final String? id;
  CategoryFirstServiceEvent(this.id);
 }
 class ShippingSubSubCategoryEvent extends ShippingInitEvent{
  final String? id;
  ShippingSubSubCategoryEvent(this.id);
 }

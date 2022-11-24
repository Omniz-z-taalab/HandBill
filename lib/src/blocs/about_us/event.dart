import 'package:equatable/equatable.dart';

abstract class AboutUsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchaboutItemEvent extends AboutUsEvent {}

// class FetchSubCategoriesEvent extends AboutUsEvent {
//   final String categoryId;
//   final int? index;
//   FetchSubCategoriesEvent({required this.categoryId,this.index});
// }

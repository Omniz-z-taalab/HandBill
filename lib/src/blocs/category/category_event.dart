import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends CategoryEvent {}

class FetchSubCategoriesEvent extends CategoryEvent {
  final String categoryId;
  final int? index;
  FetchSubCategoriesEvent({required this.categoryId,this.index});
}

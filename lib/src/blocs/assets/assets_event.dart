import 'package:equatable/equatable.dart';

abstract class AssetsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch
class FetchAssetsEvent extends AssetsEvent {}


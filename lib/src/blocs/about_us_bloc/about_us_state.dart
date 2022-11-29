part of 'about_us_bloc.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object> get props => [];
}

class AboutUsInitial extends AboutUsState {}

class ShopIntresSuccessStates extends AboutUsState {}

class hopIntresErrorStates extends AboutUsState {
  String error;

  hopIntresErrorStates({required this.error});
}

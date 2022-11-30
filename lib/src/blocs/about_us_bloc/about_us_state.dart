part of 'about_us_bloc.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object> get props => [];
}

class AboutUsInitial extends AboutUsState {}

class AboutUsSuccessStates extends AboutUsState {
  final AboutResponse items;
  AboutUsSuccessStates(this.items){
    print('object');
    print('object${items.banners!.first!.id}');
  }
}

class hopIntresErrorStates extends AboutUsState {
  String error;

  hopIntresErrorStates({required this.error});
}

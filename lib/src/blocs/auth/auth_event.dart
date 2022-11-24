import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// login

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// register

class RegisterButtonPressed extends AuthEvent {
  final String name;
  final String namear;
  final String email;
  final String password;
  final String country;
  final String phone;
  final String confirimpassword;

  // final String natureactivity;
  // final String catgID;

  RegisterButtonPressed(
      {required this.name,
      required this.email,
      required this.password,
      required this.country,
      required this.confirimpassword,
      required this.phone, required this.namear});

  @override
  List<Object> get props =>
      [name, email, password, country, phone, confirimpassword,namear];
}

// rest password

class RestPasswordEvent extends AuthEvent {
  final String code;
  final String newPassword;

  RestPasswordEvent({required this.code, required this.newPassword});

  @override
  List<Object> get props => [code, newPassword];
}

//  verification code

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  ForgetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class CheckVerificationCodeEvent extends AuthEvent {
  final String code;

  CheckVerificationCodeEvent({required this.code});

  @override
  List<Object> get props => [code];
}

// fetch countries
class FetchCountriesEvent extends AuthEvent {}

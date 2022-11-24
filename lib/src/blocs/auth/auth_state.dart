import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/country_model.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String? error;

  AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// login

class LoginSuccess extends AuthState {
  final String? message;
  final User? user;

  LoginSuccess({this.message, this.user});
}

// register

class RegisterSuccess extends AuthState {
  final String? message;
  final User? user;

  RegisterSuccess({required this.message, required this.user});

  @override
  List<Object?> get props => [message];
}

// rest password

class RestPasswordSuccess extends AuthState {
  final String? message;

  RestPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
// forget password

class ForgetPasswordSuccess extends AuthState {
  final String? message;

  ForgetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CheckVerificationCodeSuccess extends AuthState {
  final String? message;

  CheckVerificationCodeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// get countries
class CountriesSuccessState extends AuthState {
  final List<CountryModel> items;

  CountriesSuccessState({required this.items});
}
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final User? user;

  ProfileSuccessState({required this.user});
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});
}

//// editProfile

class EditProfileLoadingState extends ProfileState {}

class EditProfileErrorState extends ProfileState {
  final String? error;

  EditProfileErrorState({required this.error});
}

class EditProfileSuccessState extends ProfileState {
  final User? user;
  final String? message;

  EditProfileSuccessState({required this.user, required this.message});
}

class ChangePasswordSuccessState extends ProfileState {
  final String? message;

  ChangePasswordSuccessState({required this.message});
}

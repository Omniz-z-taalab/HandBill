import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/user.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileFetchEvent extends ProfileEvent {
  final User user;

  ProfileFetchEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class EditProfileEvent extends ProfileEvent {
  final User? user;
  final File? image;

  EditProfileEvent({required this.user, this.image}){
    print('${user!.phone} + sdfdsfsdfdsfsdf');
  }

  @override
  List<Object?> get props => [user];
}

class ChangePasswordEvent extends ProfileEvent {
  final User? user;
  final String currentPassword;
  final String newPassword;

  ChangePasswordEvent(
      {required this.user,
      required this.currentPassword,
      required this.newPassword});

  @override
  List<Object?> get props => [user];
}

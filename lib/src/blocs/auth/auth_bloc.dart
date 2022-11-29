import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/data/model/country_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';
import 'package:hand_bill/src/data/response/auth/login_response_.dart';
import 'package:hand_bill/src/data/response/auth/register_response_.dart';
import 'package:hand_bill/src/data/response/auth/send_code_response.dart';
import 'package:hand_bill/src/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String tag = "AuthBloc";
  AuthRepository authRepository = AuthRepository();
  GlobalBloc? globalBloc;
  User? _user;
  List<CountryModel> countries = [];

  AuthBloc({required BuildContext context}) : super(AuthInitial()) {
    globalBloc = BlocProvider.of<GlobalBloc>(context);
    on<LoginEvent>(_mapLoginWithEmailToState);
    on<RegisterButtonPressed>(_mapRegisterToState);
    on<RestPasswordEvent>(_mapRestPasswordToState);
    on<ForgetPasswordEvent>(_mapSendVerificationCodeToState);
    on<CheckVerificationCodeEvent>(_mapCheckVerificationCodeToState);
    on<FetchCountriesEvent>(_mapFetchCountries);
  }

  // authInit() async {
  //   _user = User();
  //   _firebaseMessaging = FirebaseMessaging.instance;
  //   await _firebaseMessaging!.getToken().then((String? _deviceToken) {
  //     _user!.deviceToken = _deviceToken;
  //   }).catchError((e) {
  //     print("$tag $e");
  //   });
  // }

  // login
  void _mapLoginWithEmailToState(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // _user!.email = event.email;
    // _user!.password = event.password;
    LoginResponse? response;
    // try {
    //   if (_user!.deviceToken == null) {
    //     emit(uthFailure(error: "not device token"));
    //     return;
    //   } else {
    //     log("token ${_user!.deviceToken}");
    response =
        await authRepository.login(mail: event.email, password: event.password);
    if (response!.status!) {
      globalBloc!.user = response.data;
      authRepository.setCurrentUser(response.data);
      emit(LoginSuccess(message: response.message, user: response.data));
    } else {
      emit(AuthFailure(error: response.message));
    }

    // } catch (err, stack) {
    //   emit(uthFailure(error: err.toString()));
    //   print(err.toString() + stack.toString());
    // }
  }

  // register
  void _mapRegisterToState(
      RegisterButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    _user!.name = event.name;
    _user!.namear = event.namear;
    _user!.email = event.email;
    _user!.password = event.password;
    // _user!.password = event.password;
    _user!.confirmpassword = event.confirimpassword;
    _user!.country = event.country;
    print(_user!.country);
    print('111111111111111111111111');
    _user!.phone = event.phone;
    RegisterResponse? response;
    try {
      if (_user!.deviceToken == null) {
        emit(AuthFailure(error: "not device token"));
        return;
      } else {
        response = await authRepository.register(user: _user!);
        if (response!.status!) {
          globalBloc!.user = response.data;
          authRepository.setCurrentUser(response.data);
          emit(RegisterSuccess(message: response.message, user: response.data));
        } else {
          emit(AuthFailure(error: response.message));
        }
      }
    } catch (err) {
      emit(AuthFailure(error: err.toString()));
    }
  }

  //  rest password
  void _mapRestPasswordToState(
      RestPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      CommonResponse? response = await authRepository.restPassword(
          code: event.code, newPassword: event.newPassword);
      if (response!.status!) {
        emit(RestPasswordSuccess(message: response.message));
      } else {
        emit(AuthFailure(error: response.message));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  //  forget password
  void _mapSendVerificationCodeToState(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      CommonResponse? response =
          await authRepository.forgetPassword(event.email);
      if (response!.status!) {
        emit(ForgetPasswordSuccess(message: response.message));
      } else {
        emit(AuthFailure(error: response.message));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _mapCheckVerificationCodeToState(
      CheckVerificationCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      SendCodeResponse? response =
          await authRepository.checkVerificationCode(event.code);
      if (response!.status!) {
        emit(CheckVerificationCodeSuccess(message: response.message));
      } else {
        emit(AuthFailure(error: response.message));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  // fetch countries
  void _mapFetchCountries(
      FetchCountriesEvent event, Emitter<AuthState> emit) async {
    try {
      if (countries == [] || countries.length == 0) {
        emit(AuthLoading());
        final response = await authRepository.fetchCountriesData();
        countries = response!.data!;
        if (response.status!) {
          emit(CountriesSuccessState(items: response.data!));
        } else {
          emit(AuthFailure(error: response.message.toString()));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

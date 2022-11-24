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
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // await authInit();
    if (event is LoginEvent) {
      yield* _mapLoginWithEmailToState(event);
    }
    if (event is RegisterButtonPressed) {
      yield* _mapRegisterToState(event);
    }
    if (event is RestPasswordEvent) {
      yield* _mapRestPasswordToState(event);
    }
    if (event is ForgetPasswordEvent) {
      yield* _mapSendVerificationCodeToState(event);
    }
    if (event is CheckVerificationCodeEvent) {
      yield* _mapCheckVerificationCodeToState(event);
    }
    if (event is FetchCountriesEvent) {
      yield* _mapFetchCountries(event);
    }
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
  Stream<AuthState> _mapLoginWithEmailToState(LoginEvent event) async* {
    yield AuthLoading();
    // _user!.email = event.email;
    // _user!.password = event.password;
    LoginResponse? response;
    // try {
    //   if (_user!.deviceToken == null) {
    //     yield AuthFailure(error: "not device token");
    //     return;
    //   } else {
    //     log("token ${_user!.deviceToken}");
        response = await authRepository.login(mail: event.email,password: event.password);
        if (response!.status!) {
          globalBloc!.user = response.data;
          authRepository.setCurrentUser(response.data);
          yield LoginSuccess(message: response.message, user: response.data);
        } else {
          yield AuthFailure(error: response.message);
        }

    // } catch (err, stack) {
    //   yield AuthFailure(error: err.toString());
    //   print(err.toString() + stack.toString());
    // }
  }

  // register
  Stream<AuthState> _mapRegisterToState(RegisterButtonPressed event) async* {
    yield AuthLoading();
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
        yield AuthFailure(error: "not device token");
        return;
      } else {
        response = await authRepository.register(user: _user!);
        if (response!.status!) {
          globalBloc!.user = response.data;
          authRepository.setCurrentUser(response.data);
          yield RegisterSuccess(message: response.message, user: response.data);
        } else {
          yield AuthFailure(error: response.message);
        }
      }
    } catch (err) {
      yield AuthFailure(error: err.toString());
    }
  }

  //  rest password
  Stream<AuthState> _mapRestPasswordToState(RestPasswordEvent event) async* {
    yield AuthLoading();
    try {
      CommonResponse? response = await authRepository.restPassword(
          code: event.code, newPassword: event.newPassword);
      if (response!.status!) {
        yield RestPasswordSuccess(message: response.message);
      } else {
        yield AuthFailure(error: response.message);
      }
    } catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  //  forget password
  Stream<AuthState> _mapSendVerificationCodeToState(
      ForgetPasswordEvent event) async* {
    yield AuthLoading();
    try {
      CommonResponse? response =
          await authRepository.forgetPassword(event.email);
      if (response!.status!) {
        yield ForgetPasswordSuccess(message: response.message);
      } else {
        yield AuthFailure(error: response.message);
      }
    } catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _mapCheckVerificationCodeToState(
      CheckVerificationCodeEvent event) async* {
    yield AuthLoading();
    try {
      SendCodeResponse? response =
          await authRepository.checkVerificationCode(event.code);
      if (response!.status!) {
        yield CheckVerificationCodeSuccess(message: response.message);
      } else {
        yield AuthFailure(error: response.message);
      }
    } catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  // fetch countries
  Stream<AuthState> _mapFetchCountries(FetchCountriesEvent event) async* {
    try {
      if (countries == [] || countries.length == 0) {
        yield AuthLoading();
        final response = await authRepository.fetchCountriesData();
        countries = response!.data!;
        if (response.status!) {
          yield CountriesSuccessState(items: response.data!);
        } else {
          yield AuthFailure(error: response.message.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

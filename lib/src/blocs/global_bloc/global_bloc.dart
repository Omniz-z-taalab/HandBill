import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/repositories/global_repository.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  User? user;
  String? lang ;
  final GlobalRepository globalRepository = GlobalRepository();

  GlobalBloc() : super(GlobalInitial()) {
    on<StartAppEvent>(_mapStartAppToState);
    on<SaveLanguageEvent>(saveLanguageToState);
    on<UserStatusChangeEvent>(_mapUserStatusChangeToState);
  }

  void saveLanguageToState(
      SaveLanguageEvent event, Emitter<GlobalState> emit) async {
    emit(GlobalLoading());
    String? _lang;
    _lang = await globalRepository.getLanguage();
    if (_lang == null) {
      lang = null;
    } else {
      lang = _lang;
      log("AppLanguage ${lang}");
    }
    emit(SaveLanguageState());
  }

  void _mapStartAppToState(
      StartAppEvent event, Emitter<GlobalState> emit) async {
    emit(GlobalLoading());
    User? _user;
    _user = await globalRepository.getCurrentUser();
    if (_user == null) {
      user = null;
    } else {
      user = _user;
      log("token ${user!.apiToken}");
    }
    emit(StartAppSuccess(user: _user));
  }

  void _mapUserStatusChangeToState(
      UserStatusChangeEvent event, Emitter<GlobalState> emit) async {
    emit(GlobalLoading());
    User? _user = await globalRepository.getCurrentUser();
    if (_user == null) {
      user = null;
      emit(UserStatusChangeSuccess());
    } else {
      user = _user;
      emit(UserStatusChangeSuccess());
    }
  }
}

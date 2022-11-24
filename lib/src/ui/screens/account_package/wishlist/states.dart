abstract class AccountState {}

class CubitIntialStates extends AccountState {}

class AccountSuccessStates extends AccountState {}

class AcoountLoadingState extends AccountState {}

class AcoountErrorStates extends AccountState {
  final String error;
  AcoountErrorStates(this.error);
}

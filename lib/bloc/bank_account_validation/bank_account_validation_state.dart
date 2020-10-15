part of 'bank_account_validation_bloc.dart';

abstract class BankAccountValidationState extends Equatable {
  const BankAccountValidationState();
}

class BankAccountValidationInitial extends BankAccountValidationState {
  @override
  List<Object> get props => [];
}
class BankAccountValidationLoading extends BankAccountValidationState{
  @override
  List<Object> get props => [];
}

class BankAccountValidationLoaded extends BankAccountValidationState{

  final AccountValidatorModel accountValidation;

  BankAccountValidationLoaded(this.accountValidation);
  @override
  List<Object> get props => [];

}

class BankAccountValidationError extends BankAccountValidationState{

  final String message;

  BankAccountValidationError(this.message);
  @override
  List<Object> get props => [];

}

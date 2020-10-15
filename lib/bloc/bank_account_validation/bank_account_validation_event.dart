part of 'bank_account_validation_bloc.dart';

abstract class BankAccountValidationEvent extends Equatable {
  const BankAccountValidationEvent();
}

class ValidateBankAccount extends BankAccountValidationEvent{

  final String bankAccount;
  final String sortCodes;

  ValidateBankAccount(this.bankAccount, this.sortCodes);
  @override
  List<Object> get props => [];

}
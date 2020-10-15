import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stripus/model/loqate_validate_model.dart';
import 'package:stripus/repository/account_validation_repository.dart';

part 'bank_account_validation_event.dart';

part 'bank_account_validation_state.dart';

class BankAccountValidationBloc
    extends Bloc<BankAccountValidationEvent, BankAccountValidationState> {

  AccountValidationRepository accountValidationRepository;

  BankAccountValidationBloc({@required this.accountValidationRepository})
      : super(BankAccountValidationInitial());

  @override
  Stream<BankAccountValidationState> mapEventToState(
      BankAccountValidationEvent event,) async* {
    if (event is ValidateBankAccount) {
      yield* _mapValidateBankAccountToState(event.bankAccount, event.sortCodes);
    }
  }

  Stream<BankAccountValidationState> _mapValidateBankAccountToState(
      String bankAccount, String sortCodes) async* {
    yield BankAccountValidationLoading();

    try {
      AccountValidatorModel accountValidation = await accountValidationRepository
          .validateAccount(bankAccount, sortCodes);
      print(accountValidation.toJson());
      yield BankAccountValidationLoaded(accountValidation);
    } catch (e) {
      print(e.toString);
      yield BankAccountValidationError(e.toString());
    }
  }

}

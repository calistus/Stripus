import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stripus/model/stripe_transaction_response.dart';
import 'package:stripus/repository/payment_repository.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  StripeRepository stripeRepository;

  PaymentBloc({@required this.stripeRepository}) : super(PaymentInitial());

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is PayWithCard) {
      yield* _mapPayWithCardToState(
          event.amount, event.currency, event.description, event.receiptEmail);
    }
  }

  Stream<PaymentState> _mapPayWithCardToState(String amount, String currency,
      String description, String receiptEmail) async* {
    StripeTransactionResponse response = await stripeRepository.payWithNewCard(
        amount: amount,
        currency: 'USD',
        description: description,
        receiptEmail: receiptEmail);
    if (response.responseStatus == 'succeeded') {
      yield PaymentSuccessful(response);
    } else {
      yield PaymentError(response);
    }
  }
}

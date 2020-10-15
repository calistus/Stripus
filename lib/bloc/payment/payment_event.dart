part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class PayWithCard extends PaymentEvent {
  final String amount;
  final String currency;
  final String receiptEmail;
  final String description;

  PayWithCard(this.amount, this.currency, this.receiptEmail, this.description);

  @override
  List<Object> get props => [];
}

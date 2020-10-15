part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}
class PaymentSuccessful extends PaymentState{
  final StripeTransactionResponse response;

  PaymentSuccessful(this.response);
  @override
  List<Object> get props => [];
}

class PaymentProcessing extends PaymentState{
  @override
  List<Object> get props => [];
}

class PaymentError extends PaymentState{

  final StripeTransactionResponse response;

  PaymentError(this.response);
  @override
  List<Object> get props => throw UnimplementedError();

}
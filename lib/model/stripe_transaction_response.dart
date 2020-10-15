class StripeTransactionResponse {
  String message;
  bool success;
  String responseStatus;
  StripeTransactionResponse({this.message, this.success, this.responseStatus});
}
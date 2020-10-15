import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';
import 'package:stripus/model/stripe_transaction_response.dart';
import 'package:stripus/secret/api_keys.dart';

class StripeRepository {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeRepository.apiBase}/payment_intents';
  static String secret = APIKeys.STRIPE_TEST_API_SECRET;
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeRepository.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: APIKeys.STRIPE_TEST_API_PUBLISHABLE_KEY,
        merchantId: "Hilary",
        androidPayMode: 'test'
      )
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard({String amount, String currency, String receiptEmail, CreditCard card, String description}) async{
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card)
      );
      var paymentIntent = await StripeRepository.createPaymentIntent(
        amount,
        currency, receiptEmail,description
      );
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id
        )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaction successful',
          responseStatus: response.status,
          success: true
        );
      } else {
        return new StripeTransactionResponse(
          message: 'Transaction failed',
            responseStatus: response.status,
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeRepository.getPlatformExceptionErrorResult(err);
    } catch (err) {
      print(err.toString());
      return new StripeTransactionResponse(
        message: 'Transaction failed: ${err.toString()}',
        success: false
      );
    }
  }

   Future<StripeTransactionResponse> payWithNewCard({String amount, String currency, String receiptEmail, String description}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );
      var paymentIntent = await StripeRepository.createPaymentIntent(
        amount,
        currency, receiptEmail, description
      );
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id
        )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaction successful',
            responseStatus: response.status,
            success: true
        );
      } else {
        return new StripeTransactionResponse(
          message: 'Transaction failed',
            responseStatus: response.status,
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeRepository.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed: ${err.toString()}',
        success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
      message: message,
      success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency, String receiptEmail, String description) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'receipt_email': receiptEmail,
        'description': description,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        StripeRepository.paymentApiUrl,
        body: body,
        headers: StripeRepository.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}

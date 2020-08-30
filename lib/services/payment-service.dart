import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

//reponse if trans success or fail
class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secretKey =
      'sk_test_51HLLuALNWLWiwU1V74dXvLVoScE39XsmHGoWNIsgRZzFV70P1Sm6FXmGx6XdQbyzMmQNwsWscpSwBjkSNgt7ERL500GA5af1MP';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secretKey}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
      StripeOptions(
          publishableKey:
              "pk_test_51HLLuALNWLWiwU1VF3Ekke8lHpzE2ZlttkIAJvtKO8WCoZ4bFejhSgVn5N3NNmeUckXNJdFqrOIiNMEKedP4YyOU00fHPwAskg",
          merchantId: "Test",
          androidPayMode: 'test'),
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {String amount, String currency, CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));

      var paymentIntent = await StripeService.createPaymentIntent(
        amount,
        currency,
      );
      print(jsonEncode(paymentIntent));

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaction successful',
          success: true,
        );
      } else {
        return new StripeTransactionResponse(
          message: 'Transaction failed',
          success: false,
        );
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed:${err.toString()}',
        success: false,
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }
    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<StripeTransactionResponse> payViaNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      var paymentIntent = await StripeService.createPaymentIntent(
        amount,
        currency,
      );
      print(jsonEncode(paymentIntent));

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaction successful',
          success: true,
        );
      } else {
        return new StripeTransactionResponse(
          message: 'Transaction failed',
          success: false,
        );
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed:${err.toString()}',
        success: false,
      );
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('error charging user: ${err.toString()}');
    }
    return null;
  }
}

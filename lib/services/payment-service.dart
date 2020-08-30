import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

//reponse if trans success or fail
class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51HLLuALNWLWiwU1V74dXvLVoScE39XsmHGoWNIsgRZzFV70P1Sm6FXmGx6XdQbyzMmQNwsWscpSwBjkSNgt7ERL500GA5af1MP';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HLLuALNWLWiwU1VF3Ekke8lHpzE2ZlttkIAJvtKO8WCoZ4bFejhSgVn5N3NNmeUckXNJdFqrOIiNMEKedP4YyOU00fHPwAskg",
        merchantId: "Test",
        androidPayMode: 'test'))
        
  }

  static StripeTransactionResponse payViaExistingCard(
      {String amount, String currency, card}) {
    return new StripeTransactionResponse(
      message: 'Transaction successfull',
      success: true,
    );
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
      
      print(StripeService.paymentApiUrl);
      print('here');
      print(jsonEncode(paymentIntent));

      return new StripeTransactionResponse(
        message: 'Transaction successful',
        success: true,
      );
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed:${err.toString()}',
        success: true,
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
      var response = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('error charging user: ${err.toString()}');
    }
    return null;
  }
  
}

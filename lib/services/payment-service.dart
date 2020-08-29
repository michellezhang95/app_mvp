import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

//reponse if trans success or fail
class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com//v1';
  static String secret = '';

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HLLuALNWLWiwU1VF3Ekke8lHpzE2ZlttkIAJvtKO8WCoZ4bFejhSgVn5N3NNmeUckXNJdFqrOIiNMEKedP4YyOU00fHPwAskg",
        merchantId: "Test",
        androidPayMode: 'test'));
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
      print(paymentMethod);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Transaction failed:${err.toString()}',
        success: false,
      );
    }

    return new StripeTransactionResponse(
      message: 'Transaction successful',
      success: true,
    );
  }
}

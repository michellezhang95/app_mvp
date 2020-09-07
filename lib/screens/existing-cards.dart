import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:app_mvp/services/payment-service.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:app_mvp/screens/homepage.dart';
import 'package:app_mvp/screens/order-confirmation.dart';

class ExistingCardsPage extends StatefulWidget {
  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {
  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Sally Sal',
      'cvvCode': '123',
      'showBackView': false,
    },
    {
      'cardNumber': '5555555555554444',
      'expiryDate': '04/24',
      'cardHolderName': 'Billy Bob',
      'cvvCode': '123',
      'showBackView': true,
    }
  ];

  payViaExistingCard(BuildContext context, card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );

    var response = await StripeService.payViaExistingCard(
      amount: '${HomePage.totalFee.toString()}00',
      currency: 'NZD',
      card: stripeCard,
    );
    await dialog.hide();
    //
    if (response.success == true) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(
            content: Text(response.message),
            duration: new Duration(milliseconds: 1200),
          ))
          .closed
          .then((_) {
        Navigator.pop(context);
      });
      Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: '/order-confirmation'),
        builder: (context) => Confirm(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose existing card'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = cards[index];
            return InkWell(
              onTap: () {
                payViaExistingCard(context, card);
              },
              child: CreditCardWidget(
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'],
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: false, //true when you want to show cvv(back) view
              ),
            );
          },
        ),
      ),
    );
  }
}

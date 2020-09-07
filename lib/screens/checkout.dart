import 'package:flutter/material.dart';
import 'package:app_mvp/screens/sample-restaurant.dart';
import 'package:app_mvp/screens/homepage.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Order')),
      body: Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Your total comes to: \$${HomePage.totalFee.toString()}'),
                SizedBox(height: 10.0),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/existing-cards');
                    },
                    child: Text('Pay Now with Existing Cards'),
                    color: Colors.green[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ],
            ),
          )),
    );
  }
}

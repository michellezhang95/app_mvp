import 'package:flutter/material.dart';

class Confirm extends StatefulWidget {
  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Confirmed'),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/homepage'));
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                leading: Icon(Icons.check_box),
                title: Text(
                    'Your order is confirmed and will be prepared shortly. Thank you.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

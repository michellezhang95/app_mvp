import 'package:app_mvp/screens/existing-cards.dart';
import 'package:app_mvp/screens/sample-restaurant.dart';
import 'package:app_mvp/screens/scan-qr.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_mvp/services/payment-service.dart';
import 'package:app_mvp/models/food.dart';

class HomePage extends StatefulWidget {
  static int cbValue = 0;
  static List<int> values = [0, 0, 0];
  static int totalFee = 0;
  static List<Food> initMenu() {
    Food cheesebg = Food(name: "Cheeseburger", quantity: 0);
    Food fchick = Food(name: "Fried Chicken", quantity: 0);
    Food cheesefries = Food(name: "Cheese Fries", quantity: 0);

    List<Food> foodEntries = [cheesebg, fchick, cheesefries];
    List<Food> list;
    return list = List<Food>.from(foodEntries);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        //pay new card
        {
          var response = await StripeService.payViaNewCard(
            amount: '1200',
            currency: 'NZD',
          );

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(response.message),
            duration: new Duration(
                milliseconds: response.success == true ? 1200 : 3000),
          ));
        }

        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          settings: RouteSettings(name: '/existing-cards'),
          builder: (context) => ExistingCardsPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          settings: RouteSettings(name: '/scan-qr'),
          builder: (context) => ScanQR(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          settings: RouteSettings(name: '/sample-restaurant'),
          builder: (context) => SampleRestaurant(),
        ));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) {
            Icon icon;
            Text text;
            switch (index) {
              case 0:
                icon = Icon(
                  Icons.add_circle,
                  color: theme.primaryColor,
                );
                text = Text('Pay via a new card');
                break;
              case 1:
                icon = Icon(
                  Icons.credit_card,
                  color: theme.primaryColor,
                );
                text = Text('Pay via existing card');
                break;
              case 2:
                icon = Icon(Icons.camera_alt, color: theme.primaryColor);
                text = Text('Scan QR Code');
                break;
              case 3:
                icon = Icon(Icons.fastfood, color: theme.primaryColor);
                text = Text('Good Burger - Order Here');
                break;
            }
            return InkWell(
              onTap: () {
                onItemPress(context, index);
              },
              child: ListTile(
                title: text,
                leading: icon,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: theme.primaryColor,
          ),
          itemCount: 4,
        ),
      ),
    );
  }
}

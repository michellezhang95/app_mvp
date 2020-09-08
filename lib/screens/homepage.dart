import 'package:app_mvp/screens/existing-cards.dart';
import 'package:app_mvp/screens/sample-restaurant.dart';
import 'package:app_mvp/screens/scan-qr.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_mvp/services/payment-service.dart';
import 'package:app_mvp/models/food.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  static int _selectedIndex = 0;
  /*  onItemPress(BuildContext context, int index) async {
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
  } */

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  static List<Widget> _widgetOptions = <Widget>[
    Text('home'),
    Text('Scan'),
    Text('Browse'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.amber,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: Container(
          width: 230.0,
          child: Drawer(
            elevation: 16.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Divider(
                  height: 45.0,
                ),
                ListTile(
                  leading: Icon(MaterialCommunityIcons.cart_outline),
                  title: Text('My Cart'),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.transparent,
                ),
                ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text('Order History'),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.transparent,
                ),
                ListTile(
                  leading: Icon(MaterialIcons.loyalty),
                  title: Text('Reward Points'),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.transparent,
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: Text('My Favourites'),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.transparent,
                ),
                ListTile(
                  leading: Icon(MaterialCommunityIcons.account_card_details),
                  title: Text('My Account and Payments'),
                  onTap: () {},
                ),
                Container(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Divider(height: 140.0),
                      ListTile(
                        leading: Icon(
                          Ionicons.ios_help_circle_outline,
                        ),
                        title: Text(
                          'Help',
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.blue[800],
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.red[800],
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red[800]),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      /* Container(
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
      ), */
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[100],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.qrcode_scan),
              title: Text('Scan'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Browse'),
            backgroundColor: Colors.blue,
          ),
          /*   BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('My Account'),
            backgroundColor: Colors.blue,
          ), */
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[400],
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:app_mvp/models/food.dart';
import 'package:app_mvp/screens/homepage.dart';

class SampleRestaurant extends StatefulWidget {
  @override
  _SampleRestaurantState createState() => _SampleRestaurantState();
}

class _SampleRestaurantState extends State<SampleRestaurant> {
  // static List<int> values = [0, 0, 0];

  onItemPress(BuildContext context, int index) async {}

  @override
  Widget build(BuildContext context) {
    Icon icon;
    String text;
    List<Food> food = HomePage.initMenu();

    return Scaffold(
      appBar: AppBar(
        title: Text('Good Burger - Order Here'),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      text = '${food[index].name}   \$10 ';
                      break;
                    case 1:
                      text = '${food[index].name}   \$12';
                      break;
                    case 2:
                      text = '${food[index].name}    \$8';
                      break;
                  }
                  return ListBody(children: <Widget>[
                    ListTile(
                      title: Text(text),
                      leading: Icon(Icons.restaurant),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 42),
                        FlatButton(
                            onPressed: () {
                              switch (index) {
                                case 0:
                                  print('cheeseburger');
                                  setState(() {
                                    if (HomePage.values[index] == 0) {
                                      HomePage.values[index] = 0;
                                    } else {
                                      HomePage.values[index]--;
                                      HomePage.totalFee -= 10;
                                    }
                                  });

                                  break;
                                case 1:
                                  print('fried chimcken');
                                  setState(() {
                                    if (HomePage.values[index] == 0) {
                                      HomePage.values[index] = 0;
                                    } else {
                                      HomePage.values[index]--;
                                      HomePage.totalFee -= 12;
                                    }
                                  });
                                  break;
                                case 2:
                                  print('Cheese fries');
                                  setState(() {
                                    if (HomePage.values[index] == 0) {
                                      HomePage.values[index] = 0;
                                    } else {
                                      HomePage.values[index]--;
                                      HomePage.totalFee -= 8;
                                    }
                                  });
                                  break;
                              }
                            },
                            child: Text('-',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white)),
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        SizedBox(width: 10.0),
                        /* Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.green[500],
                          )),
                          child: Text(food[index].quantity.toString(),
                              style: TextStyle(fontSize: 20)),
                        ), */
                        Text(HomePage.values[index].toString(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.amber[00])),
                        SizedBox(width: 10.0),
                        FlatButton(
                            onPressed: () {
                              switch (index) {
                                case 0:
                                  print('cheeseburger');
                                  setState(() {
                                    HomePage.values[index]++;
                                    HomePage.totalFee += 10;
                                  });

                                  break;
                                case 1:
                                  print('fried chimcken');
                                  setState(() {
                                    HomePage.values[index]++;
                                    HomePage.totalFee += 12;
                                  });
                                  break;
                                case 2:
                                  print('Cheese fries');
                                  setState(() {
                                    HomePage.values[index]++;
                                    HomePage.totalFee += 8;
                                  });
                                  break;
                              }
                            },
                            child: Text('+',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white)),
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ],
                    ),
                  ]);
                },
              ),
            ),
            /* Row(
                  children: <Widget>[
                    SizedBox(width: 42),
                    FlatButton(
                        onPressed: () {},
                        child: Text('My Cart ',
                            style: TextStyle(fontSize: 25.0, color: Colors.white)),
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    SizedBox(width: 10.0),
                    FlatButton(
                        child: Text('Confirm Order',
                            style: TextStyle(fontSize: 25.0, color: Colors.white)),
                        onPressed: () {},
                        color: Colors.green[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ],
                ), */
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width / 4),
                /* FlatButton(
                    onPressed: () {},
                    child: Text('My Cart ',
                        style: TextStyle(fontSize: 25.0, color: Colors.white)),
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                SizedBox(width: 10.0), */
                FlatButton(
                    child: Text('Confirm Order',
                        style: TextStyle(fontSize: 25.0, color: Colors.white)),
                    onPressed: () {
                      if (HomePage.totalFee > 0) {
                        Navigator.of(context).pushNamed('/checkout');
                      }
                    },
                    color: Colors.green[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

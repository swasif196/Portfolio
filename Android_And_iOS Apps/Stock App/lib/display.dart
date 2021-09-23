import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';
import 'dart:async';
import 'app_page.dart';
import 'custom_snack_bar.dart';
import 'stock.dart';

class DisplayPage extends StatefulWidget {
  final Stock stock;
  final bool showWatchlistLink;

  DisplayPage({Key? key, required this.stock, this.showWatchlistLink=true}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  StreamSubscription? _authSubscription;
  User? _currentUser;
  String? _id;

  _DisplayPageState() {
    _authSubscription = Authentication.subscribeToAuthChanges((user) {
      if (user != null) {
        // search watchlist for symbol
        FirebaseFirestore.instance.collection('users').doc(user.uid).collection('watchlist').where('symbol', isEqualTo: widget.stock.symbol).snapshots().listen((event) {
          setState(() {
            this._id = event.docs.isEmpty ? null : event.docs.first.id;
            this._currentUser = user;
          });
        });
      }
      else {
        setState(() {
          this._currentUser = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Stocks Display';

    return AppPage(
      title: appTitle,
      showWatchlistLink: widget.showWatchlistLink,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Column(
                          children: [
                            Text(
                              widget.stock.symbol,
                              //Icon(Icons.star),
                              style: TextStyle(fontSize: 24),
                              //SizedBox(child: Icon(Icons.star)),
                            ),
                          ]
                      ),
                      Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: _currentUser != null ? _buildWatchListButton(context) : Icon(Icons.star, color: Colors.blueGrey),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row (children: [
                    Column(
                        children: [
                          Text(
                            "Prev Close\n\t\t${widget.stock.close}",
                            //Icon(Icons.star),
                            style: TextStyle(fontSize: 18),
                            //SizedBox(child: Icon(Icons.star)),
                          ),
                        ]
                    ),
                    Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "Day Open\n\t\t${widget.stock.open}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]
                    ),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row (children: [
                    Column(
                        children: [
                          Text(
                            "Day High\n\t\t${widget.stock.high}",
                            //Icon(Icons.star),
                            style: TextStyle(fontSize: 18),
                            //SizedBox(child: Icon(Icons.star)),
                          ),
                        ]
                    ),
                    Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "Day Low\n\t\t${widget.stock.low}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]
                    ),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row (children: [
                    Column(
                        children: [
                          Text(
                            "52 Week High\n\t\t${widget.stock.ftweekH}",
                            //Icon(Icons.star),
                            style: TextStyle(fontSize: 18),
                            //SizedBox(child: Icon(Icons.star)),
                          ),
                        ]
                    ),
                    Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "52 Week Low\n\t\t${widget.stock.ftweekL}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]
                    ),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row (children: [
                    Column(
                        children: [
                          Text(
                            "Market Cap\n\t\t${widget.stock.cap}",
                            //Icon(Icons.star),
                            style: TextStyle(fontSize: 18),
                            //SizedBox(child: Icon(Icons.star)),
                          ),
                        ]
                    ),
                    Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "Volume\n\t\t${widget.stock.volume}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]
                    ),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 40.0),
                  child: Row (children: [
                    Column(
                        children: [
                          Text(
                            "Current Value\n\t\t${widget.stock.value}",
                            //Icon(Icons.star),
                            style: TextStyle(fontSize: 18),
                            //SizedBox(child: Icon(Icons.star)),
                          ),
                        ]
                    ),
                    Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "Price Hint\n\t\t${widget.stock.hint}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]
                    ),
                  ],
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child:
                  new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: new Text (
                        "Company Info:\n${widget.stock.info}"
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  IconButton _buildWatchListButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        _id != null ? Icons.star : Icons.star_border_outlined,
        color: Colors.yellow,
      ),
      onPressed: () {
        if (_id == null) {
          // add item to watchlist and record id
          FirebaseFirestore.instance.collection('users').doc(_currentUser?.uid).collection('watchlist').add({
            'symbol': widget.stock.symbol,
            'market': widget.stock.market,
          }).then((doc) {
            showInfoSnackBar("Added to Watchlist", context);
            setState(() {
              this._id = doc.id;
            });
          });
        }
        else {
          // delete item from watchlist and clear id
          FirebaseFirestore.instance.collection('users').doc(_currentUser?.uid).collection('watchlist').doc(_id!).delete().then((foo) {
            showInfoSnackBar("Removed from Watchlist", context);
            setState(() {
              this._id = null;
            });
          });
        }
      },
    );
  }
}


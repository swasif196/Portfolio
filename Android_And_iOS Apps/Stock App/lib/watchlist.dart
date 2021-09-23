import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_page.dart';
import 'display.dart';
import 'authentication.dart';
import 'dart:async';
import 'stock.dart';

class WatchListPage extends StatefulWidget {
  @override
  _WatchListPageState createState() {
    return _WatchListPageState();
  }
}

class _ListItem {
  final String id;
  final String symbol;
  final String market;

  _ListItem(this.id, this.symbol, this.market);
}

class _WatchListPageState extends State<WatchListPage> {
  StreamSubscription? _authSubscription;
  StreamSubscription? _watchlistSubscription;
  User? _currentUser;
  var _items = [];

  _WatchListPageState() {
    _authSubscription = Authentication.subscribeToAuthChanges((user) {
      _watchlistSubscription?.cancel();

      if (user != null) {
        _watchlistSubscription = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('watchlist').snapshots().listen((snapshot) {
          var listItems = [];

          snapshot.docs.forEach((item) {
            listItems.add(_ListItem(item.id, item.data()!['symbol'], item.data()!['market']));
          });

          setState(() {
            this._items = listItems;
          });
        });
      }

      setState(() {
        this._currentUser = user;
      });
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _watchlistSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
        title: "Watchlist",
        showWatchlistLink: false,
        body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_currentUser == null) {
      return Center(
        child: Text("Login to view watchlist"),
      );
    }

    if (_items.isEmpty) {
      return Center(
        child: Text("Your watchlist is empty"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length * 2,
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider(
            thickness: 1.0,
          );
        }

        return _buildRow(_items[i ~/ 2], context);
      },
    );
  }

  Widget _buildRow(_ListItem item, BuildContext context) {
    return ListTile(
      title: Text(
        item.symbol,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
        ),
      ),
      trailing: Text(item.market),
      onTap: () async {
        Stock? stock = await Stock.getStock(item.symbol, item.market);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisplayPage(
            stock: stock!,
            showWatchlistLink: false,
          )),
        );
      },
    );
  }
}
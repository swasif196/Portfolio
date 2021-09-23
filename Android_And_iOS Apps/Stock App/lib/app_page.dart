import 'package:flutter/material.dart';
import 'watchlist.dart';
import 'login.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AppPage extends StatefulWidget {
  final String title;
  final Widget body;
  final bool showLoginLink;
  final bool showWatchlistLink;

  AppPage({required this.title, required this.body, this.showLoginLink = true, this.showWatchlistLink = true});

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  StreamSubscription? _authSubscription;
  User? _currentUser;

  _AppPageState() {
    _authSubscription = Authentication.subscribeToAuthChanges((user) {
      setState(() {
        this._currentUser = user;
      });
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: widget.body,
    );
  }

  AppBar _buildAppBar() {
    var links = <Widget>[];

    if (widget.showLoginLink) {
      links.add(TextButton(
        child: Text(_currentUser != null ? "Logout" : "Login"),
        style: TextButton.styleFrom(primary: Colors.white),
        onPressed: () {
          if (_currentUser != null) {
            Authentication.signOut(context: context);
          }
          else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
      ));
    }

    if (widget.showWatchlistLink) {
      links.add(TextButton(
        child: Text("Watchlist"),
        style: TextButton.styleFrom(primary: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WatchListPage()),
          );

          if (_currentUser == null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
      ));
    }

    return AppBar(
      title: Text(widget.title),
      backgroundColor: Color(0xFF1B60C7),
      actions: links,
    );
  }
}

import 'package:checkout_app/components/DrawerAppBar.dart';
import 'package:checkout_app/constants.dart';
import 'package:checkout_app/functions/getCurentUser.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  final currentUser = getCurrentUser().email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout RH'),
        backgroundColor: kCorAzulCheckout,
      ),
      drawer: DrawerAppBar(),
      body: Text('Bem vindo! $currentUser',
          style: TextStyle(color: Colors.black, fontSize: 50)),
    );
  }
}

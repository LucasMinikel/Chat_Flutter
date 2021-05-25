import 'package:checkout_app/components/DrawerAppBar.dart';
import 'package:checkout_app/constants.dart';
import 'package:checkout_app/functions/getCurentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CHECKOUT RH'),
          backgroundColor: kCorAzulCheckout,
        ),
        drawer: DrawerAppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: getCurrentUser().uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            var userName = streamSnapshot.data.docs[0]['nome_usuario'];
            return Text('Bem vindo! $userName',
                style: TextStyle(color: Colors.black, fontSize: 40));
          },
        ));
  }
}

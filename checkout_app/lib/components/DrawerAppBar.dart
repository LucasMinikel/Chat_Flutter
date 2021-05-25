import 'package:checkout_app/constants.dart';
import 'package:checkout_app/screens/chat_screen.dart';
import 'package:checkout_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerAppBar extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kCorAzulCheckout,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
              child: Image.asset('resources/img/logo.png'),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Menu', style: TextStyle(color: Colors.grey)),
            ),
            ListTile(
              leading: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              title: Text('Chat', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.storage,
                color: Colors.white,
              ),
              title: Text('Arquivos', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Opções', style: TextStyle(color: Colors.grey)),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text('Sair', style: TextStyle(color: Colors.white)),
              onTap: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

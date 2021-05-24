import 'package:checkout_app/components/RoundedButton.dart';
import 'package:checkout_app/constants.dart';
import 'package:checkout_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String passaword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCorAzulCheckout,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('resources/img/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Digite seu email.')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    passaword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Digite sua senha.')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onPressed: () {
                  print(email);
                  print(passaword);
                },
                title: 'CRIAR',
              ),
              RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
                title: 'VOLTAR',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

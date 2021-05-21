import 'package:checkout_app/screens/chat.screen.dart';
import 'package:checkout_app/screens/login_screen.dart';
import 'package:checkout_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:checkout_app/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

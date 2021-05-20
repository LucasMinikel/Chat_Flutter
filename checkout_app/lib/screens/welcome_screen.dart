import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:checkout_app/constants.dart';
import 'package:checkout_app/screens/login_screen.dart';
import 'package:checkout_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(
        seconds: 1,
      ),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCorAzul,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('resources/img/logo.png'),
                    height: animation.value * 100,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'RH para sua empresa',
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      totalRepeatCount: 1,
                    )),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: kCorVermelho,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 300,
                  height: 50,
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: kCorVermelho,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 300,
                  height: 50,
                  child: Text(
                    'CRIAR CONTA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

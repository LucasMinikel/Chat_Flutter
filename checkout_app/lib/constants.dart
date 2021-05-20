import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kCorAzul = Color.fromRGBO(32, 31, 50, 10);
const kCorRoxo = Color.fromRGBO(84, 47, 99, 10);
const kCorVermelho = Color.fromRGBO(255, 24, 33, 10);
const kCorBrancoAmarelado = Color.fromRGBO(247, 247, 240, 10);

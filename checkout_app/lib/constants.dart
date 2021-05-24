import 'package:flutter/material.dart';

const kCorAzulCheckout = Color.fromRGBO(32, 31, 50, 10);
const kCorRoxoCheckout = Color.fromRGBO(84, 47, 99, 10);
const kCorVermelhoCheckout = Color.fromRGBO(255, 24, 33, 10);

const kSendButtonTextStyle = TextStyle(
  color: kCorAzulCheckout,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Digite seu mensagem...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kCorAzulCheckout, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Digite um valor.',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kCorRoxoCheckout, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kCorRoxoCheckout, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

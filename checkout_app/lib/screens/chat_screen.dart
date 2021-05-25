import 'package:checkout_app/functions/getCurentUser.dart';
import 'package:flutter/material.dart';
import 'package:checkout_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final mensagemTextController = TextEditingController();

  String mensagemTexto;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('CHAT'),
        backgroundColor: kCorRoxoCheckout,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagensStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: mensagemTextController,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        mensagemTexto = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('mensagens').add({
                        'texto': mensagemTexto,
                        'remetente': getCurrentUser().email,
                        'data_envio': DateTime.now(),
                      });
                      mensagemTextController.clear();
                    },
                    child: Text(
                      'Enviar',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagensStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('mensagens').orderBy('data_envio').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kCorAzulCheckout,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBuble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['texto'];
          final messageSender = message['remetente'];

          final currentUser = getCurrentUser().email;

          final messageBubble = MessageBuble(
            remetente: messageSender,
            texto: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBuble extends StatelessWidget {
  MessageBuble({this.remetente, this.texto, this.isMe});

  final String remetente;
  final String texto;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5,
            color: isMe ? kCorAzulCheckout : Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                texto,
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              remetente,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

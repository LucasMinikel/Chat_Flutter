import 'package:checkout_app/components/MessageBuble.dart';
import 'package:checkout_app/constants.dart';
import 'package:checkout_app/functions/getCurentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

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

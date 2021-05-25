import 'package:flutter/material.dart';
import 'package:checkout_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  final mensagemTextController = TextEditingController();

  String mensagemTexto;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
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
                        'remetente': loggedInUser.email,
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

// class MessagensStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('mensagens').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final mensagens = snapshot.data.docs.reversed;
//           List<MessageBuble> mensagensBubble = [];
//           mensagens.forEach(
//             (mensagens) {
//               final mensagemTexto = mensagens['texto'];
//               final mensagensRemetente = mensagens['remetente'];
//               final currentUser = loggedInUser.email;
//               final messageBubble = MessageBuble(
//                 texto: mensagemTexto,
//                 remetente: mensagensRemetente,
//                 isMe: currentUser == mensagensRemetente,
//               );
//               mensagensBubble.add(messageBubble);
//             },
//           );
//           return Expanded(
//             child: ListView(
//               reverse: true,
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               children: mensagensBubble,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

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
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBuble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['texto'];
          final messageSender = message['remetente'];

          final currentUser = loggedInUser.email;

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
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                texto,
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
          Text(
            remetente,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

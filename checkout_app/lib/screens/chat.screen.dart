import 'package:flutter/material.dart';
import 'package:checkout_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User loggedInUser;
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

  // void getMessagens() async {
  //   _firestore
  //       .collection('mensagens')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc.data());
  //     });
  //   });
  // }

  // void mensagensStream() async {
  //   await _firestore.collection('mensagens').snapshots().forEach((snapshot) {
  //     snapshot.docs.forEach((mensagens) {
  //       print(mensagens.data()['texto']);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kCorAzulCheckout,
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
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('mensagens').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final mensagens = snapshot.data.docs;
                  List<MessageBuble> mensagensBubble = [];
                  mensagens.forEach(
                    (mensagens) {
                      final mensagemTexto = mensagens['texto'];
                      final mensagensRemetente = mensagens['remetente'];

                      final messageBubble = MessageBuble(
                        texto: mensagemTexto,
                        remetente: mensagensRemetente,
                      );
                      mensagensBubble.add(messageBubble);
                    },
                  );
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: mensagensBubble,
                    ),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
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

class MessageBuble extends StatelessWidget {
  MessageBuble({this.remetente, this.texto});

  final String remetente;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                texto,
                style: TextStyle(fontSize: 15),
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

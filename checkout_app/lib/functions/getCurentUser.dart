import 'package:firebase_auth/firebase_auth.dart';

User loggedInUser;

final _auth = FirebaseAuth.instance;

User getCurrentUser() {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  } catch (e) {}
  return loggedInUser;
}

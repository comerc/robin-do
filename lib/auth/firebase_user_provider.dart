import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RobinDoFirebaseUser {
  RobinDoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

RobinDoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RobinDoFirebaseUser> robinDoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<RobinDoFirebaseUser>(
        (user) => currentUser = RobinDoFirebaseUser(user));

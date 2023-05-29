import 'package:firebase_database/firebase_database.dart';

class User {
  final String fullName;
  final String email;
  final String password;

  User({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');

// Add a user from the signup form
void addUser(String fullName, String email, String password) {
  usersRef.push().set({
    'fullName': fullName,
    'email': email,
    'password': password,
  });
}

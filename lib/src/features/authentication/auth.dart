import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../newsfeed/Pages/home_screen_editeur.dart';
import 'pages/login_page.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreenEditeur();
          } else {
            return LoginPage(key: UniqueKey());
          }
        },
      ),
    );
  }
}

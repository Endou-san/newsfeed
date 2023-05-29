import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String name;
  final String email;

  UserData({required this.name, required this.email});
}

Future<UserData> getUserData() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    Map<String, dynamic>? userData = userDataSnapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
      String name = userData['name'];
      String email = userData['email'];

      UserData userDataObject = UserData(name: name, email: email);

      return userDataObject;
    } else {
      throw Exception("Données utilisateur non trouvées");
    }
  } else {
    throw Exception('Utilisateur non authentifié');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String Titre;
  String Auteur;
  String Date;
  String Description;
  String Image;
static const int length = 0;
  Article({required this.Titre, required this.Auteur, required this.Date, required this.Description, required this.Image});


  // Factory method to create an Article from a DocumentSnapshot
  factory Article.fromSnapshot(DocumentSnapshot snapshot) {
    
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Article(
      Titre: data['title'] ?? '',
      Auteur: data['author'] ?? '',
      Image: data['image'] ?? '',
      Description: data['description'] ?? '',
      Date: (data['date'] ) ?? '',

    );
  }
}
              
              

 
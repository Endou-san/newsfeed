import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/article_model.dart';

class ArticlesViewModel {
  CollectionReference articlesRef = FirebaseFirestore.instance.collection('Articles');
  late Stream<List<Article>> articlesStream;

  ArticlesViewModel() {
    articlesStream = articlesRef.snapshots().map((snapshot) => snapshot.docs.map((doc) => Article.fromSnapshot(doc)).toList());
  }

  Stream<List<Article>> getArticlesStream() {
    return FirebaseFirestore.instance
        .collection('Articles')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Article> results = [];
      for (var doc in query.docs) {
        results.add(Article.fromSnapshot(doc));
      }
      return results;
    });
  }
}




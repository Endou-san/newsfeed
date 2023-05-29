import 'package:firebase_database/firebase_database.dart';


class Article {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String tags;
  final String description;
  final String image;
  final DateTime createdDate;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.tags,
    required this.description,
    required this.image,
    required this.createdDate,
  });
}
final DatabaseReference articlesRef =
    FirebaseDatabase.instance.ref().child('Articles');



// Create a new article
void addArticle(
    String title, String content, String authorId, String tags, String description, String image) {
  articlesRef.push().set({
    'title': title,
    'content': content,
    'authorId': authorId,
    'tags': tags,
    'description': description,
    'image': image,
    'createdDate': DateTime.now().toIso8601String(),
  });
}
/*
// Read all articles
Future<List<Article>> getArticles() async {
  DatabaseEvent event = await articlesRef.once();
  DataSnapshot dataSnapshot = event.snapshot;
  final data = dataSnapshot.value as Map<dynamic, dynamic>;

  List<Article> articles = [];
  data.forEach((key, value) {
    Article article = Article(
      id: key,
      title: value['title'],
      content: value['content'],
      authorId: value['authorId'],
      tags: value['tags'],
      description: value['description'],
      createdDate: DateTime.parse(value['createdDate']),
    );
    articles.add(article);
  });

  return articles;
}

// Read a single article
Future<Article?> getArticle(String articleId) async {
  DatabaseEvent event = await articlesRef.once();
  DataSnapshot dataSnapshot = event.snapshot;
  final data = dataSnapshot.value as Map<dynamic, dynamic>;

  Article article = Article(
    id: articleId,
    title: data['title'],
    content: data['content'],
    authorId: data['authorId'],
    tags: data['tags'],
    description: data['description'],
    createdDate: DateTime.parse(data['createdDate']),
  );
  return article;
}

// Update an article
Future<void> updateArticle(
    String articleId, String title, String content, List<String> tags, String description) async {
  await articlesRef.child(articleId).update({
    'title': title,
    'content': content,
    'tags': tags,
    'description': description
  });
}

// Delete an article
Future<void> deleteArticle(String articleId) async {
  await articlesRef.child(articleId).remove();
}
*/
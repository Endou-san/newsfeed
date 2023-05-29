import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralScreen extends StatelessWidget {
  final CollectionReference articlesRef =
  FirebaseFirestore.instance.collection('Articles');
  late final Stream<QuerySnapshot> articlesStream = articlesRef.snapshots();


  GeneralScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: articlesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Text('No articles found');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final String title = data['Titre'] as String;
              final String author = data['Auteur'] as String;
              final Timestamp date = data['Date'] as Timestamp;
              final String description = data['Description'] as String;
              final String image = data['Image'] as String;

              
          

          //return Swiper(
            //itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(title),
                          ),
                          body: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'By $author on ${date.toDate().toString()}',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    description,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                          bottomLeft: Radius.circular(35.0),
                          bottomRight: Radius.circular(35.0),
                        ),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          height: 400.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 350.0, 0.0, 0),
                      child: SizedBox(
                        height: 200.0,
                        width: 750.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(35.0),
                          elevation: 10.0,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, 

       // ignore: unnecessary_null_comparison
    /*  itemCount: snapshot.data!.docs.length,
      viewportFraction: 0.7,
      scale: 0.9,
      autoplay: true,*/
              );},
         
    ));
        }
   // ) );
  }
//}
             
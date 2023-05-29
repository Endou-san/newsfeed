import 'dart:io';

import 'package:enim_press/src/features/newsfeed/view_model/Article_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Profil/Profil_screen.dart';

import 'general_screen.dart';
import '../view_model/image_Upload.dart';

class HomeScreenEditeur extends StatefulWidget {
  @override
  _HomeScreenEditeurState createState() => _HomeScreenEditeurState();
}

class _HomeScreenEditeurState extends State<HomeScreenEditeur> {
  
  late String _imageUrl = ''; // Champ initialisé avec une valeur par défaut

  final ImageUploader imageUploader = ImageUploader(FirebaseStorage.instance);


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();


  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "ENIM PRESS",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: const Color.fromARGB(255, 226, 223, 223),
            ),
            isScrollable: true,
            tabs: const [
              Tab(
                child: Text(
                  "General",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Scolaire",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Parascolaire",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Profil",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GeneralScreen(),
            const Text("Scolaire Screen"),
            const Text("Parascolaire Screen"),
            const ProfileScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      title: const Text('Ajouter un Article'),
                      content: Column(
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: 'Titre',
                            ),
                          ),
                          TextField(
                            controller: _authorController,
                            decoration: const InputDecoration(
                              hintText: 'Auteur',
                            ),
                          ),
                          TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: _contentController.text.isNotEmpty ? _contentController.text : 'Scolaire',
                            items: const [
                              DropdownMenuItem(value: 'Scolaire', child: Text('Scolaire')),
                              DropdownMenuItem(value: 'Parascolaire', child: Text('Parascolaire')),
                            ],
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            onChanged: (value) {
                              setState(() {
                                _contentController.text = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Genre Article',
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              await selectAndUploadImageToFirebase()  ;
                              
                                setState(() {
                                  _imageUrl = downloadURL!;
                                });
                                
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      _imageUrl.isNotEmpty ? 'Image Selected' : 'No Image Selected',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                                        
                                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Annuler'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String titre = _titleController.text;
                            String auteur = _authorController.text;
                            String description = _descriptionController.text;
                            String type = _contentController.text;
                            String nv = 'null';
                            String image = _imageUrl;
                            addArticle(titre, auteur, description, type, nv, image);
                            Navigator.pop(context);
                          },
                          child: const Text('Ajouter'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

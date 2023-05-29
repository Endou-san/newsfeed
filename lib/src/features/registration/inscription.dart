import 'package:enim_press/src/features/registration/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../newsfeed/Pages/home_screen_editeur.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  final _formKey = GlobalKey<FormState>();
  String _selectedRole = '';
  final DatabaseReference _userCollection =
    // ignore: deprecated_member_use
    FirebaseDatabase.instance.reference().child('users');
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    String fullName = '';
    String Email = '';
    String password = '';
    String ConfirmP = '';
    return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
           child: Form(
            key: _formKey,

             child: Column(
               children: <Widget>[
                 Image.asset('lib/src/images/logo.png', height: 100.0, width: 100.0),
                 Center(
                   child: Text('Créer votre compte chez ENIM PRESS',
                   style: Theme.of(context).textTheme.titleSmall),
                 
                 ),
                 const SizedBox(height: 10.0),
                 TextFormField(
                  controller:_fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom Complet',
                    border: OutlineInputBorder()  
                   ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre Nom Complet' :null,
                  onChanged: (val) => fullName = val,
                 ),
                 const SizedBox(height: 10.0),
                 TextFormField(
                  controller: _emailController ,
                  decoration: const InputDecoration(
                     labelText: 'Email institutionnel',
                     border: OutlineInputBorder()  
                   ),
                  validator: (val) => val!.isEmpty ? 'Entrez votre email' :null,
                  onChanged: (val) => Email = val,
                 ),
                  const SizedBox(height: 10.0),
                 TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder()  
                   ),
                  validator: (val) => val!.length < 6 ? 'Entrez un mot de passe avec 6 caractères minimum' :null,
                  onChanged: (val) => password = val,
                  obscureText: true,
                 ),
                   const SizedBox(height: 10.0),
                 TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirmez le mot de passe',
                    border: OutlineInputBorder()  
                   ),
                  onChanged: (val) => ConfirmP = val,
                  validator: (val) => ConfirmP != password ? 'Mot de passe ne correspond pas! Réessayez!' :null,
                  obscureText: true,
                 ),
               
                const Text(
                  'Choisissez votre rôle',
                   style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    
                  ),
                 ),
                
              
            const SizedBox(height: 16.0),
            RadioListTile(
              title: const Text('Visiteur'),
              value: 'visiteur',
              groupValue: _selectedRole,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value as String;
                });
              },
            ),
            RadioListTile(
              title: const Text('Éditeur'),
              value: 'editeur',
              groupValue: _selectedRole,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value as String;
                });
              },
            ),
            const SizedBox(height: 32.0),
            TextButton(
                 onPressed: () {
                    // Perform an action when the button is pressed
                    //context.read<NavigationBloc>().add(ButtonPressedEvent());
                   
                    if (_formKey.currentState!.validate()) {
                      String Nom = _fullNameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      addUser(Nom,email,password);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreenEditeur()),);
                    } 
                    },
                 child: const Text('S\'inscrire'),
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 6, 6, 6)),
                   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                 ),   
               ),  
               ],
             ),
            ),
         ),
         ),
      
        );
  
  }
 
}


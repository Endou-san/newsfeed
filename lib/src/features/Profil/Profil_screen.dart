import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'user_data.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    UserData userData = UserData(name: 'Wiam', email: 'wiam@enim.ac.ma');

    // var isDark =MediaQuery.of(context).platformBrightness==Brightness.dark;
    
    String tProfileHeading = "Nom complet";
    String tProfileSubHeading = "Email institutionnel";
    
    String tMenu='Se déconnecter ';
    return Scaffold(
      
      body:SingleChildScrollView(
        child : Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                //width: 120,height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('lib/src/images/profil.png',width: 100,height: 100),
                
                ),
              ),
              const SizedBox(height: 10),

              // Text(tProfileHeading , style: Theme.of(context).textTheme.headline4,),
              // Text(tProfileSubHeading , style: Theme.of(context).textTheme.bodyText2,),
              const SizedBox(height: 20),
              Text(
                userData.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                userData.email,
                style: Theme.of(context).textTheme.bodyText2,
              ),
             
              const Divider(),
              const SizedBox(height: 10),
               //Menu 
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.alternate_sign_out, color: Colors.yellow),
                ),
              
                title: Text(tMenu , style: Theme.of(context).textTheme.bodyText1,),
                trailing:Container(
                  
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child:IconButton(onPressed : (){}, icon : const Icon(LineAwesomeIcons.angle_right)),
                  // child: const Icon(LineAwesomeIcons.angle_right,size: 18.0,color: Colors.grey )),
                  
                ))
              
            ],
            ),
        ),
        ),
    );
  }
  }




  
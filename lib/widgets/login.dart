import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/tasks.dart';


class Login extends StatelessWidget {
  const Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    children: <Widget>[
      Icon(Icons.checklist), // Icône de liste de tâches
      const SizedBox(width: 8), // Espace entre l'icône et le texte du titre
      Text("TaskHub", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: ('LobsterTwo-BoldItalic'),
        fontSize: 24)),
    ],
  ),
),
      body: Stack(
        children: [
          // Image en arrière-plan
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img4.jpg"), // Chemin de l'image dans les actifs
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu de la page (votre formulaire)
          Center(
            child: Card(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Coins arrondis
              ),
              color: Color.fromARGB(140, 205, 162, 164),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IntrinsicHeight(
                  child: SizedBox(
                    height: 350,
                    width: 310,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Login", // Titre ajouté
                          style: TextStyle(
                            fontSize: 35 , // Taille de la police
                            fontWeight: FontWeight.bold, // Gras
                            fontStyle: FontStyle.italic,
                            fontFamily: ('FFF_Tusj'),
                            color: Color.fromARGB(255, 233, 228, 225), // Couleur du texte
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),),
                            hintText: 'Nom utilisateur',
                             filled: true, // Active le remplissage de couleur de fond
                            fillColor: Color.fromARGB(176, 204, 211, 207), // Couleur de fond
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Mot de passe',
                            filled: true, // Active le remplissage de couleur de fond
                            fillColor: Color.fromARGB(176, 204, 211, 207), // Couleur de fond
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(height: 60),
                        TextButton(
                          onPressed: () {
                            // Utilisez Navigator.push pour naviguer vers la nouvelle classe
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Tasks()), // Remplacez "Tasks" par le nom de la classe vers laquelle vous souhaitez naviguer
                            );
                          },
                          child: Text("Se connecter",
                          style:TextStyle(fontWeight: FontWeight.w700,
                          fontSize:18),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 199, 188, 134)),
                            minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // Couleur du fond
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0), // Coins arrondis du bouton
                              ),
                            ),
                          ),
                        ),        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
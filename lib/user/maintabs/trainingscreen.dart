import 'package:aut_assist/info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}


class _TrainingPageState extends State<TrainingPage> {

  List<Module> modules = [
    Module(title: "Alphabets", dateCreated: "23/05/2002", icon: 'icon.png', progress: '50' , routeTo: ''),
    Module(title: "Sounds", dateCreated: "03/02/2003", icon: 'icon.png', progress: '25', routeTo: ''),
  ];

  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.email;
    var name = "";



    return Scaffold(
      backgroundColor: Color(0xFF272727),
      body: ListView.builder(
        itemCount: modules == null ? 1 : modules.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // StreamBuilder<QuerySnapshot>(
            //   stream: users,
            //   builder: (
            //     BuildContext context,
            //     AsyncSnapshot<QuerySnapshot> snapshot,
            // ) {
            //   if (snapshot.hasError) {
            //     return Text("Something went wrong");
            //   }
              //
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Text("Something went wrong");
              //
              // }

              // final data = snapshot.requireData;
              // final size = data.size;
              // var index = 0;
              //
              // while (index <= size) {
              //   if (data.docs[index]['email'] == uid) {
              //     name = data.docs[index]["firstName"];
              //     break;
              //   }
              // }


          //   return
            Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Modules ($name)",
                  style: const TextStyle(
                    fontFamily: "ModulesTitle",
                    color: Colors.grey,

                  ),
                ),
             //);

          // }
          ),


                Container(
                  margin: const EdgeInsets.fromLTRB(15.0, 3.0, 15.0, 3.0),
                  child: const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 1.0,
                  ),
                )
              ],
            );
          }
          index -= 1;
          var displayModule = modules[index];
          return createCard(displayModule);
        },
      ),
        );

  }
}


Widget createCard(module) {

  return Card(
        margin: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
        color: Colors.grey[500],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            "assets/${module.icon}",

                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(module.title),
                          const SizedBox(height: 4),
                          Text('${module.progress}%'),
                        ],
                      ),
                      ]
                  ),
                ],
              ),

                const SizedBox(width: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[600],
                  ),
                  child: const Text("Start"), // TODO: Change button to resume if started
                  onPressed: (){
                    // route to the module's page

                    // SNUB TESTING
                    if (kDebugMode) {
                      print("Entered into module: ${module.title}");
                    }
                    // END OF SNUB TESTING
                  },
                    ),
                  ],

                ),
          ),
          )
      );
}





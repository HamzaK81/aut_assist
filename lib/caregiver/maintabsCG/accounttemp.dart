// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
//
//
// class AccountCG extends StatefulWidget {
//   const AccountCG({Key? key}) : super(key: key);
//
//   @override
//   State<AccountCG> createState() => _AccountCGPageState();
// }
//
// class _AccountCGPageState extends State<AccountCG> {
//
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;
//
//   //TODO: ESTABLISH FIREBASE CONNECTION FOR THESE USERS
//
//   List users = [
//     ["Hamza Khurram", 2],
//     ["Hamza Khurram", 2],
//     ["Hamza Khurram", 2]
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = FirebaseAuth.instance;
//     final User? user = auth.currentUser;
//     final uid = user?.email;
//     CollectionReference caregivers = FirebaseFirestore.instance.collection('caregivers');
//
//     return Scaffold(
//         backgroundColor: const Color(0xFFB6B3B3),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FutureBuilder<DocumentSnapshot>(
//                 future: caregivers.doc("$uid").get(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<DocumentSnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     Map<String, dynamic> data =
//                         snapshot.data!.data() as Map<String, dynamic>;
//                     return Flexible(
//                       child: Container(
//                         margin: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
//                         padding: const EdgeInsets.all(0.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(
//                                   20.0, 8.0, 15.0, 0.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Name and Data
//                                   Flexible(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "${data['name']}",
//                                           style: const TextStyle(
//                                             color: Color(0xFF11245A),
//                                             fontSize: 25.0,
//                                             fontWeight: FontWeight.bold,
//                                             letterSpacing: 1.2,
//                                           ),
//                                         ),
//                                         Text(
//                                           "Active Patients: ${data['patients']}",
//                                           style: const TextStyle(
//                                             color: Colors.black54,
//                                             fontSize: 15.0,
//                                             letterSpacing: 1.1,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   //Display Picture
//                                   Container(
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(500),
//                                       child: SizedBox(
//                                         width: 100,
//                                         height: 100,
//                                         child: Image.asset("assets/icon.png"),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Padding(
//                               padding:
//                                   EdgeInsets.fromLTRB(40.0, 35.0, 40.0, 15.0),
//                               child: Divider(
//                                 color: Colors.blueGrey,
//                                 thickness: 1.5,
//                                 height: 1.0,
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
//                               child: Text(
//                                 "PATIENTS",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   letterSpacing: 1.3,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 25.0),
//                               child: Row(
//                                 children: [
//                                   ElevatedButton.icon(
//                                       onPressed: () {},
//                                       style: ElevatedButton.styleFrom(
//                                         primary: Colors.red,
//                                       ),
//                                       icon: const Icon(
//                                         Icons.person_add,
//                                         size: 15.0,
//                                       ),
//                                       label: const Text(
//                                         "ADD PATIENT",
//                                         style: TextStyle(fontSize: 10.0),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                             Flexible(
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//                                   child: ListView.builder(
//                                       itemCount: users.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         var display = users[index];
//                                         return createUserCard(display);
//                                         // return Text('${display[0]}');
//                                       }),
//                                 )),
//                           ],
//                         ),
//                         //     ),
//                       ),
//                     );
//                   }
//                   return const Center(child: Text("LOADING..."));
//                 }),
//           ],
//         ));
//   }
// }
//
// Widget createUserCard(module) {
//   return Card(
//       margin: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
//       color: Colors.grey[500],
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
//         child: IntrinsicHeight(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Column(
//                   children: [
//                     Row(children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(2.0, 2.0, 10.0, 2.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(500),
//                           child: SizedBox(
//                             width: 75,
//                             height: 75,
//                             child: Image.asset(
//                               "assets/icon.png",
//                             ),
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 2,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               '${module[0]}',
//                               style: const TextStyle(
//                                 color: Color(0xFF11245A),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15.0,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 4,
//                             ),
//                             Text(
//                               'Age: ${module[1]}',
//                               style: const TextStyle(
//                                 color: Color(0xFF11245A),
//                                 fontSize: 13.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ]),
//                   ],
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                 Flexible(
//                   flex: 1,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.red[600],
//                     ),
//                     child: const Text("Profile"),
//                     onPressed: () {
//                       // TODO: route to the module's page
//                     },
//                   ),
//                 ),
//               ])
//             ],
//           ),
//         ),
//       ));
// }
import 'package:aut_assist/training_modules/image_word/image_word_exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'image_sound/image_sound_exercise.dart';
import 'image_word/image_word.dart';

class CreateModule extends StatefulWidget {
  String activePatient;
  CreateModule({Key? key, required this.activePatient}) : super(key: key);

  @override
  State<CreateModule> createState() => _ImageWordTemplateState();
}

List<dynamic> exercises = [];

class _ImageWordTemplateState extends State<CreateModule> {
  int index = 1;
  var displayVal = "1";
  var moduleTypeVal = "Image-Word";
  final dropDownVals = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  final moduleTypes = ["Image-Word", "Image-Sound", "Sound-Word"];
  var totalExercises = 1;

  @override
  void dispose() {
    exercises = [];
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController moduleNameController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFB6B3B3),
      appBar: AppBar(
        toolbarHeight: 45.0,
        backgroundColor: Color(0xFF36474F),
        title: const Text(
          "NEW MODULE",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 21.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 15.0),
                    child: TextField(
                      controller: moduleNameController,
                      decoration: const InputDecoration(
                        labelText: "Module Name",
                        labelStyle: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 13.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    const Text("Type of Module:  ",
                      style: TextStyle(
                        letterSpacing: 1.0,
                      ),
                    ),
                    DropdownButton(
                        value: moduleTypeVal,
                        items: moduleTypes.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val,
                              style: TextStyle(
                                letterSpacing: 1.2,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[900],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            moduleTypeVal = newVal!;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Total Number of Exercises:   ",
                  style: TextStyle(
                    letterSpacing: 1.0,
                  ),
                  ),
                  DropdownButton(
                      value: displayVal,
                      items: dropDownVals.map((String dropDownVals) {
                        return DropdownMenuItem(
                          value: dropDownVals,
                          child: Text(dropDownVals,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          displayVal = newVal!;
                          totalExercises = int.parse(newVal);
                        });
                      }),
                ],
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: totalExercises,
                  itemBuilder: (BuildContext context, int index) {
                    return ExerciseCardImageWord(
                      cardIndex: index,
                      moduleType: moduleTypeVal,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text("Create Module"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () async {
                      final moduleName = moduleNameController.text;

                      var exerciseCounter = 0;
                      for (dynamic exercise in exercises) {
                        exerciseCounter += 1;

                        List questions = exercise.Questions;
                        var questionCounter = 0;
                        for (dynamic question in questions) {
                          questionCounter += 1;

                          // Check whether module contains an image
                          if (moduleTypeVal == "Image-Word" ||
                              moduleTypeVal == "Image-Sound") {
                            // Separate the image File
                            var image = question.Image;

                            // Setup Firebase Storage bucket reference
                            final _bucketImage = FirebaseStorage.instance.ref(
                                'users/${widget.activePatient}/modules/$moduleName'
                                '/exercise$exerciseCounter/'
                                'question$questionCounter/image.png');

                            final _bucketSound = FirebaseStorage.instance.ref(
                                'users/${widget.activePatient}/modules/$moduleName'
                                '/exercise$exerciseCounter/'
                                'question$questionCounter/audio.aac');

                            // Store the image to the cloud storage
                            await _bucketImage.putFile(image);

                            // Get download URL for future reference
                            String url = await _bucketImage.getDownloadURL();

                            // If the Module is an "Image-Word"
                            if (moduleTypeVal == "Image-Word") {
                              // Create data set
                              var data = {
                                "Image": url,
                                "Word": question.Word,
                              };

                              DocumentReference _moduleRef = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(widget.activePatient)
                                  .collection('modules')
                                  .doc(moduleName);

                              await _moduleRef.set({"type": "ImageWord"});

                              await _moduleRef
                                  .collection('exercises')
                                  .doc('exercise$exerciseCounter')
                                  .set({"exists": true});

                              await _moduleRef
                                  .collection('exercises')
                                  .doc('exercise$exerciseCounter')
                                  .collection('questions')
                                  .doc('question$questionCounter')
                                  .set(data);
                            } else if (moduleTypeVal == "Image-Sound") {
                              // Store the sound to the cloud storage
                              await _bucketImage.putFile(question.Sound);

                              var data = {
                                "Image": url,
                                "Sound": question.Sound,
                              };

                              DocumentReference _moduleRef = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(widget.activePatient)
                                  .collection('modules')
                                  .doc(moduleName);

                              await _moduleRef.set({"type": "ImageSound"});

                              await _moduleRef
                                  .collection('exercises')
                                  .doc('exercise$exerciseCounter')
                                  .set({"exists": true});

                              await _moduleRef
                                  .collection('exercises')
                                  .doc('exercise$exerciseCounter')
                                  .collection('questions')
                                  .doc('question$questionCounter')
                                  .set(data);
                            }
                          }
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCardImageWord extends StatefulWidget {
  int cardIndex;
  String moduleType;
  ExerciseCardImageWord(
      {Key? key, required this.cardIndex, required this.moduleType})
      : super(key: key);

  @override
  State<ExerciseCardImageWord> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCardImageWord> {
  var created = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
        color: Colors.grey[500],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding:
                            //   const EdgeInsets.fromLTRB(2.0, 2.0, 10.0, 2.0),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(500),
                            //     child: SizedBox(
                            //       width: 50,
                            //       height: 50,
                            //       child: Image.asset(
                            //         "assets/brain.jpeg",
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    child: Text(
                                      'Exercise ${widget.cardIndex + 1}',
                                      style: const TextStyle(
                                        color: Color(0xFF11245A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[800],
                      ),
                      child: created[widget.cardIndex] == false
                          ? Text("Create")
                          : const Text("View"),
                      onPressed: () {
                        setState(() {
                          created[widget.cardIndex] = true;
                        });

                        if (widget.moduleType == "Image-Word") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageWordExercise(
                                      index: widget.cardIndex)));
                        } else if (widget.moduleType == "Image-Sound") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageSoundExercise(
                                      index: widget.cardIndex)));
                        }
                      },
                    ),
                  ),
                ])
              ],
            ),
          ),
        ));
  }
}

dynamic addExerciseToModule(dynamic exercise) {
  exercises.add(exercise);
}

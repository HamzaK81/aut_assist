import 'package:aut_assist/training_modules/create_module.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_word.dart';
import 'dart:io';


class ImageWordExercise extends StatefulWidget {
  int index;
  ImageWordExercise({Key? key, required this.index}) : super(key: key);

  @override
  State<ImageWordExercise> createState() => _ImageWordExerciseState();
}


var numPairs = 0;
List<ImageWordQuestion> questions = [];

class _ImageWordExerciseState extends State<ImageWordExercise> {
  dynamic display = const Text("");

  @override
  void dispose() {
    setState(() {
      numPairs = 0;
      questions = [];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6B3B3),
      appBar: AppBar(
        backgroundColor: Color(0xFF36474F),
        toolbarHeight: 45.0,
        title: const Text(
          "CREATE EXERCISE",
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "EXERCISE ${widget.index + 1}",
              style: const TextStyle(fontSize: 16.0, letterSpacing: 1.0),
            )),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Divider(
                thickness: 1,
                height: 1,
                color: Colors.black,
              ),
            ),
            const Text(
              "Add Question",
              style: TextStyle(
                fontSize: 15.0,
                letterSpacing: 1.2,
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 500,
                child: ListView(
                    children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                          child: display
                      ),
                    ],
                  )
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                thickness: 1,
                height: 1,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Questions: $numPairs"),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[800],
                              // Colors.red[600],
                            ),
                            onPressed: () {
                              setState(() {
                                display = ImageWordPair(index: numPairs, confirmed: false,);
                                numPairs += 1;
                              });
                            },
                            child: const Text("Add New Question")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[900],
                            ),
                            onPressed: () {
                              ImageWordExerciseObject exercise =
                              ImageWordExerciseObject("widget.index + 1", questions);
                              addExerciseToModule(exercise);
                              // print(exercises[widget.index+1].Questions[0].Word);
                              Navigator.pop(context);
                            },
                            child: const Text("Confirm Exercise")),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWordPair extends StatefulWidget {
  int index;
  bool confirmed;
  ImageWordPair({Key? key, required this.index, required this.confirmed}) : super(key: key);

  @override
  State<ImageWordPair> createState() => _ImageWordPairState();
}

class _ImageWordPairState extends State<ImageWordPair> {
  bool uploaded = false;
  dynamic image = "";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return widget.confirmed
        ? const Text("Data Saved")
        : Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    uploaded
                        ? Image.file(image)
                        : SizedBox(
                      height: 100,
                        width: 100,
                        child: Image.asset('assets/defaultQuestion.png'),
                    ),
                    TextButton(
                      onPressed: () async {
                        XFile? pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 100,
                        );
                        setState(() {
                          image = File(pickedFile!.path);
                          uploaded = true;
                        });
                      },
                      child: Text("Upload Image",
                      style: TextStyle(
                        color: Colors.red[900],
                        letterSpacing: 1.0,
                      ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: "Correct Answer",
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],

    ),
                    onPressed: () {

                      final question = ImageWordQuestion(image, _controller.text);

                      setState(() {
                        uploaded = false;
                        widget.confirmed = true;
                        _controller.clear();
                        questions.add(question);
                      });



                    },
                    icon: Icon(Icons.done),
                    label: Text("Confirm"),
                  ),
                )
              ],
            ),
          );
  }
}

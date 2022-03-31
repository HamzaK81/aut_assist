import 'package:aut_assist/training_modules/sound_handling/sound_recorder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../create_module.dart';
import '../sound_handling/sound_player.dart';
import 'image_sound.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class ImageSoundExercise extends StatefulWidget {
  int index;
  ImageSoundExercise({Key? key, required this.index}) : super(key: key);

  @override
  State<ImageSoundExercise> createState() => _ImageSoundExerciseState();
}

var numPairs = 0;
List<ImageSoundQuestion> questions = [];
var soundPath = "default.aac";

class _ImageSoundExerciseState extends State<ImageSoundExercise> {
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
                child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 32),
                          child: display),
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
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                display = ImageSoundPair(
                                  index: numPairs,
                                  confirmed: false,
                                );
                                numPairs += 1;
                              });
                            },
                            child: const Text("Add New Question")),
                        TextButton(
                            onPressed: () {
                              ImageSoundExerciseObject exercise =
                              ImageSoundExerciseObject("widget.index + 1", questions);
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

class ImageSoundPair extends StatefulWidget {
  int index;
  bool confirmed;
  ImageSoundPair({Key? key, required this.index, required this.confirmed})
      : super(key: key);

  @override
  State<ImageSoundPair> createState() => _ImageSoundPairState();
}

class _ImageSoundPairState extends State<ImageSoundPair> {
  bool uploaded = false;
  dynamic image = "";


  final recorder = SoundRecorder(toFilePath: soundPath);
  final player = SoundPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorder.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'RECORD';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

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
                            child: Image.asset('assets/icon.png'),
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
                      child: Text("Upload Image"),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(155, 40),
                      primary: primary,
                      onPrimary: onPrimary,
                    ),
                    onPressed: () async {
                      recorder.toggleRecording();
                      setState(() {
                        isRecording = recorder.isRecording;
                      });
                      },
                    icon: Icon(icon),
                    label: Text(
                      text,
                      style: TextStyle(),
                    )),
                ElevatedButton(
                    onPressed: () async {
                      await player.togglePlaying(whenFinished: (){});

                },
                    child: const Text("Play Recording")),
                TextButton.icon(
                  onPressed: () {
                    // final soundLocation = File();
                    // final question = ImageSoundQuestion(image, File(soundLocation.toString()));

                    setState(() {
                      uploaded = false;
                      widget.confirmed = true;
                      // questions.add(question);
                    });



                  },
                  icon: Icon(Icons.done),
                  label: Text("Confirm"),
                )
              ],
            ),
          );
  }
}

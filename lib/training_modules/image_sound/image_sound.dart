import 'dart:io';

class ImageSoundQuestion {

  File Image;
  File Sound;


  ImageSoundQuestion(this.Image, this.Sound);
}


class ImageSoundExerciseObject {

  String ExerciseNum;
  List<ImageSoundQuestion> Questions;

  ImageSoundExerciseObject(this.ExerciseNum, this.Questions);

}
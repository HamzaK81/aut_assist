import 'dart:io';

class ImageWordQuestion {

  File Image;
  String Word;


  ImageWordQuestion(this.Image, this.Word);
}


class ImageWordExerciseObject {

  String ExerciseNum;
  List<ImageWordQuestion> Questions;

  ImageWordExerciseObject(this.ExerciseNum, this.Questions);

}
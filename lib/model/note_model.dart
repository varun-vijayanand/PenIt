// ignore: unused_import
import 'package:flutter/cupertino.dart';

class NoteModel {
  int id;
  String title;
  String body;
  // ignore: non_constant_identifier_names
  DateTime creation_date;
  
  // ignore: non_constant_identifier_names
  NoteModel({this.id, this.title, this.body, this.creation_date});

  Map<String, dynamic> toMap(){
    return(
      {
        "id": id,
        "title":title,
        "body": body,
        "creation_date" : creation_date.toString(),
      }
    );
  }

}


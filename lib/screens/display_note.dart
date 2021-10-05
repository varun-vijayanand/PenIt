import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pen_it/database/db_provider.dart';
import 'package:pen_it/model/note_model.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final NoteModel note = ModalRoute.of(context).settings.arguments as NoteModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        //title: Text(note.title),
        actions: [
          IconButton(onPressed: (){
            DatabaseProvider.db.deleteNotes(note.id);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade100,
                        blurRadius: 1.0,
                        spreadRadius: 1.0
                      ), 
                    ]
              ),
            child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10, horizontal: 20),
                  child: Column(
                    children: [
                      Text(note.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red)),
                      SizedBox(height: 20,),
                      Text(note.body, style: TextStyle(fontSize: 20, color: Colors.red)),
                    ],
                  ) ,
                ),
            ),
        ),
      ),
    );
  }
}
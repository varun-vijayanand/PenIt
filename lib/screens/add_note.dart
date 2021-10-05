import 'package:flutter/material.dart';
import 'package:pen_it/database/db_provider.dart';
import 'package:pen_it/model/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({ Key key }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  String title;
  String body;
  DateTime date;

  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();
  
  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print("Note Saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:
            Text("Add new Note", style: TextStyle(fontSize: 35, color: Colors.white, fontFamily: 'Caveat'),),
        ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
                  BoxShadow(
                    color: Colors.red.shade200,
                    blurRadius: 1.0,
                    spreadRadius: 1.0
                  ), 
                ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:10, horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.red,fontFamily: 'Caveat', fontSize: 30)
                  ),
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: TextField(
                    controller: bodyController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "start typing...",
                      hintStyle: TextStyle(color: Colors.red, fontFamily: 'Caveat', fontSize: 20)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now();
          });
          NoteModel note = NoteModel(title: title, body: body, creation_date: date);
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        icon: Icon(Icons.save, color: Colors.white,), 
        label:Text("save", style: TextStyle(color: Colors.white, fontFamily: 'Caveat', fontSize: 20), ), 
        backgroundColor: Colors.red 
      ),
    );
  }
}
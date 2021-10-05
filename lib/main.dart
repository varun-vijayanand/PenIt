import 'package:flutter/material.dart';
import 'package:pen_it/database/db_provider.dart';
import 'package:pen_it/model/note_model.dart';
import 'package:pen_it/screens/add_note.dart';
import 'package:pen_it/screens/display_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(context)=> HomeScreen(),
        "/AddNote" : (context)=>AddNote(),
        "/ShowNote" : (context) => ShowNote(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.red,
        title:Row(
          children: [
            Text(" Pen It", 
                  style: TextStyle(
                    fontFamily: 'Caveat' ,
                    fontSize: 50, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
            Column(
              children: [
                Container(
                  height: 18,
                ),
                Text(" ...and never forget",
                style: TextStyle(
                        fontFamily: 'Caveat' ,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          shadowColor: Colors.red,
          elevation: 5,
        ),
      body: FutureBuilder(
        future: getNotes(),
        // ignore: missing_return
        builder: (context, noteData) {
          switch(noteData.connectionState){
            case ConnectionState.waiting : 
            {
              return Center(child: CircularProgressIndicator());
            }
            case ConnectionState.done :
            {
              if(noteData.data == Null){
                return Center(child: Text("You dont have any notes yet", 
                style: TextStyle(
                  fontSize: 30, 
                  fontFamily: 'Caveat', 
                  color: Colors.red
                  ),
                  ),
                );
              } else {
                return Padding
                (
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: noteData.data.length,
                    itemBuilder: (context, index){
                      String title = noteData.data[index]["title"];
                      String body = noteData.data[index]["body"];
                      // ignore: non_constant_identifier_names
                      String creation_date = noteData.data[index]["creation_date"];
                      // ignore: unused_local_variable
                      int id = noteData.data[index]["id"];
                      return Card(
                          shadowColor: Colors.red.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 30,
                          child: ListTile(
                            onTap: (){
                              Navigator.pushNamed(context, "/ShowNote",
                                arguments: NoteModel(
                                  title: title,
                                  body: body,
                                  creation_date: DateTime.parse(creation_date),
                                  id: id,
                                ),
                              );
                            },
                            minVerticalPadding: 10,
                            title: Text(title, style: TextStyle(fontSize: 20, color: Colors.red),),
                            subtitle: Text(body, style: TextStyle(color: Colors.red), maxLines: 1),
                        ),
                      );
                    },
                  ),
                );
                
              }
            }
          }
        },
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: (){
              Navigator.pushNamed(context, "/AddNote");
            },
            child: Icon(Icons.edit, size: 35,),
          ),
        ),
      ),
    );
  }
}

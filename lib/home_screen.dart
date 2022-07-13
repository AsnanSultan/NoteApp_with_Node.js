import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Provider/notes_provider.dart';
import 'package:note_app/add_newNote_screen.dart';
import 'package:provider/provider.dart';

import 'Models/Note.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Note App"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false)
          ? (notesProvider.notes.length > 0)
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (context, index) {
                    Note currentNote = notesProvider.notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewNoteScreen(
                                      isUpdate: true,
                                      note: currentNote,
                                    )));
                      },
                      onLongPress: () {
                        notesProvider.deleteNote(currentNote);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentNote.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              currentNote.content!,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Text("Click on + to add new note"),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => AddNewNoteScreen(
                        isUpdate: false,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

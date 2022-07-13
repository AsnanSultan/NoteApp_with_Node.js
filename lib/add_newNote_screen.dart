import 'package:flutter/material.dart';
import 'package:note_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'Models/Note.dart';

class AddNewNoteScreen extends StatefulWidget {
  AddNewNoteScreen({Key? key, required this.isUpdate, this.note})
      : super(key: key);
  final bool isUpdate;
  final Note? note;
  @override
  _AddNewNoteScreenState createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  FocusNode notefocus = FocusNode();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  void addNewNote() {
    Note note = Note(
        id: Uuid().v1(),
        userId: "asnan",
        title: title.text,
        content: content.text,
        dateTime: DateTime.now());
    Provider.of<NotesProvider>(context, listen: false).addNote(note);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isUpdate) {
      title.text = widget.note!.title!;
      content.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                widget.note!.title = title.text;
                widget.note!.content = content.text;
                widget.note!.dateTime = DateTime.now();
                Provider.of<NotesProvider>(context, listen: false)
                    .updateNote(widget.note!);
                Navigator.pop(context);
              } else
                addNewNote();
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            TextField(
              controller: title,
              autofocus: !widget.isUpdate,
              onSubmitted: (value) {
                if (value != "") notefocus.requestFocus();
              },
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "title",
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                controller: content,
                focusNode: notefocus,
                maxLines: null,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: "title",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

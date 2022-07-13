import 'package:flutter/cupertino.dart';
import 'package:note_app/Services/api_service.dart';

import '../Models/Note.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];
  NotesProvider() {
    fetchNotes();
  }
  void sortNotes() {
    notes.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNote("asnan");
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}

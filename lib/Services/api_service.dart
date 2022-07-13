import 'dart:convert';

import '../Models/Note.dart';
import "package:http/http.dart" as http;

class ApiService {
  static String _baseUrl = "https://protected-lake-85761.herokuapp.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
  }

  static Future<List<Note>> fetchNote(String userId) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userId": userId});
    var decoded = jsonDecode(response.body);
    List<Note> notes = [];

    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}

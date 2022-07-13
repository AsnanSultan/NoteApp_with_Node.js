import 'package:flutter/material.dart';
import 'package:note_app/Provider/notes_provider.dart';
import 'package:note_app/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
      ],
      child: MaterialApp(
        title: "Note App",
        home: MyHomeScreen(),
      ),
    );
  }
}

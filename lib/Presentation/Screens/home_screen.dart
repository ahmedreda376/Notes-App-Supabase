import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/colors.dart';
import 'package:flutter_application_1/Data/auth.dart';
import 'package:flutter_application_1/Data/notes.dart';
import 'package:flutter_application_1/Presentation/Screens/login_screen.dart';
import 'package:flutter_application_1/Presentation/Screens/create_note_screen.dart';
import 'package:flutter_application_1/Presentation/Screens/update_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    loadNotes();
    super.initState();
  }

  loadNotes() async {
    notes = await Notes().readNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNoteScreen()),
          );
          loadNotes();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('My Notes'),
        //logOut
        actions: [
          IconButton(
            onPressed: () async {
              await Auth().logOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: StreamBuilder(
        stream: Notes().realTimeRead(),
        builder: (context, snapshot) {
          final rnotes = snapshot.data;
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final note = rnotes[index];
                return Padding(
                  padding: const EdgeInsets.all(15),

                  child: ListTile(
                    tileColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    title: Text(note['title']),
                    subtitle: Text(note['content']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Delete
                        IconButton(
                          onPressed: () async {
                            await Notes().deleteNote(note['id']);
                            loadNotes();
                          },
                          icon: Icon(Icons.delete),
                        ),
                  
                        //Edit
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateNoteScreen(
                                  noteTitle: note['title'],
                                  noteContent: note['content'],
                                  noteId: note['id'],
                                ),
                              ),
                            );
                            loadNotes();
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 1),
              itemCount: rnotes.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}

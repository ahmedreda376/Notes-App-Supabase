
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/notes.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({
    super.key,
  });

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Note')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Note Title',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Note Content',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                try {
                    await Notes().createNote(
                      titleController.text,
                      contentController.text,
                    );


                  Navigator.pop(context);
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text('Create Note'),
            ),
          ],
        ),
      ),
    );
  }
}

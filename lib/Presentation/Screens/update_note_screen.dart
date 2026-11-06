
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/notes.dart';

class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen({
    super.key,
    this.noteId,
    this.noteTitle,
    this.noteContent,
  });

 final int? noteId;

  final String? noteTitle;
  final String? noteContent;

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.noteTitle ?? '';
    contentController.text = widget.noteContent ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Note')),
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
                    await Notes().updateNote(
                      titleController.text,
                      contentController.text,
                      widget.noteId!,
                    );

                  Navigator.pop(context);
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}

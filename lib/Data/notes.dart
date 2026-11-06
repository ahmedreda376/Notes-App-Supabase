import 'package:supabase_flutter/supabase_flutter.dart';

class Notes {
  final supa = Supabase.instance.client;

  // Create Note
  Future<void> createNote(String title, String content) async {
    final userId = supa.auth.currentUser!.id;

    await supa.from('notes').insert({
      'title': title,
      'content': content,
      'user_id': userId,
    });
  }

  // Read All Notes
  Future<List<Map<String, dynamic>>> readNotes() async {
    final userId = supa.auth.currentUser!.id;
    final response = await supa.from('notes').select().eq('user_id', userId);
    return response;
  }

  // Update Note
  Future<void> updateNote(String title, String content, int id) async {
    final userId = supa.auth.currentUser!.id;

    await supa
        .from('notes')
        .update({'title': title, 'content': content})
        .eq('id', id)
        .eq('user_id', userId);
  }

  // Delete Note
  Future<void> deleteNote(int id) async {
    final userId = supa.auth.currentUser!.id;

    await supa.from('notes').delete().eq('id', id).eq('user_id', userId);
  }
}

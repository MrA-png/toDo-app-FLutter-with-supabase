// ignore_for_file: avoid_print
import 'package:supabase/supabase.dart';

// ignore: camel_case_types
class supabaseHandler {
  static String supabaseURL = "";
  static String supabaseKey = "";

  final client = SupabaseClient(supabaseURL, supabaseKey);

  addData(String taskValue, bool statusValue) {
    var response = client
        .from("todo_table")
        .insert({'task': taskValue, 'status': statusValue}).execute();
    print(response);
  }

  readData() async {
    var response = await client
        .from("todo_table")
        .select()
        .order('task', ascending: true)
        .execute();
    print(response);
    final dataList = response.data as List;
    return dataList;
  }

  updateData(int id, bool statusValue) {
    var response = client
        .from("todo_table")
        .update({'status': statusValue})
        .eq('id', id)
        .execute();
    print(response);
  }

  deleteData(int id) async {
    var response = client.from("todo_table").delete().eq('id', id).execute();
    print(response);
  }
}

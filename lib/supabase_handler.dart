// ignore_for_file: avoid_print
import 'package:supabase/supabase.dart';

// ignore: camel_case_types
class supabaseHandler {
  static String supabaseURL = "https://cmqlaoxbbkvohooslnrm.supabase.co";
  static String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtcWxhb3hiYmt2b2hvb3NsbnJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEzNzA2OTAsImV4cCI6MjAyNjk0NjY5MH0.6TDmAenO8777wf0xciMXm8JP4RpMYgH2DpefL6S-6uE";

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

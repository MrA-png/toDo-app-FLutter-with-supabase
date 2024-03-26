// ignore_for_file: avoid_print, camel_case_types, duplicate_ignore
// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class supabaseHandler {
  addData(String task, bool status, context) async {
    try {
      await Supabase.instance.client
          .from('todo_table')
          .upsert({'task': task, 'status': status});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved The task0'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('error saving task'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List?> readData(context) async {
    print('Read Data');
    try {
      var response = await Supabase.instance.client.from('todo_table').select();
      final dataList = response as List;
      return dataList;
    } catch (e) {
      print('Response Error ${e}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error accured while getting Data'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  updateData(int id, bool statusval) async {
    await Supabase.instance.client
        .from('todo_table')
        .upsert({'id': id, 'status': statusval});
  }

  deleteData(int id) async {
    await Supabase.instance.client
        .from('todo_table')
        .delete()
        .match({'id': id});
  }
}

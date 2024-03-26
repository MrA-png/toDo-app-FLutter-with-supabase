import 'package:flutter/material.dart';
import 'supabase_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ToDO App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  supabaseHandler supabaseHendler = supabaseHandler();
  late String newValue;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String newValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == null &&
              snapshot.connectionState == ConnectionState.none) {}

          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                color: snapshot.data?[index]['status'] ?? false
                    ? Colors.white
                    : Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Text(snapshot.data?[index]['task'] ?? ''),
                    ),
                    IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () {
                        supabaseHendler.updateData(
                            snapshot.data[index]['id'], true);
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        supabaseHendler.deleteData(snapshot.data[index]['id']);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        future: supabaseHendler.readData(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: TextField(
                onChanged: (value) {
                  newValue = value;
                },
              )),
              FloatingActionButton(
                onPressed: () {
                  supabaseHendler.addData(newValue,
                      false); // perbaiki code line ini karena muncull pesan : the non-nullable variable 'newValue' must be assigned before it can be used
                  setState(() {});
                },
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              )
            ],
          ),
        ),
      ),
    );
  }
}

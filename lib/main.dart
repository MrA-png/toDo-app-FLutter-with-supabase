import 'package:flutter/material.dart';
import 'supabase_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://cmqlaoxbbkvohooslnrm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtcWxhb3hiYmt2b2hvb3NsbnJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEzNzA2OTAsImV4cCI6MjAyNjk0NjY5MH0.6TDmAenO8777wf0xciMXm8JP4RpMYgH2DpefL6S-6uE',
  );
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? _user;
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
        title: const Text("Supabase with flutter"),
      ),
      body: FutureBuilder(
        future: supabaseHendler.readData(context),
        builder: ((context, AsyncSnapshot snapshot) {
          print("here ${snapshot.data.toString()}");
          if (snapshot.hasData == null &&
              snapshot.connectionState == ConnectionState.none) {}
          print("here1 ${snapshot.data.toString()}");
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  color: snapshot.data![index]['status']
                      ? Colors.white
                      : Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: Text(snapshot.data![index]['task']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          supabaseHendler.updateData(
                              snapshot.data[index]['id'], true);
                          // setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          supabaseHendler
                              .deleteData(snapshot.data[index]['id']);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        // future: supabaseHendler.readData(),
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
                  supabaseHendler.addData(newValue, false, context);
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

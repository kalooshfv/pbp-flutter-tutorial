import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbpfluttertutorial/model/to_do.dart';
import 'package:flutter/material.dart';
import 'package:pbpfluttertutorial/main.dart';
import 'package:pbpfluttertutorial/page/form.dart';
import 'package:pbpfluttertutorial/page/to_do_future.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do'),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              // Adding clickable menu
              ListTile(
                title: const Text('Counter'),
                onTap: () {
                  // Route the menu to the main page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
              ),
              ListTile(
                title: const Text('Form'),
                onTap: () {
                  // Route the menu to the form page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyFormPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('To Do'),
                onTap: () {
                  // Route the menu to the to do page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ToDoPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: to_do_future().fetchToDo(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "To do list is empty :(",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 2.0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].completed}"),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}

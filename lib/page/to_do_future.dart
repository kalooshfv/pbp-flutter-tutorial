import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbpfluttertutorial/model/to_do.dart';
import 'package:flutter/material.dart';
import 'package:pbpfluttertutorial/page/main.dart';
import 'package:pbpfluttertutorial/page/form.dart';

class to_do_future {
  Future<List<Todo>> fetchToDo() async {
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/todos?_start=0&_limit=10');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // decode the response into the json form
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // convert the json data into ToDo object
    List<Todo> listToDo = [];
    for (var d in data) {
      if (d != null) {
        listToDo.add(Todo.fromJson(d));
      }
    }

    return listToDo;
  }
}

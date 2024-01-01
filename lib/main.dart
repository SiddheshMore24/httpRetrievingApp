import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;


void main(){
  runApp(

      MaterialApp(
        home: HomePage(),
      )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.dev/api/people/";
  late List<dynamic> data;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<void> getData() async {
    var response = await http.get(
      Uri.parse(url),
      //  headers: {"Accept": "application/json"},
    );
    setState(() {
      var convertedData = json.decode(response.body);
      data = convertedData['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve data through http"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(data[index]['name'])),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

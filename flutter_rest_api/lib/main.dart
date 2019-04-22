import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState()=> new HomePageState();
}

class HomePageState extends State<HomePage>{

  Map data;
  List userData;

  Future getData() async{
    http.Response  response = await http.get("https://reqres.in/api/users?page=2");
    data = json.decode(response.body);

    setState(() {
      userData = data["data"];
    });
  }

  @override
  void initState() { 
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Belajar REST API"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData[index]["avatar"]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                    style: TextStyle(
                      fontSize: 20.0
                    ),),
                  )
                ],
              ),
            ),
          );
        },
        ),
    );
  }

}
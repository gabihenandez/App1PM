import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ListData extends StatefulWidget {
  
  @override 
  _ListaDatos createState() => _ListaDatos();

}

class _ListaDatos extends State<ListData>{
  //final String title = 'Aplicacion 1';
  //final List<String> items;
  //MyApp({Key? key, required this.items}) : super(key: key);
  List<String> usuarios=[];

  @override
  void initState(){
    super.initState();
    getRequest();
  }
  
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
      primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Actividad 1"),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: new Text('${index}.- ${usuarios[index]}'),
                ),
              );
            },
          ),
        ),
      )
    );
  }

  Future getRequest() async {
    var url = Uri.parse('https://randomuser.me/api/?results=100');
    final response = await http.get(url);
    //print(response.body);
    final Map<String, dynamic> decodedData = convert.jsonDecode(response.body);
      
    for(var user in decodedData['results']){
      String username= user['name']['title']+' ';
        username=user['name']['first']+' ';
        username+=user['name']['last'];
      setState(() {
        usuarios.add(username);
      });
    }
  }
}

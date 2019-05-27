import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'GitRepo.dart';
import 'Todoinfo.dart';
import 'UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Git Repo Json'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences prefs;
  List<Item> list;
  Item Oitem;
  var isLoading = false;

  Todoinfo todos;

  @override
  void initState() {
    // TODO: implement initState
    getPref(Oitem);
    super.initState();
    _fetchdata();
  }

  _fetchdata() async {
    final apistatus = await http.get(
        "https://api.github.com/search/repositories?q=flutter:featured");

    setState(() {
      isLoading = true;
    });

    print(apistatus.statusCode);

    if (apistatus.statusCode == 200) {
      Map data = json.decode(apistatus.body);

      //      repoitem = GitRepo.fromJson(data)
    //      var rest = data["Item"] as List;
      print(data);

      var gititem = data["items"] as List;
      print(gititem);

      list = gititem.map<Item>(
              (json) => Item.fromJson(json)
      ).toList();

      print(list[0].owner.login);
      print('id print :');

      isLoading = false;
      print(list[0].owner.login);
    }

    else if (apistatus.statusCode == 404) {
      print('Not found');
      throw Exception('Not found');
    }
    else {
      print('Failed to load photos');
      throw Exception('Failed to load photos');
    }
  }

  void addToFav(Item item) async{
    item.isFav = !Oitem.isFav;
    await prefs.setBool(Oitem.id.toString(), item.isFav);
    setState(() {});
  }
  void getPref(Item item) async{
    prefs = await SharedPreferences.getInstance();
    item.isFav = prefs.getBool(item.id.toString()) == null
    ? false
    : prefs.getBool(item.id.toString());

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),)
          : list.length != null  ? ListView.builder(itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(

                leading: CircleAvatar(
                  radius: 30.0,
          backgroundImage: NetworkImage( list[index].owner.avatarUrl),

//                  child: ClipOval(
//                    child: Image.network(
//                      list[index].owner.avatarUrl,
//                    ),
//                  ),
                ),

              title: Text( list[index].fullName),
              onTap:()
                {

                var todofrk, todooissue,todowatch,todocount;
                todofrk = list[index].fork.toString();
                todooissue = list[index].openIssues.toString();
                todowatch = list[index].watchers.toString();
                todocount = list[index].score.toString();
                print('$todocount');

                  todos = new Todoinfo(todofrk, todooissue,todowatch,todocount) ;
//                            print('$todos');
                             Navigator.push(context,
                    MaterialPageRoute(builder: (context)
                    => UserInfo(todo: todos)
                    ),
                  );

              },
              trailing: IconButton(icon: Icon(Icons.favorite_border,),
                  onPressed: (){
//                addtofav(Oitem);

              }),
            );
          }

      ):Container()
      ,

    );
  }


}


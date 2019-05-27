import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Todoinfo.dart';


class UserInfo extends  StatelessWidget {
  Todoinfo todo;
  UserInfo({Key key, @required this.todo}) ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: new Text('Display Data'),),
      body:new Center(
          child: new  Column(
          children: <Widget>[
          Container(
            child: Text(todo.todofrk,style:  TextStyle(color: Colors.green,fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900) ),
          ),
          Container(
            child: Text(todo.todooissue,style:  TextStyle(color: Colors.redAccent,fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900) ),
          ),
          Container(
            child: Text(todo.todowatch, style:  TextStyle(color: Colors.brown,fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900) ),
          ),
          Container(
            child: Text(todo.todocount,style:  TextStyle(color: Colors.red,fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w900) ),
          ),
        ],

        )
    )


    );

  }
}

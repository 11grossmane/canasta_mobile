import 'package:flutter/material.dart';
import 'package:my_app/home.dart';
import 'package:my_app/textInputWidget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black))),
                    onChanged: (text) => {
                      this.setState(() {
                        this.email = text;
                      })
                    },
                  )),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5))),
                  onChanged: (text) => {
                    this.setState(() {
                      this.email = text;
                    })
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  author: this.email,
                                )))
                  },
                  child: Text('Login'),
                  textColor: Colors.white,
                  color: Colors.blue,
                ),
              )
            ])));
  }
}

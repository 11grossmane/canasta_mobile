import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final Function(String) callback;
  TextInput({this.callback});

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInput> {
  @override
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    FocusScope.of(context).unfocus();
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: TextField(
          // onChanged: (text) => {this.changeText(text)},
          controller: this.controller,
          onEditingComplete: () => {print('complete')},
          onSubmitted: (text) {
            this.click();
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.message),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                tooltip: 'Post Message',
                splashColor: Colors.grey[500],
                onPressed: () {
                  this.click();
                },
              ),
              labelText: "Type a message:"),
        ));
  }
}

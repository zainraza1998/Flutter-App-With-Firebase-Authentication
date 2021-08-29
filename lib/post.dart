import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final Map data;
  Post({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(30),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        child: Expanded(
          child: Column(
            children: [
              Image.network(
                data['url'],
                height: 100,
                width: 100,
              ),
              Text(data['title']),
              Text(data['description']),
            ],
          ),
        ),
      ),
    );
  }
}

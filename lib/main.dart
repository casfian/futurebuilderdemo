import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:futurebuilderdemo/post.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> posts = [];

  Future<List<dynamic>> getPosts() async {
    var data =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var jsonData = json.decode(data.body);
    print(jsonData);

    for (var u in jsonData) {
      Post post =
          Post(u!['index'], u['id'], u['userid'], u['title'], u['body']);
      posts.add(post);
    }
    posts = jsonData;

    print(posts.length);
    print(posts);
    return posts;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
            child: FutureBuilder(
          future: getPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index]['title']),
                  subtitle: Text(snapshot.data[index]['body']),
                );
              },
            );
          },
        )),
      ),
    );
  }
}

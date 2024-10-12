import 'package:flutter/material.dart';
import 'package:grpc/grpc_web.dart';
import 'package:grpc_server_stuff/greeter.pbgrpc.dart';
import 'package:http/http.dart'
    as http; // Add this line to import the http package

import 'dart:convert'; // For JSON decoding
import 'package:sprintf/sprintf.dart';

void main() {
  runApp(MyApp());
}

void sayHelloJSON() async {
  final url = Uri.parse('http://localhost:8080/greeter.Greeter/SayHello');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({'name': 'name'});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

class MyApp extends StatelessWidget {
  final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080'));

  String _response = 'Press the button to make a network request';
  void _makeProtoRequest() async {
    _sayHello();
  }

  void _makeJSONRequest() async {
    sayHelloJSON();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'gRPC Flutter Web Client',
        home: Scaffold(
          appBar: AppBar(
            title: Text('gRPC Flutter Web Client'),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: _makeProtoRequest,
              child: Text('Make Proto Network Request'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _makeJSONRequest,
              child: Text('Make JSON Network Request'),
            ),
            SizedBox(height: 20),
            Text(
              _response,
              textAlign: TextAlign.center,
            ),
          ]),
        ));
  }

  Future<HelloReply> _sayHello() async {
    final client = GreeterClient(channel);
    final request = HelloRequest()..name = 'World';

    final response = await client.sayHello(request);
    return response;
  }
}

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

class MyApp extends StatelessWidget {
  final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080'));

  String _response = 'Press the button to make a network request';
  void _makeRequest() async {
    _sayHello();
  }

  @override
  Widget build(BuildContext context) {
    var example = HelloRequest(name: "name");
    for (final i in example.writeToBuffer()) {
      print(sprintf("%#04x ", [i]));
    }
    return MaterialApp(
        title: 'gRPC Flutter Web Client',
        home: Scaffold(
          appBar: AppBar(
            title: Text('gRPC Flutter Web Client'),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: _makeRequest,
              child: Text('Make Network Request'),
            ),
            SizedBox(height: 20),
            Text(
              _response,
              textAlign: TextAlign.center,
            ),
            Center(
              child: FutureBuilder<HelloReply>(
                future: _sayHello(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Connecting to server...');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data!.message);
                  } else {
                    return Text('No data received');
                  }
                },
              ),
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

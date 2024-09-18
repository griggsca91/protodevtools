import 'dart:io';
import 'package:grpc/grpc.dart';
import 'package:grpc_server_stuff/greeter.pbgrpc.dart';
import 'package:sprintf/sprintf.dart';

class GreeterService extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    return HelloReply(message: 'Hello, ${request.name}!');
  }
}

Future<void> main(List<String> args) async {
  var example = HelloRequest(name: "name");
  print(DebugInfo.fromBuffer(example.writeToBuffer().toList()));
  for (final i in example.writeToBuffer()) {
    print(sprintf("%#04x ", [i]));
  }
  final server = Server([GreeterService()]);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}

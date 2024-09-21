//
//  Generated code. Do not modify.
//  source: greeter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'greeter.pb.dart' as $0;

export 'greeter.pb.dart';

@$pb.GrpcServiceName('greeter.Greeter')
class GreeterClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/greeter.Greeter/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$sendComplexObject = $grpc.ClientMethod<$0.ComplexObjectRequest, $0.ComplexObjectResponse>(
      '/greeter.Greeter/SendComplexObject',
      ($0.ComplexObjectRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ComplexObjectResponse.fromBuffer(value));

  GreeterClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello($0.HelloRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseFuture<$0.ComplexObjectResponse> sendComplexObject($0.ComplexObjectRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendComplexObject, request, options: options);
  }
}

@$pb.GrpcServiceName('greeter.Greeter')
abstract class GreeterServiceBase extends $grpc.Service {
  $core.String get $name => 'greeter.Greeter';

  GreeterServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ComplexObjectRequest, $0.ComplexObjectResponse>(
        'SendComplexObject',
        sendComplexObject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ComplexObjectRequest.fromBuffer(value),
        ($0.ComplexObjectResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre($grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Future<$0.ComplexObjectResponse> sendComplexObject_Pre($grpc.ServiceCall call, $async.Future<$0.ComplexObjectRequest> request) async {
    return sendComplexObject(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello($grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.ComplexObjectResponse> sendComplexObject($grpc.ServiceCall call, $0.ComplexObjectRequest request);
}

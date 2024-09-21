//
//  Generated code. Do not modify.
//  source: greeter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = {
  '1': 'HelloRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode(
    'CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = {
  '1': 'HelloReply',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'response', '3': 2, '4': 1, '5': 11, '6': '.greeter.ComplexObjectResponse', '10': 'response'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert.base64Decode(
    'CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USOgoIcmVzcG9uc2UYAiABKA'
    'syHi5ncmVldGVyLkNvbXBsZXhPYmplY3RSZXNwb25zZVIIcmVzcG9uc2U=');

@$core.Deprecated('Use complexObjectRequestDescriptor instead')
const ComplexObjectRequest$json = {
  '1': 'ComplexObjectRequest',
};

/// Descriptor for `ComplexObjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List complexObjectRequestDescriptor = $convert.base64Decode(
    'ChRDb21wbGV4T2JqZWN0UmVxdWVzdA==');

@$core.Deprecated('Use complexObjectResponseDescriptor instead')
const ComplexObjectResponse$json = {
  '1': 'ComplexObjectResponse',
  '2': [
    {'1': 'string_value', '3': 1, '4': 1, '5': 9, '10': 'stringValue'},
    {'1': 'repeated_string_value', '3': 2, '4': 3, '5': 9, '10': 'repeatedStringValue'},
    {'1': 'int_value', '3': 3, '4': 1, '5': 5, '10': 'intValue'},
    {'1': 'bool_value', '3': 4, '4': 1, '5': 8, '10': 'boolValue'},
    {'1': 'optional_bool_value', '3': 5, '4': 1, '5': 8, '9': 1, '10': 'optionalBoolValue', '17': true},
    {'1': 'float_value', '3': 6, '4': 1, '5': 2, '10': 'floatValue'},
    {'1': 'enum_value', '3': 7, '4': 1, '5': 14, '6': '.greeter.ComplexObjectResponse.Corpus', '10': 'enumValue'},
    {'1': 'repeated_message_value', '3': 8, '4': 3, '5': 11, '6': '.greeter.Result', '10': 'repeatedMessageValue'},
    {'1': 'name', '3': 9, '4': 1, '5': 9, '9': 0, '10': 'name'},
    {'1': 'sub_message', '3': 10, '4': 1, '5': 11, '6': '.greeter.Result', '9': 0, '10': 'subMessage'},
    {'1': 'map_value', '3': 11, '4': 3, '5': 11, '6': '.greeter.ComplexObjectResponse.MapValueEntry', '10': 'mapValue'},
  ],
  '3': [ComplexObjectResponse_MapValueEntry$json],
  '4': [ComplexObjectResponse_Corpus$json],
  '8': [
    {'1': 'oneof_value'},
    {'1': '_optional_bool_value'},
  ],
};

@$core.Deprecated('Use complexObjectResponseDescriptor instead')
const ComplexObjectResponse_MapValueEntry$json = {
  '1': 'MapValueEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.greeter.Result', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use complexObjectResponseDescriptor instead')
const ComplexObjectResponse_Corpus$json = {
  '1': 'Corpus',
  '2': [
    {'1': 'CORPUS_UNSPECIFIED', '2': 0},
    {'1': 'CORPUS_UNIVERSAL', '2': 1},
    {'1': 'CORPUS_WEB', '2': 2},
    {'1': 'CORPUS_IMAGES', '2': 3},
    {'1': 'CORPUS_LOCAL', '2': 4},
    {'1': 'CORPUS_NEWS', '2': 5},
    {'1': 'CORPUS_PRODUCTS', '2': 6},
    {'1': 'CORPUS_VIDEO', '2': 7},
  ],
};

/// Descriptor for `ComplexObjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List complexObjectResponseDescriptor = $convert.base64Decode(
    'ChVDb21wbGV4T2JqZWN0UmVzcG9uc2USIQoMc3RyaW5nX3ZhbHVlGAEgASgJUgtzdHJpbmdWYW'
    'x1ZRIyChVyZXBlYXRlZF9zdHJpbmdfdmFsdWUYAiADKAlSE3JlcGVhdGVkU3RyaW5nVmFsdWUS'
    'GwoJaW50X3ZhbHVlGAMgASgFUghpbnRWYWx1ZRIdCgpib29sX3ZhbHVlGAQgASgIUglib29sVm'
    'FsdWUSMwoTb3B0aW9uYWxfYm9vbF92YWx1ZRgFIAEoCEgBUhFvcHRpb25hbEJvb2xWYWx1ZYgB'
    'ARIfCgtmbG9hdF92YWx1ZRgGIAEoAlIKZmxvYXRWYWx1ZRJECgplbnVtX3ZhbHVlGAcgASgOMi'
    'UuZ3JlZXRlci5Db21wbGV4T2JqZWN0UmVzcG9uc2UuQ29ycHVzUgllbnVtVmFsdWUSRQoWcmVw'
    'ZWF0ZWRfbWVzc2FnZV92YWx1ZRgIIAMoCzIPLmdyZWV0ZXIuUmVzdWx0UhRyZXBlYXRlZE1lc3'
    'NhZ2VWYWx1ZRIUCgRuYW1lGAkgASgJSABSBG5hbWUSMgoLc3ViX21lc3NhZ2UYCiABKAsyDy5n'
    'cmVldGVyLlJlc3VsdEgAUgpzdWJNZXNzYWdlEkkKCW1hcF92YWx1ZRgLIAMoCzIsLmdyZWV0ZX'
    'IuQ29tcGxleE9iamVjdFJlc3BvbnNlLk1hcFZhbHVlRW50cnlSCG1hcFZhbHVlGkwKDU1hcFZh'
    'bHVlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSJQoFdmFsdWUYAiABKAsyDy5ncmVldGVyLlJlc3'
    'VsdFIFdmFsdWU6AjgBIqMBCgZDb3JwdXMSFgoSQ09SUFVTX1VOU1BFQ0lGSUVEEAASFAoQQ09S'
    'UFVTX1VOSVZFUlNBTBABEg4KCkNPUlBVU19XRUIQAhIRCg1DT1JQVVNfSU1BR0VTEAMSEAoMQ0'
    '9SUFVTX0xPQ0FMEAQSDwoLQ09SUFVTX05FV1MQBRITCg9DT1JQVVNfUFJPRFVDVFMQBhIQCgxD'
    'T1JQVVNfVklERU8QB0INCgtvbmVvZl92YWx1ZUIWChRfb3B0aW9uYWxfYm9vbF92YWx1ZQ==');

@$core.Deprecated('Use resultDescriptor instead')
const Result$json = {
  '1': 'Result',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'snippets', '3': 3, '4': 3, '5': 9, '10': 'snippets'},
  ],
};

/// Descriptor for `Result`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultDescriptor = $convert.base64Decode(
    'CgZSZXN1bHQSEAoDdXJsGAEgASgJUgN1cmwSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhoKCHNuaX'
    'BwZXRzGAMgAygJUghzbmlwcGV0cw==');


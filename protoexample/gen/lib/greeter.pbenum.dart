//
//  Generated code. Do not modify.
//  source: greeter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ComplexObjectResponse_Corpus extends $pb.ProtobufEnum {
  static const ComplexObjectResponse_Corpus CORPUS_UNSPECIFIED = ComplexObjectResponse_Corpus._(0, _omitEnumNames ? '' : 'CORPUS_UNSPECIFIED');
  static const ComplexObjectResponse_Corpus CORPUS_UNIVERSAL = ComplexObjectResponse_Corpus._(1, _omitEnumNames ? '' : 'CORPUS_UNIVERSAL');
  static const ComplexObjectResponse_Corpus CORPUS_WEB = ComplexObjectResponse_Corpus._(2, _omitEnumNames ? '' : 'CORPUS_WEB');
  static const ComplexObjectResponse_Corpus CORPUS_IMAGES = ComplexObjectResponse_Corpus._(3, _omitEnumNames ? '' : 'CORPUS_IMAGES');
  static const ComplexObjectResponse_Corpus CORPUS_LOCAL = ComplexObjectResponse_Corpus._(4, _omitEnumNames ? '' : 'CORPUS_LOCAL');
  static const ComplexObjectResponse_Corpus CORPUS_NEWS = ComplexObjectResponse_Corpus._(5, _omitEnumNames ? '' : 'CORPUS_NEWS');
  static const ComplexObjectResponse_Corpus CORPUS_PRODUCTS = ComplexObjectResponse_Corpus._(6, _omitEnumNames ? '' : 'CORPUS_PRODUCTS');
  static const ComplexObjectResponse_Corpus CORPUS_VIDEO = ComplexObjectResponse_Corpus._(7, _omitEnumNames ? '' : 'CORPUS_VIDEO');

  static const $core.List<ComplexObjectResponse_Corpus> values = <ComplexObjectResponse_Corpus> [
    CORPUS_UNSPECIFIED,
    CORPUS_UNIVERSAL,
    CORPUS_WEB,
    CORPUS_IMAGES,
    CORPUS_LOCAL,
    CORPUS_NEWS,
    CORPUS_PRODUCTS,
    CORPUS_VIDEO,
  ];

  static final $core.Map<$core.int, ComplexObjectResponse_Corpus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ComplexObjectResponse_Corpus? valueOf($core.int value) => _byValue[value];

  const ComplexObjectResponse_Corpus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');

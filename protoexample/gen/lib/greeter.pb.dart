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

import 'greeter.pbenum.dart';

export 'greeter.pbenum.dart';

/// The request message containing the user's name.
class HelloRequest extends $pb.GeneratedMessage {
  factory HelloRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  HelloRequest._() : super();
  factory HelloRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HelloRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HelloRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'greeter'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HelloRequest clone() => HelloRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HelloRequest copyWith(void Function(HelloRequest) updates) => super.copyWith((message) => updates(message as HelloRequest)) as HelloRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HelloRequest create() => HelloRequest._();
  HelloRequest createEmptyInstance() => create();
  static $pb.PbList<HelloRequest> createRepeated() => $pb.PbList<HelloRequest>();
  @$core.pragma('dart2js:noInline')
  static HelloRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HelloRequest>(create);
  static HelloRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

/// The response message containing the greetings.
class HelloReply extends $pb.GeneratedMessage {
  factory HelloReply({
    $core.String? message,
    ComplexObjectResponse? response,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  HelloReply._() : super();
  factory HelloReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HelloReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HelloReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'greeter'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOM<ComplexObjectResponse>(2, _omitFieldNames ? '' : 'response', subBuilder: ComplexObjectResponse.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HelloReply clone() => HelloReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HelloReply copyWith(void Function(HelloReply) updates) => super.copyWith((message) => updates(message as HelloReply)) as HelloReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HelloReply create() => HelloReply._();
  HelloReply createEmptyInstance() => create();
  static $pb.PbList<HelloReply> createRepeated() => $pb.PbList<HelloReply>();
  @$core.pragma('dart2js:noInline')
  static HelloReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HelloReply>(create);
  static HelloReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  ComplexObjectResponse get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(ComplexObjectResponse v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => clearField(2);
  @$pb.TagNumber(2)
  ComplexObjectResponse ensureResponse() => $_ensure(1);
}

class ComplexObjectRequest extends $pb.GeneratedMessage {
  factory ComplexObjectRequest() => create();
  ComplexObjectRequest._() : super();
  factory ComplexObjectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComplexObjectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ComplexObjectRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'greeter'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComplexObjectRequest clone() => ComplexObjectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComplexObjectRequest copyWith(void Function(ComplexObjectRequest) updates) => super.copyWith((message) => updates(message as ComplexObjectRequest)) as ComplexObjectRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComplexObjectRequest create() => ComplexObjectRequest._();
  ComplexObjectRequest createEmptyInstance() => create();
  static $pb.PbList<ComplexObjectRequest> createRepeated() => $pb.PbList<ComplexObjectRequest>();
  @$core.pragma('dart2js:noInline')
  static ComplexObjectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComplexObjectRequest>(create);
  static ComplexObjectRequest? _defaultInstance;
}

enum ComplexObjectResponse_OneofValue {
  name, 
  subMessage, 
  notSet
}

class ComplexObjectResponse extends $pb.GeneratedMessage {
  factory ComplexObjectResponse({
    $core.String? stringValue,
    $core.Iterable<$core.String>? repeatedStringValue,
    $core.int? intValue,
    $core.bool? boolValue,
    $core.bool? optionalBoolValue,
    $core.double? floatValue,
    ComplexObjectResponse_Corpus? enumValue,
    $core.Iterable<Result>? repeatedMessageValue,
    $core.String? name,
    Result? subMessage,
    $core.Map<$core.String, Result>? mapValue,
  }) {
    final $result = create();
    if (stringValue != null) {
      $result.stringValue = stringValue;
    }
    if (repeatedStringValue != null) {
      $result.repeatedStringValue.addAll(repeatedStringValue);
    }
    if (intValue != null) {
      $result.intValue = intValue;
    }
    if (boolValue != null) {
      $result.boolValue = boolValue;
    }
    if (optionalBoolValue != null) {
      $result.optionalBoolValue = optionalBoolValue;
    }
    if (floatValue != null) {
      $result.floatValue = floatValue;
    }
    if (enumValue != null) {
      $result.enumValue = enumValue;
    }
    if (repeatedMessageValue != null) {
      $result.repeatedMessageValue.addAll(repeatedMessageValue);
    }
    if (name != null) {
      $result.name = name;
    }
    if (subMessage != null) {
      $result.subMessage = subMessage;
    }
    if (mapValue != null) {
      $result.mapValue.addAll(mapValue);
    }
    return $result;
  }
  ComplexObjectResponse._() : super();
  factory ComplexObjectResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComplexObjectResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ComplexObjectResponse_OneofValue> _ComplexObjectResponse_OneofValueByTag = {
    9 : ComplexObjectResponse_OneofValue.name,
    10 : ComplexObjectResponse_OneofValue.subMessage,
    0 : ComplexObjectResponse_OneofValue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ComplexObjectResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'greeter'), createEmptyInstance: create)
    ..oo(0, [9, 10])
    ..aOS(1, _omitFieldNames ? '' : 'stringValue')
    ..pPS(2, _omitFieldNames ? '' : 'repeatedStringValue')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'intValue', $pb.PbFieldType.O3)
    ..aOB(4, _omitFieldNames ? '' : 'boolValue')
    ..aOB(5, _omitFieldNames ? '' : 'optionalBoolValue')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'floatValue', $pb.PbFieldType.OF)
    ..e<ComplexObjectResponse_Corpus>(7, _omitFieldNames ? '' : 'enumValue', $pb.PbFieldType.OE, defaultOrMaker: ComplexObjectResponse_Corpus.CORPUS_UNSPECIFIED, valueOf: ComplexObjectResponse_Corpus.valueOf, enumValues: ComplexObjectResponse_Corpus.values)
    ..pc<Result>(8, _omitFieldNames ? '' : 'repeatedMessageValue', $pb.PbFieldType.PM, subBuilder: Result.create)
    ..aOS(9, _omitFieldNames ? '' : 'name')
    ..aOM<Result>(10, _omitFieldNames ? '' : 'subMessage', subBuilder: Result.create)
    ..m<$core.String, Result>(11, _omitFieldNames ? '' : 'mapValue', entryClassName: 'ComplexObjectResponse.MapValueEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Result.create, valueDefaultOrMaker: Result.getDefault, packageName: const $pb.PackageName('greeter'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComplexObjectResponse clone() => ComplexObjectResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComplexObjectResponse copyWith(void Function(ComplexObjectResponse) updates) => super.copyWith((message) => updates(message as ComplexObjectResponse)) as ComplexObjectResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComplexObjectResponse create() => ComplexObjectResponse._();
  ComplexObjectResponse createEmptyInstance() => create();
  static $pb.PbList<ComplexObjectResponse> createRepeated() => $pb.PbList<ComplexObjectResponse>();
  @$core.pragma('dart2js:noInline')
  static ComplexObjectResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComplexObjectResponse>(create);
  static ComplexObjectResponse? _defaultInstance;

  ComplexObjectResponse_OneofValue whichOneofValue() => _ComplexObjectResponse_OneofValueByTag[$_whichOneof(0)]!;
  void clearOneofValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get repeatedStringValue => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get intValue => $_getIZ(2);
  @$pb.TagNumber(3)
  set intValue($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIntValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearIntValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get boolValue => $_getBF(3);
  @$pb.TagNumber(4)
  set boolValue($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBoolValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoolValue() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get optionalBoolValue => $_getBF(4);
  @$pb.TagNumber(5)
  set optionalBoolValue($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOptionalBoolValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearOptionalBoolValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get floatValue => $_getN(5);
  @$pb.TagNumber(6)
  set floatValue($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFloatValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearFloatValue() => clearField(6);

  @$pb.TagNumber(7)
  ComplexObjectResponse_Corpus get enumValue => $_getN(6);
  @$pb.TagNumber(7)
  set enumValue(ComplexObjectResponse_Corpus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasEnumValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnumValue() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<Result> get repeatedMessageValue => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get name => $_getSZ(8);
  @$pb.TagNumber(9)
  set name($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasName() => $_has(8);
  @$pb.TagNumber(9)
  void clearName() => clearField(9);

  @$pb.TagNumber(10)
  Result get subMessage => $_getN(9);
  @$pb.TagNumber(10)
  set subMessage(Result v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSubMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearSubMessage() => clearField(10);
  @$pb.TagNumber(10)
  Result ensureSubMessage() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.Map<$core.String, Result> get mapValue => $_getMap(10);
}

class Result extends $pb.GeneratedMessage {
  factory Result({
    $core.String? url,
    $core.String? title,
    $core.Iterable<$core.String>? snippets,
  }) {
    final $result = create();
    if (url != null) {
      $result.url = url;
    }
    if (title != null) {
      $result.title = title;
    }
    if (snippets != null) {
      $result.snippets.addAll(snippets);
    }
    return $result;
  }
  Result._() : super();
  factory Result.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Result.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Result', package: const $pb.PackageName(_omitMessageNames ? '' : 'greeter'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..pPS(3, _omitFieldNames ? '' : 'snippets')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Result clone() => Result()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Result copyWith(void Function(Result) updates) => super.copyWith((message) => updates(message as Result)) as Result;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Result create() => Result._();
  Result createEmptyInstance() => create();
  static $pb.PbList<Result> createRepeated() => $pb.PbList<Result>();
  @$core.pragma('dart2js:noInline')
  static Result getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Result>(create);
  static Result? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get snippets => $_getList(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

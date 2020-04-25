///
//  Generated code. Do not modify.
//  source: expenses.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MultiExpensesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MultiExpensesRequest', package: const $pb.PackageName('expsenses'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MultiExpensesRequest._() : super();
  factory MultiExpensesRequest() => create();
  factory MultiExpensesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MultiExpensesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MultiExpensesRequest clone() => MultiExpensesRequest()..mergeFromMessage(this);
  MultiExpensesRequest copyWith(void Function(MultiExpensesRequest) updates) => super.copyWith((message) => updates(message as MultiExpensesRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MultiExpensesRequest create() => MultiExpensesRequest._();
  MultiExpensesRequest createEmptyInstance() => create();
  static $pb.PbList<MultiExpensesRequest> createRepeated() => $pb.PbList<MultiExpensesRequest>();
  @$core.pragma('dart2js:noInline')
  static MultiExpensesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MultiExpensesRequest>(create);
  static MultiExpensesRequest _defaultInstance;
}

class MultiExpenseReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MultiExpenseReply', package: const $pb.PackageName('expsenses'), createEmptyInstance: create)
    ..pc<Expense>(1, 'expenses', $pb.PbFieldType.PM, subBuilder: Expense.create)
    ..hasRequiredFields = false
  ;

  MultiExpenseReply._() : super();
  factory MultiExpenseReply() => create();
  factory MultiExpenseReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MultiExpenseReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MultiExpenseReply clone() => MultiExpenseReply()..mergeFromMessage(this);
  MultiExpenseReply copyWith(void Function(MultiExpenseReply) updates) => super.copyWith((message) => updates(message as MultiExpenseReply));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MultiExpenseReply create() => MultiExpenseReply._();
  MultiExpenseReply createEmptyInstance() => create();
  static $pb.PbList<MultiExpenseReply> createRepeated() => $pb.PbList<MultiExpenseReply>();
  @$core.pragma('dart2js:noInline')
  static MultiExpenseReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MultiExpenseReply>(create);
  static MultiExpenseReply _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Expense> get expenses => $_getList(0);
}

class ExpenseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ExpenseRequest', package: const $pb.PackageName('expsenses'), createEmptyInstance: create)
    ..aOS(2, 'expenseID', protoName: 'expenseID')
    ..hasRequiredFields = false
  ;

  ExpenseRequest._() : super();
  factory ExpenseRequest() => create();
  factory ExpenseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExpenseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ExpenseRequest clone() => ExpenseRequest()..mergeFromMessage(this);
  ExpenseRequest copyWith(void Function(ExpenseRequest) updates) => super.copyWith((message) => updates(message as ExpenseRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExpenseRequest create() => ExpenseRequest._();
  ExpenseRequest createEmptyInstance() => create();
  static $pb.PbList<ExpenseRequest> createRepeated() => $pb.PbList<ExpenseRequest>();
  @$core.pragma('dart2js:noInline')
  static ExpenseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpenseRequest>(create);
  static ExpenseRequest _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get expenseID => $_getSZ(0);
  @$pb.TagNumber(2)
  set expenseID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpenseID() => $_has(0);
  @$pb.TagNumber(2)
  void clearExpenseID() => clearField(2);
}

class Expense extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Expense', package: const $pb.PackageName('expsenses'), createEmptyInstance: create)
    ..aOS(1, 'expenseID', protoName: 'expenseID')
    ..aOS(2, 'winkelID', protoName: 'winkelID')
    ..a<$core.double>(3, 'price', $pb.PbFieldType.OF)
    ..aOS(4, 'summary')
    ..aOS(5, 'timestamp')
    ..aOS(6, 'userID', protoName: 'userID')
    ..hasRequiredFields = false
  ;

  Expense._() : super();
  factory Expense() => create();
  factory Expense.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Expense.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Expense clone() => Expense()..mergeFromMessage(this);
  Expense copyWith(void Function(Expense) updates) => super.copyWith((message) => updates(message as Expense));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Expense create() => Expense._();
  Expense createEmptyInstance() => create();
  static $pb.PbList<Expense> createRepeated() => $pb.PbList<Expense>();
  @$core.pragma('dart2js:noInline')
  static Expense getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Expense>(create);
  static Expense _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get expenseID => $_getSZ(0);
  @$pb.TagNumber(1)
  set expenseID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExpenseID() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpenseID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get winkelID => $_getSZ(1);
  @$pb.TagNumber(2)
  set winkelID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWinkelID() => $_has(1);
  @$pb.TagNumber(2)
  void clearWinkelID() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get summary => $_getSZ(3);
  @$pb.TagNumber(4)
  set summary($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSummary() => $_has(3);
  @$pb.TagNumber(4)
  void clearSummary() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get timestamp => $_getSZ(4);
  @$pb.TagNumber(5)
  set timestamp($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get userID => $_getSZ(5);
  @$pb.TagNumber(6)
  set userID($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUserID() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserID() => clearField(6);
}


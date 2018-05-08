///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library draft_change_bad;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class V2 extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('V2')
    ..a<double>(1, 'x', PbFieldType.OD)
    ..a<double>(2, 'y', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  V2() : super();
  V2.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  V2.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  V2 clone() => new V2()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static V2 create() => new V2();
  static PbList<V2> createRepeated() => new PbList<V2>();
  static V2 getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyV2();
    return _defaultInstance;
  }
  static V2 _defaultInstance;
  static void $checkItem(V2 v) {
    if (v is! V2) checkItemFailed(v, 'V2');
  }

  double get x => $_getN(0);
  set x(double v) { $_setDouble(0, v); }
  bool hasX() => $_has(0);
  void clearX() => clearField(1);

  double get y => $_getN(1);
  set y(double v) { $_setDouble(1, v); }
  bool hasY() => $_has(1);
  void clearY() => clearField(2);
}

class _ReadonlyV2 extends V2 with ReadonlyMessageMixin {}

class V2Container extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('V2Container')
    ..a<V2>(1, 'coords', PbFieldType.OM, V2.getDefault, V2.create)
    ..hasRequiredFields = false
  ;

  V2Container() : super();
  V2Container.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  V2Container.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  V2Container clone() => new V2Container()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static V2Container create() => new V2Container();
  static PbList<V2Container> createRepeated() => new PbList<V2Container>();
  static V2Container getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyV2Container();
    return _defaultInstance;
  }
  static V2Container _defaultInstance;
  static void $checkItem(V2Container v) {
    if (v is! V2Container) checkItemFailed(v, 'V2Container');
  }

  V2 get coords => $_getN(0);
  set coords(V2 v) { setField(1, v); }
  bool hasCoords() => $_has(0);
  void clearCoords() => clearField(1);
}

class _ReadonlyV2Container extends V2Container with ReadonlyMessageMixin {}

class ContainerArray extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ContainerArray')
    ..pp<V2>(1, 'v2s', PbFieldType.PM, V2.$checkItem, V2.create)
    ..pp<V2Container>(2, 'v2Containers', PbFieldType.PM, V2Container.$checkItem, V2Container.create)
    ..hasRequiredFields = false
  ;

  ContainerArray() : super();
  ContainerArray.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ContainerArray.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ContainerArray clone() => new ContainerArray()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ContainerArray create() => new ContainerArray();
  static PbList<ContainerArray> createRepeated() => new PbList<ContainerArray>();
  static ContainerArray getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyContainerArray();
    return _defaultInstance;
  }
  static ContainerArray _defaultInstance;
  static void $checkItem(ContainerArray v) {
    if (v is! ContainerArray) checkItemFailed(v, 'ContainerArray');
  }

  List<V2> get v2s => $_getList(0);

  List<V2Container> get v2Containers => $_getList(1);
}

class _ReadonlyContainerArray extends ContainerArray with ReadonlyMessageMixin {}


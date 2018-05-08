# protocrash

Repro of my proto crash issue.

## Summary

Compiling the proto below to dart, I have some crashes on Android when trying to add an element
to the `v2s` field of `ContainerArray`. However, those crashes do not happen if I remove the
field `v2_containers`.

To make it even more wild: if first I run a test case with that field removed, and just then
the failing test case, then the failing test case doesn't fail anymore.

It never fails on my laptop using the `dart` command, and it never fails on the mobile in
debug mode. It fails always the same way on mobile when compiled to an `apk` in release
mode.

```
syntax = "proto3";

package draft;

message V2 {
  double x = 1;
  double y = 2;
}

message V2Container {
  V2 coords = 1;
}  

message ContainerArray {
  repeated V2 v2s = 1;
  repeated V2Container v2_containers = 2;
}
```

## Versions used

```
~/opt/flutter-dev/bin/flutter --version           
Flutter 0.3.7-pre.12 • channel master • git@github.com:flutter/flutter.git
Framework • revision 849676fc7f (29 hours ago) • 2018-05-06 18:43:07 -0700
Engine • revision e976be13c5
Tools • Dart 2.0.0-dev.53.0.flutter-e6d7d67f4b
```

and

```
$ flutter --version
Flutter 0.3.1 • channel beta • git@github.com:flutter/flutter.git
Framework • revision 12bbaba9ae (3 weeks ago) • 2018-04-19 23:36:15 -0700
Engine • revision 09d05a3891
Tools • Dart 2.0.0-dev.48.0.flutter-fe606f890b
```

Protobuf:

```
protobuf-0.7.2
protoc_plugin-0.7.11
```

## Trace

```
05-08 07:49:05.627 15245 15261 I flutter : testBad 1
05-08 07:49:05.628 15245 15261 I flutter : testBad 2
05-08 07:49:05.628 15245 15261 I flutter : testBad 3
05-08 07:49:05.628 15245 15261 I flutter : testBad 4
05-08 07:49:05.628 15245 15261 E flutter : [ERROR:topaz/lib/tonic/logging/dart_error.cc(16)] Unhandled exception:
05-08 07:49:05.628 15245 15261 E flutter : Unsupported operation: attempted to call createRepeatedField on a read-only message (V2)
05-08 07:49:05.628 15245 15261 E flutter : #0      __ReadonlyV2&V2&ReadonlyMessageMixin._readonly (file:///Users/baldvin/.pub-cache/hosted/pub.dartlang.org/protobuf-0.7.2/lib/src/protobuf/readonly_message.dart:55)
05-08 07:49:05.628 15245 15261 E flutter : #1      __ReadonlyV2&V2&ReadonlyMessageMixin.createRepeatedField (file:///Users/baldvin/.pub-cache/hosted/pub.dartlang.org/protobuf-0.7.2/lib/src/protobuf/readonly_message.dart:21)
05-08 07:49:05.628 15245 15261 E flutter : #2      FieldInfo._createRepeatedFieldWithType (file:///Users/baldvin/.pub-cache/hosted/pub.dartlang.org/protobuf-0.7.2/lib/src/protobuf/field_info.dart:134)
05-08 07:49:05.628 15245 15261 E flutter : #3      _FieldSet._getDefaultList (file:///Users/baldvin/.pub-cache/hosted/pub.dartlang.org/protobuf-0.7.2/lib/src/protobuf/field_set.dart:137)
05-08 07:49:05.628 15245 15261 E flutter : #4      _FieldSet._$getList (file:///Users/baldvin/.pub-cache/hosted/pub.dartlang.org/protobuf-0.7.2/lib/src/protobuf/field_set.dart:275)
05-08 07:49:05.628 15245 15261 E flutter : #5      GeneratedMessage.$_getList (file:///Users/baldvin/.pub-cache/hosted/pub.dartlang.org/protobuf-0.7.2/lib/src/protobuf/generated_message.dart:293)
05-08 07:49:05.628 15245 15261 E flutter : #6      ContainerArray.get:v2s (file:///Users/baldvin/websocketcrash/lib/change_bad.dart:101)
05-08 07:49:05.628 15245 15261 E flutter : #7      testBad (file:///Users/baldvin/websocketcrash/lib/test.dart:15)
05-08 07:49:05.628 15245 15261 E flutter : #8      new MyApp. (file:///Users/baldvin/websocketcrash/lib/main.dart:12)
05-08 07:49:05.628 15245 15261 E flutter : #9      main (file:///Users/baldvin/websocketcrash/lib/main.dart:5)
05-08 07:49:05.628 15245 15261 E flutter : #10     _startIsolate.<anonymous closure> (dart:isolate/runtime/libisolate_patch.dart:279)
05-08 07:49:05.628 15245 15261 E flutter : #11     _RawReceivePortImpl._handleMessage (dart:isolate/runtime/libisolate_patch.dart:165)
```

## Files

### `change_bad.dart`

The compiled version of the above proto.

### `change_works1.dart`

Removing that single extra unused field resolves the problem, it never crashes again:

```
$ diff -u lib/change_bad.dart lib/change_works1.dart 
--- lib/change_bad.dart	2018-05-08 07:29:35.000000000 +0200
+++ lib/change_works1.dart	2018-05-08 07:29:28.000000000 +0200
@@ -2,7 +2,7 @@
 //  Generated code. Do not modify.
 ///
 // ignore_for_file: non_constant_identifier_names,library_prefixes
-library draft_change_bad;
+library draft_change_works1;
 
 // ignore: UNUSED_SHOWN_NAME
 import 'dart:core' show int, bool, double, String, List, override;
@@ -78,7 +78,7 @@
 class ContainerArray extends GeneratedMessage {
   static final BuilderInfo _i = new BuilderInfo('ContainerArray')
     ..pp<V2>(1, 'v2s', PbFieldType.PM, V2.$checkItem, V2.create)
-    ..pp<V2Container>(2, 'v2Containers', PbFieldType.PM, V2Container.$checkItem, V2Container.create)
+    //..pp<V2Container>(2, 'v2Containers', PbFieldType.PM, V2Container.$checkItem, V2Container.create)
     ..hasRequiredFields = false
   ;
```

### `change_works2.dart`

This is the real interesting one: replacing a function reference to one that simply
throws an exception solves the issue. That function is never being called. However,
replacing it to one that delegates to the original will result in the bad behavior
(the same crash as above).

So just the pure mentioning of `V2.Create` inside a function that is never getting
called results in the crash above.

```
$ diff -u lib/change_bad.dart lib/change_works2.dart 
--- lib/change_bad.dart	2018-05-08 07:29:35.000000000 +0200
+++ lib/change_works2.dart	2018-05-08 08:08:48.000000000 +0200
@@ -2,7 +2,7 @@
 //  Generated code. Do not modify.
 ///
 // ignore_for_file: non_constant_identifier_names,library_prefixes
-library draft_change_bad;
+library draft_change_works2;
 
 // ignore: UNUSED_SHOWN_NAME
 import 'dart:core' show int, bool, double, String, List, override;
@@ -45,9 +45,14 @@
 
 class _ReadonlyV2 extends V2 with ReadonlyMessageMixin {}
 
+V2 _getDefaultV2Wrapper() {
+  throw "getDefaultV2Wrapper called";
+  //return V2.getDefault();
+}
+
 class V2Container extends GeneratedMessage {
   static final BuilderInfo _i = new BuilderInfo('V2Container')
-    ..a<V2>(1, 'coords', PbFieldType.OM, V2.getDefault, V2.create)
+    ..a<V2>(1, 'coords', PbFieldType.OM, _getDefaultV2Wrapper, V2.create)
     ..hasRequiredFields = false
   ;
```

### `main.dart`

Couldn't be simpler:

```
import 'package:flutter/material.dart';

import './test.dart' as test;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    // Only use one of the cases below, leave the
    // other two commented. Uncommenting all results in everything working
    // fine, whereas just running test.testBad() results in the crash.

    // test.testWorks1();
    // test.testWorks2();
    test.testBad();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Text("foobar", textDirection: TextDirection.ltr);
  }
}
```

### `test.dart`

```
import './change_bad.dart' as badpb;
import './change_works1.dart' as works1pb;
import './change_works2.dart' as works2pb;


void testBad() {
    print("testBad 1");
    var v2 = new badpb.V2();
    print("testBad 2");
    v2.x = 2.34;
    v2.y = 6.78;
    print("testBad 3");
    var cs = new badpb.ContainerArray();
    print("testBad 4");
    cs.v2s.add(v2);
    print("testBad 5");
    print(cs.writeToJson());
    print("testBad 6");
}

void testWorks1() {
    print("testWorks1 1");
    var v2 = new works1pb.V2();
    print("testWorks1 2");
    v2.x = 2.34;
    v2.y = 6.78;
    print("testWorks1 3");
    var cs = new works1pb.ContainerArray();
    print("testWorks1 4");
    cs.v2s.add(v2);
    print("testWorks1 5");
    print(cs.writeToJson());
    print("testWorks1 6");
}

void testWorks2() {
    print("testWorks2 1");
    var v2 = new works2pb.V2();
    print("testWorks2 2");
    v2.x = 2.34;
    v2.y = 6.78;
    print("testWorks2 3");
    var cs = new works2pb.ContainerArray();
    print("testWorks2 4");
    cs.v2s.add(v2);
    print("testWorks2 5");
    print(cs.writeToJson());
    print("testWorks2 6");
}

void main() {
  testWorks1();
  testWorks2();
  testBad();
}
```
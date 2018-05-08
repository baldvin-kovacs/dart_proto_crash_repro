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

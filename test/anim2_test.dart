// Copyright (c) 2016, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library anim2.test;

import 'dart:html';

import 'package:anim2/anim2.dart';
import 'package:test/test.dart';

void main() {
  group('Animation Tests', () {
    Controller controller;

    setUp(() {
      controller = new Controller(new CanvasElement());

    });

    test('Test single animation', () {
      controller.update();
      // expect(awesome.isAwesome, isTrue);
    });
  });
}

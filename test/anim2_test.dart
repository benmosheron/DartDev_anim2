// Copyright (c) 2016, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library anim2.test;

import 'package:anim2/anim2.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Awesome awesome;

    setUp(() {
      awesome = new Awesome();
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}

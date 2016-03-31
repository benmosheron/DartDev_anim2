// Copyright (c) 2016, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library anim2.test;

import 'package:anim2/anim2.dart';
import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

import 'testAnimationObject.dart';

void main() {
  group('Basic Tests', () {
    setUp(() {});

    test('Create controller (manual)', () {
      new Controller.Manual(null);
    });

    test('Create animation object', () {
      new TestAnimationObject();
    });

    test('Register animation object', () {
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
    });

    test('Queue animation', () {
      int framesToRun = 10;
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
      controller.queueAnimation(controller.moveTo(o.id, new V2.both(10), framesToRun));
    });
  });

  group('Animation Tests', () {
    test('Test moveTo', () {
      V2 expectedPosition = new V2.both(10);
      int framesToRun = 10;
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
      controller.queueAnimation(controller.moveTo(o.id, new V2.both(10), framesToRun));
      runFrames(controller, framesToRun);
      expect(getTestObject(controller, 0).position == expectedPosition, isTrue);
    });

    test('Test changeColourTo', () {
      int framesToRun = 10;
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
      controller.queueAnimation(controller.changeColourTo(o.id, new Colour(10,10,10,1.0), framesToRun));
      runFrames(controller, framesToRun);
      Colour endColour = (getTestObject(controller, 0) as ColourObject).colour;
      print(endColour);
      expect(endColour.r == 10, isTrue);
      expect(endColour.g == 10, isTrue);
      expect(endColour.b == 10, isTrue);
      //TODO: alpha is 0.99999999999...
    });
  });
}

void runFrames(Controller c, int framesToRun, {bool render: false}){
  for(int i=0; i<framesToRun;i++){
    c.update();
    if(render) c.render();
  }
}

String getTestObjectId(Controller c, int i){
  return c.objects[c.objects.keys.elementAt(i)].id;
}

AnimObject getTestObject(Controller c, int i){
  return c.objects[c.objects.keys.elementAt(i)];
}

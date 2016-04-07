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
      controller.queueAnimation(
          controller.moveTo(o.id, new V2.both(10.0), framesToRun));
    });
  });

  group('Animation Tests', () {
    test('Test moveTo', () {
      V2 expectedPosition = new V2.both(10.0);
      int framesToRun = 10;
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
      controller.queueAnimation(
          controller.moveTo(o.id, new V2.both(10.0), framesToRun));
      runFrames(controller, framesToRun);
      expect(getTestObject(controller, 0).position == expectedPosition, isTrue);
    });

    test('Test changeColourTo', () {
      int framesToRun = 10;
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
      controller.queueAnimation(controller.changeColourTo(
          o.id, new Colour(10, 10, 10, 1.0), framesToRun));
      runFrames(controller, framesToRun);
      Colour endColour = (getTestObject(controller, 0) as ColourObject).colour;
      expect(endColour.r == 10, isTrue);
      expect(endColour.g == 10, isTrue);
      expect(endColour.b == 10, isTrue);
      //TODO: alpha is 0.99999999999...
    });

    test('Test created but not run', () {
      int framesToRun = 10;
      V2 expectedPosition = new V2.both(0.0);
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);
      // Create animations using the controller, but do not queue or compound them
      controller.changeColourTo(o.id, new Colour(10, 10, 10, 1.0), framesToRun);
      controller.moveTo(o.id, new V2.both(10.0), framesToRun);

      // run frames (should not do anything)
      runFrames(controller, framesToRun);
      Colour endColour = (getTestObject(controller, 0) as ColourObject).colour;
      expect(endColour.r == 0, isTrue);
      expect(endColour.g == 0, isTrue);
      expect(endColour.b == 0, isTrue);
      expect(getTestObject(controller, 0).position == expectedPosition, isTrue);
    });
  });

  group('AnimationGroup Tests', () {
    test('Test basic', () {
      int framesToRun = 10;
      V2 expectedPosition = new V2.both(10.0);
      Colour expectedColour = new Colour(100, 100, 100, 1.0);
      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);

      // Create an animation group
      AnimationGroup g = new AnimationGroup();
      AnimationBase a1 = controller.moveTo(o.id, new V2.both(10.0), framesToRun);
      AnimationBase a2 = controller.changeColourTo(
          o.id, new Colour(100, 100, 100, 1.0), framesToRun);
      // Add animations
      g.add(a1);
      g.add(a2);
      // Queue the animations
      controller.queueAnimation(g);

      runFrames(controller, framesToRun);

      Colour endColour = (getTestObject(controller, 0) as ColourObject).colour;
      expect(endColour.r == expectedColour.r, isTrue);
      expect(endColour.g == expectedColour.g, isTrue);
      expect(endColour.b == expectedColour.b, isTrue);
      //TODO: alpha is 0.99999999999...
      expect(getTestObject(controller, 0).position == expectedPosition, isTrue);
    });

    test('Test two queued groups', () {
      int framesToRun = 10;

      // First change to this
      V2 intermediatePosition = new V2.both(10.0);
      Colour intermediateColour = new Colour(10, 10, 10, 1.0);

      // Then this
      V2 expectedPosition = new V2.both(100.0);
      Colour expectedColour = new Colour(100, 100, 100, 1.0);

      Controller controller = new Controller.Manual(null);
      var o = new TestAnimationObject();
      controller.registerObject(o);

      // Create an animation group
      AnimationGroup g1 = new AnimationGroup();
      AnimationGroup g2 = new AnimationGroup();
      AnimationBase a1 =
          controller.moveTo(o.id, intermediatePosition, framesToRun);
      AnimationBase a2 =
          controller.changeColourTo(o.id, intermediateColour, framesToRun);
      AnimationBase a3 = controller.moveTo(o.id, expectedPosition, framesToRun);
      AnimationBase a4 =
          controller.changeColourTo(o.id, expectedColour, framesToRun);
      // Add animations
      g1.add(a1);
      g1.add(a2);
      g2.add(a3);
      g2.add(a4);
      // Queue the animations
      controller.queueAnimation(g1);
      controller.queueAnimation(g2);

      runFrames(controller, framesToRun * 2);

      Colour endColour = (getTestObject(controller, 0) as ColourObject).colour;
      expect(endColour.r == expectedColour.r, isTrue);
      expect(endColour.g == expectedColour.g, isTrue);
      expect(endColour.b == expectedColour.b, isTrue);
      //TODO: alpha is 0.99999999999...
      expect(getTestObject(controller, 0).position == expectedPosition, isTrue);
    });
  });
}

void runFrames(Controller c, int framesToRun,
    {bool render: false, bool debug: false}) {
  for (int i = 0; i < framesToRun; i++) {
    if (debug) c.animations
        .forEach((a) => print("queued: ${a.queued},  ${a.description}"));
    c.update();
    if (render) c.render();
  }
}

String getTestObjectId(Controller c, int i) {
  return c.objects[c.objects.keys.elementAt(i)].id;
}

AnimObject getTestObject(Controller c, int i) {
  return c.objects[c.objects.keys.elementAt(i)];
}

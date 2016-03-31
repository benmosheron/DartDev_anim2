# anim2

A basic 2D html5 animation library. Very basic.

## Usage

A simple usage example (see example\anim2_example.dart):
    import 'dart:html';
    import 'dart:math';

    import 'package:anim2/anim2.dart';
    import 'package:generic_vector_tools/generic_vector_tools.dart';

    // Create the animation controller, pass it a reference to the CanvasElement you are animating on
    // and the framerate of animation
    Controller controller = new Controller(querySelector('#canvas1') as CanvasElement, new Duration(milliseconds: 16));

    main() {
      // The example will move a circle to the clicked location, and change it to a random colour
      controller.canvas.onClick.listen(mainOnClick);

      //  create and register the object -  a circle at position (10,10)
      controller.registerObject(new Circle("testCircle", new V2(10.0,10.0)));

      // Create and immediately compound an animation to change the colour to a random colour,
      // and move to the clicked location
      controller.compoundAnimation(controller.changeColourTo("testCircle", new Colour.random(), 30));
      controller.compoundAnimation(controller.moveTo("testCircle", clickPosition, 30));
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/benmosheron/DartDev_anim2/issues

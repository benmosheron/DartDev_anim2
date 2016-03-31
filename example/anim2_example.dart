// Copyright (c) 2016, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library anim2.example;

import 'dart:math';

import 'package:anim2/anim2.dart';
import 'package:generic_vector_tools/generic_vector_tools.dart';

// Create the animation controller, pass it a reference to the CanvasElement you are animating on
// and the framerate of animation
Controller controller = new Controller(querySelector('#canvas1') as CanvasElement, new Duration(milliseconds: 16));

// The main method of your web app
void main() {
  // The example will move a circle to the clicked location, and change it to a random colour
  controller.canvas.onClick.listen(mainOnClick);

  //  create and register the object -  a circle at position (10,10)
  controller.registerObject(new Circle("testCircle", new V2(10.0,10.0)));
}

void mainOnClick(var e){
  var clickPosition = new V2.int(e.offsetX, e.offsetY);

  // On click, create and immediately compound an animation to change the colour to a random colour,
  // and move to the clicked location
  controller.compoundAnimation(controller.changeColourTo("testCircle", new Colour.random(), 30));
  controller.compoundAnimation(controller.moveTo("testCircle", clickPosition, 30));
}

// Example implementation of AnimObject (for movement animation) 
// and ColourObject (for colour animations)
class Circle implements AnimObject, ColourObject{
  V2 position;
  String id;
  Colour colour = new Colour.random();
  Circle(this.id, this.position);

  void render(var ctx){
    ctx.fillStyle = colour.toString();
    ctx.beginPath();
    ctx.arc(position.x, position.y, 10, 0, 2 * PI);
    ctx.fill();
  }
}

//-----------//
// dart:html //
//-----------//

// dart:html facades - to avoid including a dependency on dart:html, as it breaks unit tests
// including these to prevent static analyzer warnings

/// Mock of dart:html.Element
class Element{
  // use dart:html!
}

/// Mock of dart:html.CanvasElement
class CanvasElement extends Element{
  // use dart:html!
}

/// Mock of dart:html.querySelector
Element querySelector(String s){
  // use dart:html!
  return new CanvasElement();
}
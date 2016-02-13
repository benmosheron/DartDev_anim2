library anim2.controller;

import 'dart:html';

import 'anim_object.dart';

/// Controls the animation of animation objects on an HTML5 canvas
class Controller{

  /// The controlled canvas
  final CanvasElement canvas;
  CanvasRenderingContext2D ctx;

  final List<AnimObject> objects = new List<AnimObject>();

  final List<Animation> animations = new List<Animation>();

  // Constructors
  Controller(this.canvas){
    ctx = canvas.getContext('2d');
  }

  // Methods
  render(){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    objects.forEach((a) => a.render(ctx));
  }
}

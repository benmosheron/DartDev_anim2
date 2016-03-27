library anim2.controller;

import 'dart:html';

import 'anim_object.dart';
import 'anim.dart';

/// Controls the animation of animation objects on an HTML5 canvas
class Controller{

  /// The controlled canvas
  final CanvasElement canvas;
  CanvasRenderingContext2D ctx;

  final List<AnimObject> objects = new List<AnimObject>();

  final List<Anim> animations = new List<Anim>();

  List<Anim> get activeAnimations => animations.where((anim) => anim.active);

  // Constructors
  Controller(this.canvas){
    ctx = canvas.getContext('2d');
  }

  // Methods
  update(){
    _queue();
    activeAnimations.forEach((anim) => anim.run());
    animations.removeWhere((anim) => anim.finished);
  }

  render(){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    objects.forEach((a) => a.render(ctx));
  }

  _queue(){
    if(animations.isEmpty)
      return;
    // If a queued animation is the top in the list for a target, make it runnable
    //TODO: implement
    if(animations[0].queued == true)
    {
      animations[0].deQueue();
    }
  }

  queueAnimation(Anim animation){
    animation.queued = true;
    animations.add(animation);
  }
}

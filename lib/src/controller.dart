library anim2.controller;

import 'dart:html';

import 'anim_object.dart';
import 'anim.dart';

/// Controls the animation of animation objects on an HTML5 canvas
class Controller{

  /// The controlled canvas
  final CanvasElement canvas;
  CanvasRenderingContext2D ctx;

  /// Objects controlled by the controller
  final List<AnimObject> objects = new List<AnimObject>();

  /// Animations controlled by the controller
  final List<Anim> animations = new List<Anim>();

  /// Animations currently running
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

  /// Render all objects
  render(){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    objects.forEach((a) => a.render(ctx));
  }

  // Update the queue
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

  /// Queue an animation to take place
  queueAnimation(Anim animation){
    animation.queued = true;
    animations.add(animation);
  }

  /// Start an animation immediately, compounded with any existing animations of the target object
  compoundAnimation(Anim animation){
    animations.add(animation);
  }
}

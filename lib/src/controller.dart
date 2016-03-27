library anim2.controller;

import 'dart:async';
import 'dart:collection';
import 'dart:html';

import 'anim_object.dart';
import 'anim.dart';

/// Controls the animation of animation objects on an HTML5 canvas
class Controller{

  /// The controlled canvas
  final CanvasElement canvas;

  /// Rendering context of the canvas
  CanvasRenderingContext2D ctx;

  /// Framerate with which to update and render the canvas
  Duration fps;

  /// Objects controlled by the controller
  final LinkedHashMap<String, AnimObject> objects = new LinkedHashMap<String, AnimObject>();

  /// Animations controlled by the controller
  final List<Anim> animations = new List<Anim>();

  /// Animations currently running
  List<Anim> get activeAnimations => animations.where((anim) => anim.active);

  // Constructors
  Controller(this.canvas, this.fps){
    ctx = canvas.getContext('2d');
    new Timer.periodic(fps, (t) => onTick());
  }

  // Methods

  /// Run every frame
  void onTick(){
    update();
    render();
  }

  /// Proceed with the next step of every active animation
  update(){
    _queue();
    activeAnimations.forEach((anim) => anim.run());
    animations.removeWhere((anim) => anim.finished);
  }

  /// Render all objects
  render(){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    objects.forEach((k, a) => a.render(ctx));
  }

  /// Register an animation object with the controller
  registerObject(AnimObject o){
    objects[o.id] = o;
  }

  /// Queue an animation to take place
  queueAnimation(Anim animation){
    animation.queued = true;
    animations.add(animation);
  }

  /// Update the queue
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

  /// Start an animation immediately, compounded with any existing animations of the target object
  compoundAnimation(Anim animation){
    animations.add(animation);
  }
}

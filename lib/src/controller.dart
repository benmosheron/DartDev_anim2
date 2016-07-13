library anim2.controller;

import 'dart:async';
import 'dart:collection';

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'anim_object.dart';
import 'animation_base.dart';
import 'anim_change_scale.dart';
import 'anim_move_at.dart';
import 'anim_move_to.dart';
import 'anim_change_colour.dart';
import 'colour.dart';

/// Controls the animation of animation objects on an HTML5 canvas
class Controller {
  /// The controlled canvas
  final canvas;

  /// Objects controlled by the controller
  final LinkedHashMap<String, AnimObject> objects =
      new LinkedHashMap<String, AnimObject>();

  /// Animations controlled by the controller
  final List<AnimationBase> animations = new List<AnimationBase>();

  /// Rendering context of the canvas <CanvasRenderingContext2D>
  var ctx;

  /// Framerate with which to update and render the canvas
  Duration fps;

  //------------//
  // Properties //
  //------------//

  /// Animations currently running
  List<AnimationBase> get activeAnimations =>
      animations.where((anim) => anim.active).toList();

  //--------------//
  // Constructors //
  //--------------//

  /// Create the controller, set the fps, and start running.
  Controller(this.canvas, this.fps) {
    ctx = canvas.getContext('2d');
    new Timer.periodic(fps, (t) => onTick());
  }

  /// Create the controller, without starting a timer.
  Controller.Manual(this.canvas) {
    ctx = null;
  }

  //---------//
  // Methods //
  //---------//

  /// Run every frame
  void onTick() {
    update();
    render();
  }

  /// Proceed with the next step of every active animation, remove finished animations
  update() {
    _queue();
    activeAnimations.forEach((anim) => anim.run());
    animations.removeWhere((anim) => anim.finished);
  }

  /// Render all objects
  render() {
    if (ctx != null) ctx.clearRect(0, 0, canvas.width, canvas.height);
    objects.forEach((k, a) => a.render(ctx));
  }

  /// Register an animation object with the controller
  registerObject(AnimObject o) {
    objects[o.id] = o;
  }

  /// Create an animation that will, when run, move an object to the specified
  /// position, in the specified number of frames
  AnimMoveTo moveTo(String id, V2 position, int frames) {
    AnimObject o = objects[id];
    if (o == null) return null;
    return new AnimMoveTo(o, position, frames);
  }

  /// Create an animation that will, when run, move an object at velocity
  /// velocityFunction(currentFrame) for the specified number of frames.
  AnimMoveAt moveAt(String id, int frames, Function velocityFunction){
    AnimObject o = objects[id];
    if (o == null) return null;
    return new AnimMoveAt(o, frames, velocityFunction);
  }

  /// Create an animation that will, when run, change the scale of an object to
  /// the specified position, in the specified number of frames
  AnimChangeScale changeScale(String id, double endScale, int frames){
    AnimObject o = objects[id];
    if (o == null) return null;
    return new AnimChangeScale(o, endScale, frames);
  }

  /// Create an animation that will, when run, change the scale of an object to
  /// the specified position, with a custom function specifying
  /// the rate of change of scale with respect to the current animation frame
  AnimChangeScale changeScaleCustomFunction(
      String id,
      int frames,
      Function scaleFunction){
    AnimObject o = objects[id];
    if (o == null) return null;
    return new AnimChangeScale.CustomFunction(o, frames, scaleFunction);
  }

  /// Create an animation that will, when run, change an object's colour to the input colour, in the specified number of frames
  AnimChangeColour changeColourTo(String id, Colour c, int frames) {
    AnimObject o = objects[id];
    if (o == null) return null;
    return new AnimChangeColour(o, c, frames);
  }

  //-------------------//
  // Queued Animations //
  //-------------------//

  /// Queue an animation to take place
  queueAnimation(AnimationBase animation) {
    if (animation == null) return;
    animation.queued = true;
    animations.add(animation);
  }

  /// Update the queue
  _queue() {
    if (animations.isEmpty) return;

    // If a queued animation is the top in the list for a target, make it runnable
    HashSet<String> needsQueue = new HashSet<String>();

    for (int i = 0; i < animations.length; i++) {
      AnimationBase a = animations[i];
      if (!needsQueue.contains(a.target.id)) {
        if (a.queued == true) a.deQueue();

        needsQueue.add(a.target.id);
      }
    }
  }

  //---------------------//
  // Compound Animations //
  //---------------------//

  /// Start an animation immediately, compounded with any existing animations of the target object
  compoundAnimation(AnimationBase animation) {
    if (animation == null) return;
    animation.queued = false;
    animations.add(animation);
  }

  //-------//
  // Debug //
  //-------//
  debug(String s) {
    print(s);
  }

  debugRunningAnimations() {
    activeAnimations.forEach((anim) => print("    ${anim.description}"));
  }
}

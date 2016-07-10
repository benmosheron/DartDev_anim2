library anim2.anim_move_at;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'animation_base.dart';
import 'anim_object.dart';

/// Represents an animation of an AnimObject moving, where the movement is
/// described by an input function
class AnimMoveAt implements AnimationBase {
  // Note: shortened name prevents clash with html Animation class.
  AnimObject target;
  int frameDuration;

  // Start position is set when the animation starts
  V2 startPosition;

  // End position is not known until animation is finished
  V2 endPosition;

  int currentFrame = 0;

  /// Is animation queued
  bool queued;

  /// True if animation is finished
  bool get finished => currentFrame == frameDuration;

  /// True if animation is currently running
  bool get active => !(finished || queued);

  String get description =>
      "Moving ${target.id} ($currentFrame / $frameDuration)";

  /// Function describing the velocity of the object at every frame
  Function velocityFunction;

  /// Create an animation that will move the object at a velocity described by
  /// velocityFunction. velocityFunction should return a V2 and take a single
  /// parameter (Int) for frame.
  AnimMoveAt(AnimObject target, int frames, Function velocityFunction) {
    if (frames <= 0) frames = 1;

    this.target = target;
    this.frameDuration = frames;
    this.velocityFunction = velocityFunction;
  }

  deQueue() {
    queued = false;
    resetFromCurrent();
  }

  /// Reset the movement vector based on the target's position as it leaves the queue
  resetFromCurrent() {
    startPosition = target.position;
  }

  void run() {
    if (finished) return;

    target.position += velocityFunction(currentFrame);

    currentFrame++;

    if (finished) endPosition = target.position;
  }
}

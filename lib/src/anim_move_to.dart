library anim2.anim_move_to;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'animation_base.dart';
import 'anim_object.dart';

/// Represents an animation of an AnimObject moving to a new location.
class AnimMoveTo implements AnimationBase {
  // Note: shortened name prevents clash with html Animation class.
  AnimObject target;
  int frameDuration;

  V2 startPosition;
  V2 endPosition;
  V2 _d;

  int currentFrame = 0;

  /// Is animation queued
  bool queued;

  /// True if animation is finished
  bool get finished => currentFrame == frameDuration;

  /// True if animation is currently running
  bool get active => !(finished || queued);

  String get description =>
      "Moving ${target.id} ($currentFrame / $frameDuration)";

  AnimMoveTo(AnimObject target, V2 p, int frames) {
    if (frames <= 0) frames = 1;

    this.target = target;
    startPosition = target.position;
    endPosition = p;
    frameDuration = frames;

    _d = (endPosition - startPosition) / frameDuration;
  }

  deQueue() {
    queued = false;
    resetFromCurrent();
  }

  /// Reset the movement vector based on the target's position as it leaves the queue
  resetFromCurrent() {
    startPosition = target.position;
    _d = (endPosition - startPosition) / frameDuration;
  }

  void run() {
    if (finished) return;

    target.position += _d;

    currentFrame++;
  }
}

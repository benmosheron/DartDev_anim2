library anim2.animation_base;

import 'anim_object.dart';

/// Represents an animation of an AnimObject.
abstract class AnimationBase {
  /// The AnimObject that this animation is targeting.
  AnimObject target;

  /// The number of frames that this animation lasts.
  int frameDuration;

  /// The current frame that the animation is at.
  int currentFrame;

  /// Is animation queued.
  bool queued;

  /// True if animation is finished.
  bool get finished;

  /// True if animation is currently running.
  bool get active;

  /// Get a description of the animation (for debugging)
  String get description;

  /// Remove the animation from it's queue, so it can run.
  void deQueue();

  /// Run a single frame of the animation.
  void run();
}

library anim2.animation_group;

import 'dart:math';

import 'animation_base.dart';
import 'anim_object.dart';

/// A group of animations that occupy the same position in the controller's queue for an object
class AnimationGroup implements AnimationBase {
  /// Animations belonging to this group
  List<AnimationBase> animations = new List<AnimationBase>();

  /// Create an AnimationGroup, it will be queued by default
  /// The controller does not know the details of animations in a group,
  /// it only calls the group's update() method.
  AnimationGroup() {
    queued = true;
    currentFrame = 0;
  }

  void add(AnimationBase a) {
    if (active) throw new Exception("Can't add animations to an active group");
    if (finished) throw new Exception(
        "Can't add animations to a finished group");
    if (target != null && target.id != a.target.id) throw new Exception(
        "Animations in a group must target the same object");

    // queue the animation
    a.queued = true;

    animations.add(a);
    if (target == null) target = a.target;
    if (frameDuration == null) frameDuration = a.frameDuration;
    frameDuration = max(frameDuration, a.frameDuration);
  }

  //---------------//
  // AnimationBase //
  //---------------//

  /// The AnimObject that this animation is targeting.
  AnimObject target;

  /// The number of frames that this animation lasts.
  int frameDuration;

  /// The current frame that the animation is at.
  int currentFrame;

  /// Is animation queued.
  bool queued;

  /// True if animation is finished
  bool get finished => currentFrame == frameDuration;

  /// True if animation is currently running
  bool get active => !(finished || queued);

  /// Get a description of the animation (for debugging)
  String get description =>
      "Group of ${animations.length} animations for ${target.id} ($currentFrame / $frameDuration)";

  /// Remove the animation from it's queue, so it can run.
  void deQueue() {
    animations.forEach((a) => a.deQueue());
    queued = false;
  }

  /// Run a single frame of the animation.
  void run() {
    animations.forEach((a) => a.run());
    currentFrame++;
  }
}

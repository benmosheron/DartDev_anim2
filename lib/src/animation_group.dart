library anim2.animation_group;

import 'animation_base.dart';
import 'anim_object.dart';

/// A group of animations that occupy the same position in an object's queue
class AnimationGroup implements AnimationBase{
    List<AnimationBase> animations;

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
  String get description => "Group of ${animations.length} animations for ${target.id} ($currentFrame / $frameDuration)";

  /// Remove the animation from it's queue, so it can run.
  void deQueue(){}

  /// Run a single frame of the animation.
  void run(){}
}
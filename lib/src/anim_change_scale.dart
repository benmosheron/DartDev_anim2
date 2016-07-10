library anim2.anim_change_scale;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'animation_base.dart';
import 'scale_object.dart';

/// Represents an animation of an AnimObject moving to a new location.
class AnimChangeScale implements AnimationBase {
  // Note: shortened name prevents clash with html Animation class.
  ScaleObject target;
  int frameDuration;

  double startScale;

  // If an end scale is provided, the scale function will be calculated
  // automatically, and re-calculated when the animation is dequeued.
  double endScale;
  bool endScaleProvided = false;

  int currentFrame = 0;

  /// Is animation queued
  bool queued;

  /// True if animation is finished
  bool get finished => currentFrame == frameDuration;

  /// True if animation is currently running
  bool get active => !(finished || queued);

  String get description =>
      "Change scale of ${target.id} ($currentFrame / $frameDuration)";

  /// Function describing how the scale changes with each frame
  Function scaleFunction = null;

  AnimChangeScale(ScaleObject target, double targetScale, int frames) {
    if (frames <= 0) frames = 1;

    this.target = target;
    startScale = target.scale;
    endScale = targetScale;
    frameDuration = frames;
    endScaleProvided = true;

    // linear scale function is independent of frame
    scaleFunction =
        (frame) => (endScale - startScale) / frameDuration.toDouble();
  }

  AnimChangeScale.CustomFunction(
      ScaleObject target, int frames, Function scaleFunction) {
    if (frames <= 0) frames = 1;

    this.target = target;
    startScale = target.scale;
    frameDuration = frames;

    this.scaleFunction = scaleFunction;
  }

  deQueue() {
    queued = false;
    resetFromCurrent();
  }

  /// Reset the scale and delta based on the target's scale as it leaves the queue
  resetFromCurrent() {
    // update the scale function with current values if we have a target end scale
    if (endScaleProvided) {
      startScale = target.scale;
      scaleFunction =
          (frame) => (endScale - startScale) / frameDuration.toDouble();
    }
  }

  void run() {
    if (finished) return;

    target.scale += scaleFunction(currentFrame);

    currentFrame++;
  }
}

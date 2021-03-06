library anim2.anim_change_colour;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'animation_base.dart';
import 'colour.dart';
import 'colour_object.dart';

/// Represents an animation of an AnimObject changing colour.
class AnimChangeColour implements AnimationBase {
  // Note: shortened name prevents clash with html Animation class.
  ColourObject target;
  int frameDuration;

  Colour startColour;
  Colour endColour;
  Colour _dColour;

  /// Current animation frame
  int currentFrame = 0;

  /// Is animation queued
  bool queued;

  /// True if animation is finished
  bool get finished => currentFrame == frameDuration;

  /// True if animation is currently running
  bool get active => !(finished || queued);

  String get description =>
      "Changing colour of ${target.id} from ${startColour.toString()} to ${endColour.toString()} ($currentFrame / $frameDuration)";

  AnimChangeColour(ColourObject target, Colour c, int frames) {
    if (frames <= 0) frames = 1;

    this.target = target;
    startColour = target.colour;
    endColour = c;
    frameDuration = frames;
    V<double> srgb = new V<double>(startColour.array());
    V<double> ergb = new V<double>(endColour.array());
    _dColour = new Colour.fromArray(
        ((ergb - srgb) / frameDuration.toDouble()).elements);
  }

  deQueue() {
    queued = false;
    resetFromCurrent();
  }

  /// Reset the movement vector based on the target's position as it leaves the queue.
  resetFromCurrent() {
    startColour = target.colour;
    V<double> srgb = new V<double>(startColour.array());
    V<double> ergb = new V<double>(endColour.array());
    _dColour = new Colour.fromArray(
        ((ergb - srgb) / frameDuration.toDouble()).elements);
  }

  void run() {
    if (finished) return;

    target.colour = target.colour + _dColour.array();

    currentFrame++;
  }
}

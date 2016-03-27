library anim2.anim;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'anim_object.dart';

/// Represents an in progress animation of an AnimObject.
class Anim{
  // Note: shortened name prevents clash with html Animation class.
  AnimObject target;
  V2 startPosition;
  V2 endPosition;
  int frameDuration;

  V2 _d;
  int currentFrame = 0;

  /// True if animation is finished
  bool get finished => currentFrame == frameDuration;

  /// True if animation is currently running
  bool get active => !(finished || queued);

  /// Is animation queued (due to run)
  bool queued;

  Anim.moveTo(AnimObject target, V2 p, int frames){
    this.target = target;
    startPosition = target.position;
    endPosition = p;
    frameDuration = frames;

    _d = (endPosition - startPosition) / frameDuration;
  }

  deQueue(){
    queued = false;
    resetFromCurrent();
  }

  resetFromCurrent(){
    startPosition = target.position;
    _d = (endPosition - startPosition) / frameDuration;
  }

  void run(){
    if(finished)
      return;


    target.position += _d;

    currentFrame++;
  }
}
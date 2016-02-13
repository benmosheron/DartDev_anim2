library anim2.anim_object;


import 'dart:html';
import 'package:generic_vector_tools/generic_vector_tools.dart';

/// Animatable object
abstract class AnimObject{
  V2 position;

  void render(CanvasRenderingContext2D ctx);

}
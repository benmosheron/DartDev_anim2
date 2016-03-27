library anim2.anim_object;

import 'dart:html';
import 'package:generic_vector_tools/generic_vector_tools.dart';

/// Animatable object
abstract class AnimObject{
  /// Unique ID of the object
  String id;

  /// 2D position of the object (x, y)
  V2 position;

  /// Render the object to canvas
  void render(CanvasRenderingContext2D ctx);
}
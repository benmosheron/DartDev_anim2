library anim2.scale_object;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'anim_object.dart';

/// Represents an object whose scale can be changed by animation.
abstract class ScaleObject implements AnimObject{
  /// Unique ID of the object
  String id;

  /// 2D position of the object (x, y)
  V2 position;

  /// Scale of the object, scaled about the focus.
  double scale;

  /// Centre about which the object is scaled.
  V2 focus;

  /// Render the object to canvas
  void render(var ctx);
}
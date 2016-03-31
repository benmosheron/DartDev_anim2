library anim2.colour_object;

import 'package:generic_vector_tools/generic_vector_tools.dart';

import 'anim_object.dart';
import 'colour.dart';

/// Animatable object, with a modifiable colour
abstract class ColourObject implements AnimObject {
  /// Unique ID of the object
  String id;

  /// 2D position of the object (x, y)
  V2 position;

  /// Render the object to canvas
  void render(var ctx);

  /// RGBA Colour of the object
  Colour colour;
}

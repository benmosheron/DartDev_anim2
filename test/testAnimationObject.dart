import 'package:anim2/anim2.dart';
import 'package:generic_vector_tools/generic_vector_tools.dart';

class TestAnimationObject implements ColourObject, ScaleObject {
  String id;
  V2 position;
  Colour colour;
  V2 focus;
  double scale;

  static int testIdGen = -1;

  void render(ctx) {
    print("\"rendering\" object:");
    print("  id: $id");
    print("  position: (${position.x}, ${position.y})");
    print("  colour: ${colour}");
    print("");
  }

  TestAnimationObject() {
    id = (++testIdGen).toString();
    position = new V2.zero();
    colour = new Colour(0, 0, 0, 0);
    focus = position - new V2.one();
    scale = 1.0;
  }
}

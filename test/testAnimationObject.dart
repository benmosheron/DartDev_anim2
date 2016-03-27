import 'dart:html';

import 'package:anim2/anim2.dart';
import 'package:generic_vector_tools/generic_vector_tools.dart';

class TestAnimationObject implements AnimObject{
  String id;
  V2 position;

  static int testIdGen = -1;

  void render(CanvasRenderingContext2D ctx){
    // Test class, do nothing
  }

  TestAnimationObject(){
    id = (++testIdGen).toString();
    position = new V2.zero();
  }
}
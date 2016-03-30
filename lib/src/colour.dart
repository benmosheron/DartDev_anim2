library anim2.colour;

import 'dart:math' as math;

class Colour{
  static const double alpha = 1.0;
  int r;
  int g;
  int b;

  static final math.Random rand = new math.Random();

  Colour.random(){
    r = rand.nextInt(256);
    g = rand.nextInt(256);
    b = rand.nextInt(256);
  }

  Colour(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }

  String toString(){
    return("rgba($r, $g, $b, $alpha)");
  }
}
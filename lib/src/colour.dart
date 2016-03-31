library anim2.colour;

import 'dart:math' as math;

class Colour {
  int get r => math.max(math.min(_rD.round(), 255), 0);
  int get g => math.max(math.min(_gD.round(), 255), 0);
  int get b => math.max(math.min(_bD.round(), 255), 0);
  double a;
  double _rD;
  double _gD;
  double _bD;

  static final math.Random rand = new math.Random();

  Colour.random() {
    _rD = rand.nextDouble() * 255.0;
    _gD = rand.nextDouble() * 255.0;
    _bD = rand.nextDouble() * 255.0;
    a = 1.0;
  }

  Colour(num r, num g, num b, num a) {
    _validateInput(r, g, b, a);
    _rD = r.toDouble();
    _gD = g.toDouble();
    _bD = b.toDouble();
    this.a = a.toDouble();
  }

  Colour.fromArray(List<double> l) {
    _validateInput(l[0], l[1], l[2], l[3]);
    _rD = l[0].toDouble();
    _gD = l[1].toDouble();
    _bD = l[2].toDouble();
    this.a = l[3].toDouble();
  }

  _validateInput(r, g, b, a) {
    if (r == null) throw new Exception("Argument \"r\" null");
    if (g == null) throw new Exception("Argument \"g\" null");
    if (b == null) throw new Exception("Argument \"b\" null");
    if (a == null) throw new Exception("Argument \"a\" null");
  }

  String toString() {
    return ("rgba($r, $g, $b, $a)");
  }

  List<double> array() {
    return [_rD, _gD, _bD, a];
  }

  operator +(var x) {
    if (x is Colour) return _plusColour(x as Colour);
    else if (x is List<double>) return _plusList(x as List<double>);
  }

  Colour _plusColour(Colour c) {
    return new Colour(_rD + c._rD, _gD + c._gD, _bD + c._bD, a + c.a);
  }

  Colour _plusList(List<double> a) {
    return new Colour(_rD + a[0], _gD + a[1], _bD + a[2], this.a + a[3]);
  }
}

import 'package:flutter/cupertino.dart';

extension Sizedbox on num {
  SizedBox get Vspace => SizedBox(height: toDouble());

  SizedBox get Hspace => SizedBox(width: toDouble());
}

import 'dart:ui';

class CustomBoxModel{
  bool visited;
  bool tapped;
  Color clr;
  int row;
  int column;
  int depth;

  CustomBoxModel({
   required this.visited,
   required this.tapped,
    required this.clr,
    required this.row,
    required this.column,
    required this.depth,
});
}


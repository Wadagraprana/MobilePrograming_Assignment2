import 'package:objectbox/objectbox.dart';

@Entity()
class Quote {
  int id; // ID harus int dan default = 0 untuk ObjectBox
  String? text;
  String? author;

  Quote({this.id = 0, this.text, this.author});
}
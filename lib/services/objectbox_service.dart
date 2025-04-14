import 'package:objectbox/objectbox.dart';
import '../models/quote.dart';
import '../objectbox.g.dart';

class ObjectBoxService {
  late final Store _store;
  late final Box<Quote> _quoteBox;

  ObjectBoxService._create(this._store) {
    _quoteBox = Box<Quote>(_store);
  }

  static Future<ObjectBoxService> create() async {
    final store = await openStore();
    return ObjectBoxService._create(store);
  }

  List<Quote> getAllQuotes() => _quoteBox.getAll();

  void addQuote(Quote quote) {
    _quoteBox.put(quote);
  }

  void deleteQuote(int id) {
    _quoteBox.remove(id);
  }

  void updateQuote(Quote quote) {
    _quoteBox.put(quote); // `put` juga bisa update
  }
}

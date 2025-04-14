import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_1/services/game_service.dart';
import 'package:testing_1/widgets/game_buttons.dart';
import 'package:testing_1/widgets/image_display.dart';
import 'package:testing_1/widgets/quote_card.dart';
import 'package:testing_1/models/quote.dart';
import '../../objectbox.g.dart';
import '../services/objectbox_service.dart';
import 'package:testing_1/models/globals.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Quote> _quotes = [];
  Quote? editingQuote;
  final TextEditingController textController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  void _loadQuotes() {
    final list = objectBox?.getAllQuotes() ?? [];
    setState(() {
      _quotes = list;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _loadQuotes();
      Provider.of<GameService>(context, listen: false).resetGame();
    });
  }

  void _addOrUpdateQuote(GameService gameService) {
    if (textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quote cannot be empty!'), backgroundColor: Colors.red),
      );
      return;
    }

    if (objectBox == null) {
      debugPrint('❌ objectBox masih null saat menambahkan quote');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Database not ready!'), backgroundColor: Colors.red),
      );
      return;
    }

    final quote = Quote(
      id: editingQuote?.id ?? 0,
      text: textController.text.trim(),
      author: authorController.text.trim().isEmpty ? 'Unknown' : authorController.text.trim(),
    );

    if (editingQuote != null) {
      objectBox!.updateQuote(quote);
    } else {
      objectBox!.addQuote(quote);
    }

    textController.clear();
    authorController.clear();
    editingQuote = null;

    _loadQuotes();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quote saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameService = Provider.of<GameService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game & Quotes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageDisplay(imagePath: gameService.currentImage),
              const SizedBox(height: 20),
              const GameButtons(),  // Tidak perlu `gameService`
              const SizedBox(height: 20),
              Text(
                'Correct: ${gameService.correctCount} | Wrong: ${gameService.wrongCount}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => gameService.resetGame(),
                child: const Text('Reset Game'),
              ),
              const SizedBox(height: 20),
              TextField(controller: textController, decoration: const InputDecoration(labelText: 'Quote Text')),
              TextField(controller: authorController, decoration: const InputDecoration(labelText: 'Author')),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _addOrUpdateQuote(gameService),
                child: Text(editingQuote != null ? 'Update Quote' : 'Add Quote'),
              ),
              const SizedBox(height: 20),
              Column(
                children: _quotes.map((quote) {
                  return QuoteCard(
                    quote: quote,
                    delete: () {
                      objectBox?.deleteQuote(quote.id);
                      _loadQuotes();
                    },
                    edit: () {
                      setState(() {
                        editingQuote = quote;
                        textController.text = quote.text ?? '';
                        authorController.text = quote.author ?? '';
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

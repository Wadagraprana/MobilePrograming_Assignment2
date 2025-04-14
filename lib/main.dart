import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_1/screens/main_screen.dart';
import 'package:testing_1/services/game_service.dart';
import 'package:testing_1/services/objectbox_service.dart';
import 'package:testing_1/models/globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game & Quotes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InitGate(),
    );
  }
}

class InitGate extends StatefulWidget {
  const InitGate({super.key});

  @override
  State<InitGate> createState() => _InitGateState();
}

class _InitGateState extends State<InitGate> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _initObjectBox();
  }

  Future<void> _initObjectBox() async {
    objectBox = await ObjectBoxService.create();
    debugPrint('✅ ObjectBox initialized: ${objectBox!.getAllQuotes().length} quotes loaded');

    setState(() {
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return const MainScreen();
  }
}

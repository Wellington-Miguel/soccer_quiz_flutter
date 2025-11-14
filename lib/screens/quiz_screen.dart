import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/di.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool loading = false;
  List<dynamic> questions = [];
  Map<int, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    setState(() { loading = true; });
    try {
      final container = Provider.of<ServiceContainer>(context, listen:false);
      final res = await container.apiClient.get('/quiz/questions');
      final json = jsonDecode(res.body) as List<dynamic>;
      setState(() { questions = json; });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao buscar questões: ' + e.toString())));
    } finally {
      setState(() { loading = false; });
    }
  }

  Future<void> submitAnswers() async {
    setState(() { loading = true; });
    try {
      final container = Provider.of<ServiceContainer>(context, listen:false);
      final payload = {'answers': answers.entries.map((e) => {'question_id': e.key, 'answer': e.value}).toList()};
      final res = await container.apiClient.post('/quiz/submit', payload);
      final json = jsonDecode(res.body) as Map<String,dynamic>;
      final score = json['score'];
      showDialog(context: context, builder: (_) => AlertDialog(title: Text('Resultado'), content: Text('Score: \$score'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))]));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao enviar respostas: ' + e.toString())));
    } finally {
      setState(() { loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading && questions.isEmpty) return Scaffold(appBar: AppBar(title: Text('Quiz')), body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ...questions.map((q) {
            final id = q['id'] as int;
            final opts = (q['options'] as List).cast<dynamic>();
            return Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(q['text'] ?? 'Questão'),
                  ...opts.map((opt) => RadioListTile(value: opt, groupValue: answers[id], title: Text(opt.toString()), onChanged: (v) { setState(() { answers[id] = v; }); })),
                ]),
              ),
            );
          }).toList(),
          SizedBox(height: 12),
          ElevatedButton(onPressed: answers.isEmpty ? null : submitAnswers, child: Text('Enviar respostas')),
        ],
      ),
    );
  }
}
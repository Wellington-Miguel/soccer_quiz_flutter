import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/di.dart';

class RankingScreen extends StatefulWidget {
  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<dynamic> ranking = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchRanking();
  }

  Future<void> fetchRanking() async {
    setState(() { loading = true; });
    try {
      final container = Provider.of<ServiceContainer>(context, listen:false);
      final res = await container.apiClient.get('/ranking/top');
      ranking = jsonDecode(res.body) as List<dynamic>;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: ' + e.toString())));
    } finally {
      setState(() { loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading && ranking.isEmpty) return Scaffold(appBar: AppBar(title: Text('Ranking')), body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text('Ranking')),
      body: ListView.builder(
        itemCount: ranking.length,
        itemBuilder: (context, i) {
          final item = ranking[i];
          return ListTile(title: Text(item['user'] ?? '-'), trailing: Text((item['points'] ?? 0).toString()));
        },
      ),
    );
  }
}
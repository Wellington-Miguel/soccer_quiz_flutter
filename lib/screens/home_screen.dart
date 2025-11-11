import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'quiz_screen.dart';
import 'ranking_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final name = auth.user?['name'] ?? 'Usuário';
    return Scaffold(
      appBar: AppBar(title: Text('Soccer Quiz')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Olá, ' + name),
          SizedBox(height: 16),
          ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen())), child: Text('Disputar Quiz')),
          ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RankingScreen())), child: Text('Ranking')),
          ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen())), child: Text('Perfil')),
          SizedBox(height: 12),
          ElevatedButton(onPressed: () => auth.logout(), child: Text('Sair')),
        ]),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'quiz_screen.dart';
import 'ranking_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart'; 

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    // Pega o nome ou usa um padrão se for nulo
    final name = auth.user != null ? (auth.user!['name'] ?? 'Usuário') : 'Usuário';

    return Scaffold(
      // Mantendo o estilo simples original
      appBar: AppBar(title: Text('Soccer Quiz')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Texto com cor branca para contrastar com o fundo preto definido no main.dart
          Text('Olá, ' + name, style: TextStyle(color: Colors.white, fontSize: 18)),
          
          SizedBox(height: 30),
          
          _buildMenuButton(context, "Disputar Quiz", () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen()))),
          _buildMenuButton(context, "Ranking", () => Navigator.push(context, MaterialPageRoute(builder: (_) => RankingScreen()))),
          _buildMenuButton(context, "Perfil", () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()))),
          
          SizedBox(height: 12),
          
          _buildMenuButton(context, "Sair", () async {
       
            await auth.logout();
            
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false, // Remove todas as rotas anteriores da pilha
            );
          }),
        ]),
      ),
    );
  }

  // Criei esse widget auxiliar só para os botões ficarem bonitinhos e padronizados iguais ao seu print
  Widget _buildMenuButton(BuildContext context, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 200,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Botão branco
            foregroundColor: Colors.deepPurple, // Texto roxo
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: onPressed,
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
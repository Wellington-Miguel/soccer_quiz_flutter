
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/providers/coin_provider.dart';
import 'package:soccer_quiz_flutter/screens/home_screen.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool loading = false;

  // Dados fictícios para imitar a imagem (Nome, Capacidade, Preço)
  final List<Map<String, dynamic>> availableQuizzes = [
    {"name": "Quiz de João", "players": "2/10", "price": "2 SC"},
    {"name": "Quiz de Lucas", "players": "3/5", "price": "1 SC"},
    {"name": "Quiz de Márcio", "players": "2/5", "price": "3 SC"},
    {"name": "Quiz de Marco", "players": "3/10", "price": "4 SC"},
    {"name": "Quiz de Filipe", "players": "9/10", "price": "5 SC"},
    {"name": "Quiz de Pedro", "players": "6/10", "price": "2 SC"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserCoins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: Image.asset(
              'assets/Logo.png', 
              width: 160,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.sports_soccer, size: 80, color: Colors.blue), // Placeholder caso não tenha logo
            ),
          ),
          
          // Título
          Text(
            "Lista de Salas Privadas",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
          ),

          SizedBox(height: 20),

          // LISTA (ListView.builder dentro de Expanded para ocupar o espaço)
          Expanded(
            child: ListView.builder(
              itemCount: availableQuizzes.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                final item = availableQuizzes[index];
                return _buildQuizItem(item);
              },
            ),
          ),

          // Botão Voltar e Rodapé
          _buildFooter(),
        ],
      ),
    );
  }

  // Widget que constrói cada linha da lista (Bola + Nome/Qtd + Preço)
  Widget _buildQuizItem(Map<String, dynamic> item) {
    // Cor da borda azul neon
    final borderColor = Colors.cyan; 

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          // Ícone da Bola (Substitua por Image.asset se tiver o ícone exato)
          Icon(Icons.sports_soccer, color: Colors.blueGrey[200], size: 30),
          SizedBox(width: 10),
          
          // Caixa com Nome e Lotação
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 2),
                // color: Colors.black, // Fundo transparente/preto
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item["name"],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    item["players"],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 10),

          // Caixa com o Preço (SC)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Text(
              item["price"],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Rodapé com botão verde e links
  Widget _buildFooter() {
    return Column(
      children: [
        SizedBox(height: 10),
        // Botão Voltar
        Container(
          width: 200,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFCCDC39), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text(
              "Voltar",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Links de Privacidade e Coins
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen(),));
                    },
                    child:Text("Privacidade e Termos", style: TextStyle(color: Color(0xFFCCDC39), fontSize: 12))),
                ],
              ),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.isLoading) {
                    return SizedBox(
                      width: 20, height: 20, 
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                    );
                  }
                  return Text(
                    "Soccer Coins: ${userProvider.coins}", // Valor dinâmico
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
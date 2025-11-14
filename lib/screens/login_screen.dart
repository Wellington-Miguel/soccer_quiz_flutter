import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
            'assets/Logo.png',
            width: 160,
            fit: BoxFit.contain,
          ),
          Text('Login'),
          Form(
            key: _formKey,
            child: Column(
             children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (v) => v != null && v.contains('@') ? null : 'E-mail inválido',
              ),
              TextFormField(
                controller: _pass,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (v) => v != null && v.length >= 4 ? null : 'Senha muito curta',
              ),
              SizedBox(height: 20),
              auth.state == AuthState.loading ? CircularProgressIndicator() :
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await auth.login(_email.text.trim(), _pass.text.trim());
                    if (auth.state == AuthState.authenticated) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                    } else if (auth.state == AuthState.error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error ?? 'Erro')));
                    }
                  }
                },
                child: Text('Entrar', style: TextStyle(color: Colors.white),),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
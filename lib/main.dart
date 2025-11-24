import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/screens/home_screen.dart';
import 'package:soccer_quiz_flutter/screens/list_user_screen.dart';
import 'package:soccer_quiz_flutter/screens/login_screen.dart';
import 'package:soccer_quiz_flutter/screens/profile_screen.dart';
import 'package:soccer_quiz_flutter/screens/ranking_screen.dart';
import 'providers/coin_provider.dart';
import 'services/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Carrega dependências
  final container = await buildServiceContainer();
  // Inicia o App passando o container
  runApp(MyApp(container: container));
}

class MyApp extends StatelessWidget {
  final ServiceContainer container;

  const MyApp({Key? key, required this.container}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider.value(value: container.authProvider),
        Provider.value(value: container),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soccer Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

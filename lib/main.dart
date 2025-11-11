import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'services/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = await buildServiceContainer();
  runApp(MyApp(container));
}

class MyApp extends StatelessWidget {
  final ServiceContainer container;
  MyApp(this.container);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => container.authProvider),
        Provider.value(value: container),
      ],
      child: MaterialApp(
        title: 'Soccer Quiz',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen(),
      ),
    );
  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/api/api_client.dart';
import '../data/repositories/auth_repository.dart';
import '../domain/i_auth_repository.dart';
import '../providers/auth_provider.dart';

class ServiceContainer {
  final IAuthRepository authRepository;
  final AuthProvider authProvider;
  final ApiClient apiClient;

  ServiceContainer({
    required this.authRepository,
    required this.authProvider,
    required this.apiClient,
  });
}

Future<ServiceContainer> buildServiceContainer() async {
  final secureStorage = FlutterSecureStorage();
  final apiClient = ApiClient(baseUrl: const String.fromEnvironment('BASE_URL', defaultValue: 'https://api.example.com'), secureStorage: secureStorage);
  final authRepository = AuthRepository(apiClient: apiClient);
  final authProvider = AuthProvider(authRepository: authRepository);
  return ServiceContainer(authRepository: authRepository, authProvider: authProvider, apiClient: apiClient);
}
// domain/usecase/register_usecase.dart
import 'package:project_sem2/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return repository.register(name, email, password, passwordConfirmation);
  }
}

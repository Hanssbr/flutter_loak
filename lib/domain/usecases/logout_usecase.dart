import 'package:project_sem2/data/datasource/auth_remote_datasource.dart';

class LogoutUsecase {
  final AuthRemoteDatasource authRemoteDatasource;

  LogoutUsecase(this.authRemoteDatasource);

  Future<void> call() async {
    await authRemoteDatasource.logout();
  }
}
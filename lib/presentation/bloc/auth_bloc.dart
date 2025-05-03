import 'package:bloc/bloc.dart';
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/domain/entities/user_entity.dart';
import 'package:project_sem2/domain/usecases/login_usecase.dart';
import 'package:project_sem2/domain/usecases/logout_usecase.dart';
import 'package:project_sem2/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUsecase logoutUseCase;
  final RegisterUseCase registerUseCase;
  final AuthLocalDatasource authLocalDatasource;

  AuthBloc(
    this.loginUseCase,
    this.logoutUseCase,
    this.registerUseCase,
    this.authLocalDatasource,
  ) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await loginUseCase(event.email, event.password);

        print('Login berhasil:');
        print('Token: ${result['token']}');
        print('User: ${result['user']}');
        await authLocalDatasource.saveToken(result['token']);
        emit(AuthSuccess(result['user'], result['token']));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await logoutUseCase();
        emit((AuthLogout()));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await registerUseCase.call(
          name: event.name,
          email: event.email,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
        );
        await authLocalDatasource.saveToken(result['token']);
        emit(AuthSuccess(result['user'], result['token']));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}

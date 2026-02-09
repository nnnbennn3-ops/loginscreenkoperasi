import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final user = await LoginService.login(email, password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

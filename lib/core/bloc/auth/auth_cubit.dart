import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes/core/bloc/auth/auth_state.dart';
import 'package:recipes/core/models/user_model.dart';
import 'package:recipes/firebase/firebase_services.dart';

import '../reciepes/reciepes_cubit.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._recipesCubit) : super(const AuthState());

  final ReciepesCubit _recipesCubit;

  Future<void> bootstrapSession() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
      return;
    }

    final user = await FirebaseService.getUSerFromFIreStore(firebaseUser.uid);
    if (user == null) {
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
      return;
    }

    _recipesCubit.setPoster(user.poster);
    await _recipesCubit.loadFromFirestore();
    emit(state.copyWith(status: AuthStatus.authenticated, user: user));
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final credential =
        await FirebaseService.login(email: email, password: password);
    final user =
        await FirebaseService.getUSerFromFIreStore(credential.user!.uid);
    if (user == null) {
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
      return null;
    }
    _recipesCubit.setPoster(user.poster);
    await _recipesCubit.loadFromFirestore();
    emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    return user;
  }

  Future<void> register(UserModel user, String password) async {
    final credential = await FirebaseService.register(
      email: user.email,
      password: password,
    );
    final userToSave = UserModel(
      id: credential.user!.uid,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      poster: user.poster,
    );
    await FirebaseService.addUserToFireStore(userToSave);
    await FirebaseAuth.instance.signOut();
    emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
  }

  Future<void> logout() async {
    _recipesCubit.clearAll();
    await FirebaseAuth.instance.signOut();
    emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
  }

  void updateCurrentUser(UserModel user) {
    emit(state.copyWith(status: AuthStatus.authenticated, user: user));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:gestion_tareas/core/presentation/screens/providers/providers.dart';

class UsersState extends Equatable {
  final List<UserEntity>? users;
  final bool isLoading;
  final String? errorMessage;

  const UsersState({
    this.users,
    this.isLoading = false,
    this.errorMessage,
  });

  UsersState copyWith(
      {
        List<UserEntity>? users,
        bool? isLoading,
        String? errorMessage,
      }) {
    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [users];
}

class UsersProvider extends StateNotifier<UsersState> {
  UsersProvider(this.ref) : super(const UsersState()) {
    getUsers();
  }

  Ref ref;

  Future<void> getUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final users = await ref.read(getUsersUseCase).call();
    users.fold((l) => {
      state = state.copyWith(isLoading: false, errorMessage: l)
    }, (response) {
      state = state.copyWith(users: response, isLoading: false);
    });
  }

}

final usersProvider = StateNotifierProvider.autoDispose<UsersProvider, UsersState>(
      (ref) => UsersProvider(ref),
);


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_tareas/core/data/local_data_source/local_data_source.dart';
import 'package:gestion_tareas/core/data/network/network.dart';
import 'package:gestion_tareas/core/data/remote_data_source/remote_data_source.dart';
import 'package:gestion_tareas/core/data/repositories/repositories.dart';
import 'package:gestion_tareas/core/domain/use_cases/use_cases.dart';


// Remote Data Source
final usersRemoteDataSource = Provider((ref) => UsersRemoteDataSources(ref.watch(dioProvider)));
// Repositories
final userRepositoryProvider = Provider((ref) => UsersRepositoryImpl(ref.watch(usersRemoteDataSource)));
// Use Cases
final getUsersUseCase = Provider((ref) => GetUsersUseCase(ref.watch(userRepositoryProvider)));

final getTaksUsecase = Provider((ref) => GetTaskByUserIdUseCase(ref.watch(userRepositoryProvider)));

// Local Data Source
final localTasksRemoteDataSource = Provider((ref) => LocalTasksDataSource());

// Repositories
final localTasksRepositoryProvider = Provider((ref) => LocalTasksRepositoryImpl(ref.watch(localTasksRemoteDataSource)));

// Use Cases
final deleteTaskByIdUseCaseProvider = Provider((ref) => DeleteLocalTaskByIdUseCase(ref.watch(localTasksRepositoryProvider)));
final getLocalTaskUseCase = Provider((ref) => GetLocalTasksUseCase(ref.watch(localTasksRepositoryProvider)));
final saveLocalTaskUseCase = Provider((ref) => SaveLocalTaskUseCase(ref.watch(localTasksRepositoryProvider)));

final saveLocalTasksUseCase = Provider((ref) => SaveLocalTasksUseCase(ref.watch(localTasksRepositoryProvider)));

final updateLocalTaskUseCase = Provider((ref) => UpdateLocalTaskUseCase(ref.watch(localTasksRepositoryProvider)));
final getLocalTaskByIdUseCase = Provider((ref) => GetLocalTaskByIdUseCase(ref.watch(localTasksRepositoryProvider)));
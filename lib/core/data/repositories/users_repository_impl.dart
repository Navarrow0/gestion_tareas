
part of 'repositories.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSources remoteDataSource;
  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<UserEntity>>> getUsers() async {
    final result = await remoteDataSource.getUsers();
    return result.fold((l) => Left(l), (r) => Right(r.map((e) => e.toEntity()).toList(),));
  }

  @override
  Future<Either<String, List<TaskEntity>>> getTasksByIdUser({required int userId}) async {
    final result = await remoteDataSource.getTasksByIdUser(userId: userId);
    return result.fold(
          (l) => Left(l),
          (r) => Right(
            r.map((e) => e.toEntity()).toList(),
          ),
    );
  }

}

part of 'remote_data_source.dart';

class UsersRemoteDataSources {
  final Dio dio;
  UsersRemoteDataSources(this.dio);

  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      final response = await dio.get(
        'users',
      );
      var users = (response.data as List).map((item) => UserModel.fromJson(item)).toList();
      return Right(users);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<TaskModel>>> getTasksByIdUser({required int userId}) async {
    try {
      final response = await dio.get('todos?userId=$userId',);
      var tasks = (response.data as List).map((item) => TaskModel.fromJson(item)).toList();
      return Right(tasks);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

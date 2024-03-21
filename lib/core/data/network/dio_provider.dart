
part of 'network.dart';


final dioProvider = Provider<Dio>((ref) {
  var dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com/',
    contentType: 'application/json; charset=UTF-8',
    headers: {
      'Accept': 'application/json',
    },
    receiveDataWhenStatusError: true,
    validateStatus: (_) => true,
  ));

  return dio;
});
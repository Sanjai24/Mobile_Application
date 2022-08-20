// import 'package:api_integrator/Users_Res.dart';
// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:retrofit/retrofit.dart';
// part '../ApiService.g.dart';

// @RestApi(baseurl: 'http://localhost:5036')
// abstract class ApiService {
//   factory ApiService(Dio dio, {String baseurl}) = _ApiService;

//   @GET('/getall')
//   Future<Users_Res> GetAllUsers();
// }

import 'package:api_integrator/models/LoginReq.dart';
import 'package:api_integrator/models/NotifRes.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/LoginRes.dart';
import '../models/NotifReq.dart';
import '../models/SignupRes.dart';

part 'ApiService.g.dart';

//flutter packages pub run build_runner watch --delete-conflicting-outputs
// class Apis {
//   static const String getall = '/getall';
// }

@RestApi(baseUrl: "http://54.88.43.153:6500/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('login')
  Future<LoginRes> login(@Body() LoginReq body);

  @POST('signup')
  Future<SignupRes> signUp(@Body() LoginReq body);

  @POST('notification')
  Future<NotifRes> notification(@Body() NotifReq body);

  static ApiClient create() {
    final dio = Dio();
    try {
      print("check");
      dio.interceptors.add(PrettyDioLogger());
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers["Content-Type"] = "application/json";
        options.followRedirects = false;
        options.validateStatus = (status) {
          return status! < 500;
        };
        return handler.next(options);
      }));
      return ApiClient(dio);
    } on DioError catch (error) {
      print("DioError");
      print(error);
      print(error.error);
      return ApiClient(dio);
    }
  }
}

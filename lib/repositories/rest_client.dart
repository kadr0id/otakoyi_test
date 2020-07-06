import 'package:dio/dio.dart';
import 'package:otakoyi_test/ui/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class RestClient {
  Dio dio = new Dio();
  SharedPreferences _pref;
  Connectivity _connectivity;

  RestClient(this._pref) {
    dio.options.baseUrl = base_url;
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000;
    _connectivity = new Connectivity();
    onSendInterceptors();
  }

  void onSendInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) {
        var token = _pref.getString(TOKEN);
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Token $token";
          options.headers["Content-Type"] = "application/json";
        }
        print(
            "Request: ${options.baseUrl + options.path} -  ${options.data.toString()}");
        return options;
      },
    ));
  }

  Future<Response> post(String path,
      {dynamic data, CancelToken cancelToken}) async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return new Response(data: {
        "error": ["No internet connectivity."]
      });
    } else {
      try {
        Response response =
            await dio.post(path, data: data, cancelToken: cancelToken);
        print("URL:" +
            response.request.baseUrl +
            response.request.path +
            " - Response: " +
            response.data.toString());

        return response;
      } catch (e) {
        print(e);
        if (e is DioError) {
          if (e.response != null) {
            return e.response;
          } else {
            return new Response(data: {
              "error": ["Unknown error."]
            });
          }
        } else {
          return new Response(data: {
            "error": ["Unknown error."]
          });
        }
      }
    }
  }

  Future<Response> get(String path,
      {dynamic data,
      Function(Map<String, dynamic>) success,
      Function(Response) error,
      CancelToken cancelToken}) async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return new Response(data: {
        "error": ["No internet connectivity."]
      });
    } else {
      try {
        Response response = await dio.get(path, cancelToken: cancelToken);
        print("URL:" +
            response.request.baseUrl +
            response.request.path +
            " - Response: " +
            response.data.toString());
        return response;
      } catch (e) {
        if (e is DioError) {
          if (e.response != null) {
            return e.response;
          } else {
            return new Response(data: {
              "error": ["Unknown error."]
            });
          }
        } else {
          return new Response(data: {
            "error": ["Unknown error."]
          });
        }
      }
    }
  }

  Future<Map<String, dynamic>> getSync(String path) async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return {
        "error": ["No internet connectivity."]
      };
    } else {
      try {
        Response<Map<String, dynamic>> response = await dio.get(path);
        if (response != null && response.data != null) {
          return response.data;
        } else {
          return {};
        }
      } catch (e) {
        print(e);
        return {};
      }
    }
  }

  Future<dynamic> put(String path,
      {dynamic data,
      Function(Map<String, dynamic>) success,
      Function(Response) error,
      CancelToken cancelToken}) async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return new Response(data: {
        "error": ["No internet connectivity."]
      });
    } else {
      try {
        Response response =
            await dio.put(path, data: data, cancelToken: cancelToken);
        print("URL:" +
            response.request.baseUrl +
            response.request.path +
            " - Response: " +
            response.data.toString());
        return response;
      } catch (e) {
        if (e is DioError) {
          if (e.response != null) {
            return e.response;
          } else {
            return new Response(data: {
              "error": ["Unknown error."]
            });
          }
        } else {
          return new Response(data: {
            "error": ["Unknown error."]
          });
        }
      }
    }
  }

  Future<dynamic> patch(String path,
      {dynamic data,
      Function(Map<String, dynamic>) success,
      Function(Response) error,
      CancelToken cancelToken}) async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return new Response(data: {
        "error": ["No internet connectivity."]
      });
    } else {
      try {
        Response response =
            await dio.patch(path, data: data, cancelToken: cancelToken);
        print("URL:" +
            response.request.baseUrl +
            response.request.path +
            " - Response: " +
            response.data.toString());
        return response;
      } catch (e) {
        if (e is DioError) {
          if (e.response != null) {
            return e.response;
          } else {
            return new Response(data: {
              "error": ["Unknown error."]
            });
          }
        } else {
          return new Response(data: {
            "error": ["Unknown error."]
          });
        }
      }
    }
  }

  void delete(String path,
      {dynamic data,
      Function success,
      Function(Response) error,
      CancelToken cancelToken}) {
    _connectivity.checkConnectivity().then((_result) {
      if (_result == ConnectivityResult.none) {
        error(new Response(data: {
          "error": ["No internet connectivity."]
        }));
      } else {
        dio
            .delete(
          path,
        )
            .then((response) {
          if (response.data != null && response.data.toString().isNotEmpty) {
            success(data);
            print("URL:" +
                response.request.baseUrl +
                response.request.path +
                " - Response: " +
                response.data.toString());
          } else {
            success(data);
            print("URL:" + response.request.baseUrl + response.request.path);
          }
        }).catchError((e) {
          if (e is DioError) {
            DioError err = e;
            if (err.response != null) {
              print("Post error: " + err.response.data.toString());
              error(err.response);
            } else {
              print(e);
            }
          }
        });
      }
    });
  }
}

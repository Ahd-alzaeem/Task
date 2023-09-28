import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../errors/custom_exeption.dart';
import '../local_storage/local_storage.dart';
import '../network/dio.dart';
import '../utils/utils.dart';

enum RequestMethod { get, post, delete, put, patch }

class Request {
  final String endPoint;
  final bool authorized;
  final bool isFormData;
  final bool removeMockMatch;
  final RequestMethod method;
  Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParams;
  final String? token;

  Request(this.endPoint, this.method,
      {this.authorized = false,
      this.removeMockMatch = false,
      this.isFormData =
          // ignore: todo
          false, // TODO: formData should be handled in different way.
      this.headers,
      this.body,
      this.queryParams,
      this.token}) {
    if (authorized) {
      headers = {
        "Accept": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBpLm1lZGlhLW5hcy5uZXQvYXBpL3VzZXJzL3YxL2xvZ2luIiwiaWF0IjoxNjk1MTAzMjc1LCJleHAiOjE2OTc1MTUyNzUsIm5iZiI6MTY5NTEwMzI3NSwianRpIjoiMEFlUHJYbHdhYzVldFRucCIsInN1YiI6Ijg2MCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.3MArC7a18eeOQ0IRXjpXjD8DvCiYTtI7CmRa0CzmM08",
      };
    }

    if (isFormData) {
      log('im form data');
      FormData f = FormData.fromMap(body!);
      for (var pair in f.fields) {
        log('${pair.key}/${pair.value}');
      }
    }
  }

  Future<Map<String, dynamic>> sendRequest() async {
    Response? response;
    try {
      response = await DioInstance().dio.request(
            endPoint,
            queryParameters: queryParams,
            data: isFormData ? FormData.fromMap(body!) : body,
            options: Options(
              method: Utils.requestTypeToString(method),
              headers: headers,
              // contentType: 'application/json',
            ),
          );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // ignore: todo
        //TODO: this should be handled in different way.
        if (response.data is String) return json.decode(response.data);
        return response.data;
      }
    } on DioError catch (error) {
      // handling http status code exceptions
      if (error.type == DioErrorType.badResponse) {
        // handling bad requests.
        if (error.response!.statusCode == 400) {
          // this line is really depends on what server responds, and how it reply with errors.
          throw badRequestException[error.response!.data["error"]] ??
              GenericException(
                type: ExceptionType.Other,
              );
        }

        // handling other status codes.
        throw statusCodesException[error.response!.statusCode] ??
            GenericException(
              type: ExceptionType.Other,
            );
      }

      // handling connection problems.
      if (error.type == DioErrorType.connectionTimeout ||
          error.type == DioErrorType.sendTimeout ||
          error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.unknown) {
        throw GenericException(
          type: ExceptionType.ConnectionError,
          errorMessage: "You Have no Internet Connection",
        );
      }
    }
    return {};
  }
}

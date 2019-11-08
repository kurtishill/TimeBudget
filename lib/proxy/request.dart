import 'package:time_budget/responses/basic_response.dart';
import 'package:time_budget/serialization/decodable.dart';
import 'package:time_budget/serialization/encodable.dart';

import 'package:http/http.dart' as http;

class Request {
  static Future<U> send<T extends Encodable, U extends Decodable>(
    String url,
    String method, {
    T requestBody,
    Map<String, String> headers,
  }) async {
    Function request;
    switch (method.toLowerCase()) {
      case 'get':
        request = http.get;
        break;
      case 'post':
        request = http.post;
        break;
    }
    try {
      String body = requestBody.toRawJson();
      http.Response response;

      if (method.toLowerCase() == 'get') {
        response = await request(
          url,
          headers: headers ?? Map<String, String>(),
        );
      } else {
        response = await request(
          url,
          body: body ?? null,
          headers: headers ?? Map<String, String>(),
        );
      }

      Decodable responseObject;
      if (response.statusCode != 200) {
        responseObject = Decodable.create(U).fromRawJson("\"success\": false");
      } else {
        if (response.contentLength == 0) {
          responseObject = Decodable.create(U).fromRawJson("\"success\": true");
        } else {
          responseObject = Decodable.create(U).fromRawJson(response.body);
        }
      }

      return responseObject;
    } catch (e) {
      throw e;
    }
  }
}

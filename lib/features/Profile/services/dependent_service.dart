import 'package:MedInvent/config/api.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiConfig.baseUrl;

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String api) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _headers = {"Content-Type": "application/json"};
      var response = await client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        //print(response.body);
        return response.body;
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    } finally {
      client.close();
    }
  }

  Future<dynamic> post(String api, dynamic body) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _headers = {"Content-Type": "application/json"};
      var response = await client.post(url, headers: _headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        throw Exception('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    } finally {
      client.close();
    }
  }

  Future<dynamic> put(String api, dynamic body) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _headers = {"Content-Type": "application/json"};
      var response = await client.put(url, headers: _headers, body: body);

      if (response.statusCode == 200) {
        print(response);
        return response.body;
      } else {
        throw Exception('Failed to update data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    } finally {
      client.close();
    }
  }

  Future<dynamic> delete(String api) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _headers = {"Content-Type": "application/json"};
      var response = await client.delete(url, headers: _headers);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to delete data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    } finally {
      client.close();
    }
  }

  // Future<dynamic> post(String api) async {
  //   // Implement the POST method if needed
  // }
  //
  // Future<dynamic> put(String api) async {
  //   // Implement the PUT method if needed
  // }
  //
  // Future<dynamic> delete(String api) async {
  //   // Implement the DELETE method if needed
  // }

  //Link User service api

  Future<dynamic> postCheckuserdata(String api, dynamic body) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _headers = {"Content-Type": "application/json"};
      var response = await client.post(url, headers: _headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        throw Exception('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    } finally {
      client.close();
    }
  }
}

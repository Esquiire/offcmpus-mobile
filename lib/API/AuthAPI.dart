import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/**
 * AuthAPI: Handle login / logout requests.
 */

class Request {
  // TODO set the production backend Url
  static String backendUrl([String path = ""]) => "http://10.0.2.2:9010$path";

  /**
   * Create a post request to the target url
   */
  static Future<http.Response> post(String apiUrl, {Map<String, String> body}) {
    var uri = Uri.parse(Request.backendUrl(apiUrl));
    if (body == null)
      return http.post(uri);
    else
      return http.post(uri, body: body);
  }
}

class AuthAPI {
  static Future<http.Response> login(String email, String password) {
    return Request.post("/auth/local-auth",
        body: {"email": email, "password": password, "auth_type": 'student'});
  }

  // static Future<http.Response>

  /**
   * @desc Process the response payload returned from an authentication
   * request.
   * The payload is expected to have a set-cookie property in the header with
   * the key: connect.sid. This cookie value should be stored in the keychain.
   * @return If the cookie is not found, then return false. If the cookie is found 
   * and stored, return true.
   * 
   */
  static Future<bool> processAuthResponse(http.Response response) async {
    // if no set-cookie key is found, then the processing fails
    if (!response.headers.containsKey("set-cookie")) return false;

    String cookie = response.headers["set-cookie"];
    if (cookie.substring(0, 11) != "connect.sid") return false;

    int end = cookie.indexOf(';');
    if (end == -1) end = cookie.length;

    String connectSid = cookie.substring(12, end);

    // TODO store the connect_sid in storage
    final storage = new FlutterSecureStorage();
    storage.write(key: 'connect.sid', value: connectSid);

    return true;
  }
}

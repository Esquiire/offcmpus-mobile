import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

/**
 * AuthAPI: Handle login / logout requests.
 */

String remote_ip = "192.168.1.49";
String local_ip = "10.0.2.2";

class Request {
  // TODO set the production backend Url
  static String backendUrl([String path = ""]) => "http://$remote_ip:9010$path";

  /**
   * Create a post request to the target url
   */
  static Future<http.Response> post(String apiUrl,
      {Map<String, String> body, Map<String, String> headers}) {
    var uri = Uri.parse(Request.backendUrl(apiUrl));
    if (body == null)
      return http.post(uri, headers: headers == null ? {} : headers);
    else
      return http.post(uri,
          headers: headers == null ? {} : headers, body: body);
  }

  static Future<http.Response> get(String apiUrl,
      {Map<String, String> headers}) {
    var uri = Uri.parse(Request.backendUrl(apiUrl));
    return http.get(uri, headers: headers == null ? {} : headers);
  }
}

class AuthAPI {
  static Future<http.Response> login(String email, String password) {
    return Request.post("/auth/local-auth",
        body: {"email": email, "password": password, "auth_type": 'student'});
  }

  static Future<http.Response> getUser(String connectSid) {
    return Request.get('/auth/user',
        headers: {'Cookie': "connect.sid=$connectSid;"});
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
  static Future<String> processAuthResponse(http.Response response) async {
    // if no set-cookie key is found, then the processing fails
    if (!response.headers.containsKey("set-cookie")) return null;

    String cookie = response.headers["set-cookie"];
    if (cookie.substring(0, 11) != "connect.sid") return null;

    int end = cookie.indexOf(';');
    if (end == -1) end = cookie.length;

    String connectSid = cookie.substring(12, end);

    // TODO store the connect_sid in storage
    final storage = new FlutterSecureStorage();
    storage.write(key: 'connect.sid', value: connectSid);

    return connectSid;
  }
}

@HiveType(typeId: 0)
class StudentState {
  @HiveField(0)
  String connectSid;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  /**
   * @desc Fetch the user information by making a request
   * to the backend with the stored connectSid. There must be
   * a [student] key with a value of StudentState instance
   * stored in the hive box [appState]. If none is found,
   * the function fails.
   * 
   * @returns true if the data was successfull retrieved.
   * Otherwise, return false.
   */
  static Future<bool> fetchUserData() async {
    return Hive.openBox('appState').then((box) async {
      // get the 'student' object. if it does not
      // exist, return false...
      StudentState student = box.get('student');
      if (student == null) return false;

      // make a request to the backend to get the
      // information for the user.
      http.Response response_ = await AuthAPI.getUser(student.connectSid);
      if (response_.statusCode == 200) {
        // prase the data.

        Map<String, dynamic> userPayload = jsonDecode(response_.body);

        // check that the user is authenticated
        // and is a student.
        if (!userPayload.containsKey("authenticated") ||
            !userPayload.containsKey("user") ||
            !userPayload["user"].containsKey("type") ||
            userPayload["user"]["type"] != "student" ||
            userPayload["authenticated"] == false) {
          return false;
        }

        // for now, store the firstName and lastName
        // of the student
        if (!userPayload["user"].containsKey("first_name") ||
            !userPayload["user"].containsKey("last_name")) return false;

        student.firstName = userPayload["user"]["first_name"];
        student.lastName = userPayload["user"]["last_name"];

        // save the updated student
        await box.put("student", student);

        return true;
      }

      // default return
      return false;
    });
  }
}

class StudentStateAdapter extends TypeAdapter<StudentState> {
  @override
  final typeId = 0;

  @override
  StudentState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentState()
      ..connectSid = fields[0] as String
      ..firstName = fields[1] as String
      ..lastName = fields[2] as String;
    // description: fields[1] as String,
    // complete: fields[2] as bool,
  }

  @override
  void write(BinaryWriter writer, StudentState obj) {
    writer
      // First, write the # of fields that the object contains
      // (for the time being, it is just 1)
      ..writeByte(1)
      // Then write each of the field, with their corresponding
      // field ids.
      // StudentState => HiveField(0) = connectSid
      ..writeByte(0)
      ..write(obj.connectSid)
      // StudentState => HiveField(1) = firstName
      ..writeByte(1)
      ..write(obj.firstName)
      // StudentState => HiveField(2) = lastName
      ..writeByte(2)
      ..write(obj.lastName);
  }
}

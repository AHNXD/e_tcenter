// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/models/student.dart';
import 'package:e_tcenter/models/student_wallets.dart';

class ApiService {
  static var ip = "http://192.168.1.2:8000/api";
  static String? token;

  static Future register(String first_name, String last_name, String email,
      String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$ip/student/register"));

    request.body = json.encode({
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future login(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$ip/student/login"));

    request.body = json.encode({
      'email': email,
      'password': password,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      token = js['token'];
      var std = js['student'];
      var wal = js['StudentWallet'];
      studentData = Student(
          id: std['id'],
          firstName: std['first_name'],
          lastName: std['last_name'],
          email: std['email']);
      studentWalletData = StudentWallet(
          id: wal['id'], student_id: wal["student_id"], value: wal["value"]);
    }

    return response.statusCode;
  }

  static Future getStudentWallet(int id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse("$ip/student/${studentData.id}/wallet-value"));

    request.body = json.encode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      var newWallet = js['wallet_value'];

      studentWalletData = StudentWallet(
          id: studentWalletData.id,
          student_id: studentWalletData.student_id,
          value: newWallet);
    }
    return response.statusCode;
  }

  static Future chargeWallet(int amount) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse("$ip/student/${studentData.id}/add-money"));

    request.body = json.encode({
      "amount": amount,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future getAllCategories() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse("$ip/getallcategries"));

    request.body = json.encode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      return js;
    }
    return null;
  }
  /*
  //get
  static Future getUser({String code = ""}) async {
    final Uri getUser;
    if (code == "") {
      getUser = Uri.parse("${ip}Get");
    } else {
      getUser = Uri.parse("${ip}Get?code=$code");
    }
    final response = await http.get(getUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return json.decode(response.body);
  }

  //post
  static Future register(
      {required String code,
      required String name,
      required String pass,
      required String amount}) async {
    int price = int.parse(amount);
    final regisetrUser = Uri.parse(
        "${ip}Register?code=$code&name=$name&password=$pass&amount=$price");
    var response = await http.post(regisetrUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future Activate({
    required String code,
  }) async {
    final act = Uri.parse("${ip}Activate?code=$code");
    final response = await http.post(act,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future deactivate({
    required String code,
  }) async {
    final deact = Uri.parse("${ip}Deactivate?code=$code");
    final response = await http.post(deact,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future pay({
    required String code,
    required String amount,
    required String notes,
  }) async {
    int price = int.parse(amount);
    final regisetrUser =
        Uri.parse("${ip}Pay?code=$code&amount=$price&notes=$notes");
    final response = await http.post(regisetrUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${token!}"});
    return response.statusCode;
  }

  static Future adminLogin(String code, String password) async {
    final loginUrl = Uri.parse("${ip}AdminLogin?code=$code&password=$password");
    final response = await http.post(loginUrl);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      token = jsonResponse['token'];
    } else {
      token = null;
    }
    return response.statusCode;
  }*/
}

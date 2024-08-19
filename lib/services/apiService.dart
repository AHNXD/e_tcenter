// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:e_tcenter/models/teacher.dart';
import 'package:e_tcenter/models/wallets.dart';
import 'package:http/http.dart' as http;
import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/models/student.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static var ip = "http://192.168.217.33:8000/api";
  static String? token;

  static Future registerStudent(String first_name, String last_name,
      String email, String password) async {
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

  static Future loginStudent(String email, String password) async {
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
      WalletData = Wallet(
          id: wal['id'], student_id: wal["student_id"], value: wal["value"]);
    }
    isTeacher = false;
    isGuest = false;
    return response.statusCode;
  }

  static Future registerTeacher(
      String first_name,
      String last_name,
      String email,
      String password,
      String specialization,
      int years_of_experience,
      String previous_place_of_work) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$ip/teacher/register"));

    request.body = json.encode({
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password,
      "specialization": specialization,
      "years_of_experience": years_of_experience,
      "previous_place_of_work": previous_place_of_work
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future loginTeacher(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$ip/teacher/login"));

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
      var teach = js['teacher'];
      var wal = js['wallet'];
      teacherData = Teacher(
          id: teach['id'],
          firstName: teach['first_name'],
          lastName: teach['last_name'],
          email: teach['email'],
          placeOfWork: teach["previous_place_of_work"],
          specialization: teach["specialization"],
          years: teach["years_of_experience"]);

      WalletData = Wallet(
          id: wal['id'], student_id: wal["teacher_id"], value: wal["value"]);
    }
    isTeacher = true;
    isGuest = false;
    return response.statusCode;
  }

  static Future getStudentWallet(int id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse("$ip/student/${studentData.id}/wallet-value"));

    request.body = json.encode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      var newWallet = js['wallet_value'];

      WalletData = Wallet(
          id: WalletData.id,
          student_id: WalletData.student_id,
          value: newWallet);
    }
    return response.statusCode;
  }

  static Future getTeacherWallet(int id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse("$ip/teacher/${teacherData.id}/wallet-value"));

    request.body = json.encode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      var newWallet = js['wallet_value'];

      WalletData = Wallet(
          id: WalletData.id,
          student_id: WalletData.student_id,
          value: newWallet);
    }
    return response.statusCode;
  }

  static Future chargeWallet(int amount) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse("$ip/student/${studentData.id}/add-money"));

    request.body = json.encode({
      "amount": amount,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future transferToTeacher(int s_id, int t_id, int amount) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse("$ip/student/$s_id/transfer-to-teacher/$t_id"));

    request.body = json.encode({
      "amount": amount,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future subscribe(int s_id, int c_id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse("$ip/courses/$s_id/$c_id/subscribe"));

    request.body = json.encode({});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future getAllCategories() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
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

  static Future getSubscribedCourses() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse("$ip/getSubscribedCourse/${studentData.id}"));

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

  static Future getCoursesByCategory(int id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse("$ip/searchCource/$id"));

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

  static Future getCourseDetail(int id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse("$ip/course/$id"));

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

  static Future getAllCourses() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse("$ip/courses"));

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

  static Future createCourse(int category_id, int teacher_id, String name,
      int price, String description) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse("$ip/teacher/add/course"));
    request.body = json.encode({
      "category_id": category_id,
      "teacher_id": teacher_id,
      "name": name,
      "price": price,
      "discription": description
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode;
  }

  static Future getTeachersData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse("$ip/teacher/full-names"));

    request.body = json.encode({});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      var data = js["teachers"];
      return data;
    }
    return null;
  }

  static Future getTeacherData(int id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse("$ip/teacher/$id"));

    request.body = json.encode({});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var js = jsonDecode(responseBody);
      var data = js["teacher_info"];
      return data;
    }
    return null;
  }

  static Future addVideo(int id, String title, String description,
      XFile videoFile, XFile thumbnailFile) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final uri = Uri.parse(
        "$ip/teacher/add/video"); // Replace `$ip` with your actual IP address
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields['course_id'] = id.toString(); // Convert id to String
    request.fields['title'] = title;
    request.fields['discription'] = description;

    try {
      // Read video file as a stream (asynchronous)
      final videoStream = videoFile.openRead();

      // Add video file to the request
      request.files.add(http.MultipartFile(
        'file',
        videoStream,
        await videoFile.length(), // Get file length asynchronously
        filename: videoFile.name,
      ));

      // Handle thumbnail upload (if needed)
      // Read thumbnail file as a stream (asynchronous)
      final thumbnailStream = thumbnailFile.openRead();

      // Add thumbnail file to the request
      request.files.add(http.MultipartFile(
        'thumbnail',
        thumbnailStream,
        await thumbnailFile.length(), // Get file length asynchronously
        filename: thumbnailFile.name,
      ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print(response.statusCode);
      return response.statusCode;
    } catch (error) {
      print('Error uploading video and thumbnail: $error');
      // Handle other errors (e.g., show error message)
    }
  }
}

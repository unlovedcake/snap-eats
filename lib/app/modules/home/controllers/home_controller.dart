import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final functions = FirebaseFunctions.instanceFor(region: 'asia-southeast2');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<dynamic> payMongo() async {
    final HttpsCallable callable = functions.httpsCallable('payMongo');

    final response = await callable.call(<String, dynamic>{
      'amount': 10000,
      'description': 'sample description',
      'remarks': 'Remarks Sample',
    });

    if (response.data == null) {
      throw Exception('data from server is null'.tr);
    }

    Map<String, dynamic> jsonMap = jsonDecode(response.data);

    print(jsonMap);

    return response.data;
  }

  Future<dynamic> addTodo() async {
    final HttpsCallable callable = functions.httpsCallable('todoFunction');

    final response = await callable.call(<String, dynamic>{
      'title': 'sample titles',
      'description': 'sample descriptions',
      'is_completed': true,
    });

    if (response.data == null) {
      throw Exception('data from server is null'.tr);
    }

    Map<String, dynamic> jsonMap = jsonDecode(response.data);

    print(jsonMap['data']['title']);

    return response.data;
  }

  Future<void> createTodo() async {
    const url = 'http://10.0.2.2:5001/snap-eats-29be8/us-central1/apiFunction'; // Replace with your API endpoint

    const data = {
      'title': 'sample title',
      'description': 'sample description',
      'is_completed': true,
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Set the header for JSON request
        },
        body: jsonEncode(data),  // Convert the todo to JSON format
      );

      if (response.statusCode == 201) {
        // Todo successfully created
        print('Todo created: ${response.body}');
      } else {
        // Handle error response
        print('Failed to create todo: ${response.body}');
      }
    } catch (e) {
      // Handle any errors
      print('Error creating todo: $e');
    }
  }
}

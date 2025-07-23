import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../utility/constants.dart';

class HttpService {
  final String baseUrl = MAIN_URL;
  final box = GetStorage();

  Future<Response> getItems({required String endpointUrl}) async {
    try {
      return await GetConnect().get('$baseUrl/$endpointUrl', headers: {
        'Authorization': "Basic " + (getLoginUsr()?.authData ?? '')
      });
    } catch (e) {
      return Response(
          body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }

  Future<String> getPhoneNumber() async {
    try {
      final response = await GetConnect().get('$baseUrl/public/supportNumber');
      return response.bodyString ?? ''; // ou trate como quiser
    } catch (e) {
      return "";
    }
  }

  Future<Response> getWithoutAuth({required String endpointUrl}) async {
    try {
      return await GetConnect().get('$baseUrl/$endpointUrl');
    } catch (e) {
      return Response(
          body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> addItem(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      print("itemdata on additem request " + itemData.toString());
      final response = await GetConnect().post(
          '$baseUrl/$endpointUrl', itemData, headers: {
        'Authorization': "Basic " + (getLoginUsr()?.authData ?? '')
      });

      return response;
    } catch (e) {
      print('Error: $e');
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> addItemAuth(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      final response =
          await GetConnect().post('$baseUrl/$endpointUrl', itemData);
      print(response.body);
      return response;
    } catch (e) {
      print('Error: $e');
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> updateItem(
      {required String endpointUrl,
      required String itemId,
      required dynamic itemData}) async {
    try {
      return await GetConnect().put('$baseUrl/$endpointUrl/$itemId', itemData,
          headers: {
            'Authorization': "Basic " + (getLoginUsr()?.authData ?? '')
          });
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> updateItemRequest(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      return await GetConnect().put('$baseUrl/$endpointUrl', itemData,
          headers: {
            'Authorization': "Basic " + (getLoginUsr()?.authData ?? '')
          });
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> deleteItem(
      {required String endpointUrl, required String itemId}) async {
    try {
      return await GetConnect().delete('$baseUrl/$endpointUrl/$itemId',
          headers: {
            'Authorization': "Basic " + (getLoginUsr()?.authData ?? '')
          });
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  User? getLoginUsr() {
    String userJson = box.read(USER_INFO_BOX);

    User? userLogged = User.fromJson(json.decode(userJson));
    return userLogged;
  }
}

import 'package:mekto/models/api_response.dart';
import 'package:mekto/screen/home_screen.dart';
import 'package:mekto/utility/snack_bar_helper.dart';
import 'package:flutter_login/flutter_login.dart';
import 'dart:convert' show json, base64, ascii, utf8;

import '../../../core/data/data_provider.dart';
import '../../../models/user.dart';
import '../login_screen.dart';
import '../../../services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utility/constants.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final box = GetStorage();

  UserProvider(this._dataProvider);

  Future<String?> login(LoginData data) async {
    try {
      String username = data.name.toLowerCase();
      String password = data.password;
      Map<String, dynamic> loginData = {
        "username": username,
        "password": password
      };

      final response = await service.addItemAuth(
          endpointUrl: 'auth/authenticate', itemData: loginData);

      if (response.isOk) {
        response.body['authData'] =
            base64.encode(utf8.encode(username + ":" + password));

        User? user = User.fromJson(response.body as Map<String, dynamic>);
        saveLoginInfo(user);
        SnackBarHelper.showSuccessSnackBar("Logado com sucesso!");
        return null;
      } else {
        SnackBarHelper.showErrorSnackBar(
            "Erro ao logar! ${response.body['message'] ?? response.statusText}");
        return "Error ${response.body['message'] ?? response.statusText}";
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar("Erro ao logar!a ${e}");
      return "Error ${e}";
    }
  }

  Future<String?> register(SignupData data) async {
    try {
      String username = data.name?.toLowerCase() ?? '';
      String password = data.password ?? '';
      Map<String, dynamic> user = {
        "username": username,
        "password": password,
        "name": username,
        "email": username
      };

      final response =
          await service.addItemAuth(endpointUrl: 'auth/signup', itemData: user);

      if (response.isOk) {
        SnackBarHelper.showSuccessSnackBar("Registrado com sucesso!");
        return null;
      } else {
        SnackBarHelper.showErrorSnackBar(
            "Erro ao registrar! ${response.body['message'] ?? response.statusText}");
        return "Error ${response.body['message'] ?? response.statusText}";
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar("Erro ao registrar! ${e}");
      return "Error ${e}";
    }
  }

  Future<void> saveLoginInfo(User? loginUser) async {
    await box.write(USER_INFO_BOX, json.encode(loginUser?.toJson()));

    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
  }

  User? getLoginUsr() {
    String? userJson = box.read(USER_INFO_BOX) ?? '';
    if (userJson == '') {
      return null;
    } else {
      User? userLogged = User.fromJson(json.decode(userJson));
      return userLogged;
    }
  }

  logOutUser() {
    box.remove(USER_INFO_BOX);
    Get.offAll(const HomeScreen());
  }

  Future<bool> delete(String email, String password) async {
    final Map<String, dynamic> deleteUserData = <String, String>{
      'username': email,
      'password': password
    };

    final Response<dynamic> response = await service.addItemAuth(
        endpointUrl: 'auth/delete', itemData: deleteUserData);
    print(response.body);
    return response.isOk;
  }
}

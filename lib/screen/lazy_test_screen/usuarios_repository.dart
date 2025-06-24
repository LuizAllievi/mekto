import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mekto/screen/lazy_test_screen/usuario.dart';

import '../../utility/constants.dart';

class UsuariosRepository extends ChangeNotifier {
  int _page = 1;
  final List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => _usuarios;

  getUsuarios() async {
    final url = '$BASE_API_ENDPOINT?_seed=$_page&_quantity=20';

    final response = await GetConnect().get(url);
    final results = response.body['data'];
    for (var i = 0; i < results.length; i++) {
      _usuarios.add(Usuario.fromMap(results[i]));
    }

    _page++;
    notifyListeners();
  }
}

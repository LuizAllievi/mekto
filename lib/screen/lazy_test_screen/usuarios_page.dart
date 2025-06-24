import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mekto/screen/lazy_test_screen/usuarios_list.dart';

import '../product_list_screen/components/custom_app_bar.dart';

class UsuariosPage extends StatelessWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const UsuariosList(),
    );
  }
}

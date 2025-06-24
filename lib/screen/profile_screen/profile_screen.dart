import '../login_screen/login_screen.dart';
import '../my_address_screen/my_address_screen.dart';
import '../../utility/animation/open_container_wrapper.dart';
import '../../utility/extensions.dart';
import '../../widget/navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_color.dart';
import '../my_order_screen/my_order_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showDeleteAccountForm = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    final List<Widget> deleteAccountFields = [
      const Center(
        child: Text(
          'Excluir Conta',
          style: titleStyle,
        ),
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(
          labelText: 'Informe seu email',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Informe seu email.';
          return null;
        },
      ),
      const SizedBox(height: 10),
      TextFormField(
        controller: _passwordController,
        decoration: const InputDecoration(
          labelText: 'Senha',
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Informe sua senha.';
          return null;
        },
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;

          final bool confirmDelete = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Excluir Conta"),
              content: const Text(
                  "Tem certeza que deseja excluir sua conta? Essa ação não pode ser desfeita."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Excluir")),
              ],
            ),
          );

          if (confirmDelete == true) {
            print("deleting account");
            final bool result = await context.userProvider
                .delete(_emailController.text, _passwordController.text);
            if (result) {
              Get.offAll(const LoginScreen());
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Conta excluída com sucesso.")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Erro ao excluir conta.")));
            }
          }
        },
        child: const Text('Confirmar Exclusão'),
      ),
      const SizedBox(height: 10),
      TextButton(
        onPressed: () => setState(() => showDeleteAccountForm = false),
        child: const Text("Cancelar"),
      ),
    ];
    final isLoggedIn = context.userProvider.getLoginUsr() != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Minha Conta",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 200,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              context.userProvider.getLoginUsr()?.name ??
                  'Usuário não identificado',
              style: titleStyle,
            ),
          ),
          const SizedBox(height: 40),
          const OpenContainerWrapper(
            nextScreen: MyOrderScreen(),
            child: NavigationTile(icon: Icons.list, title: 'Meus Pedidos'),
          ),
          const SizedBox(height: 15),
          const OpenContainerWrapper(
            nextScreen: MyAddressPage(),
            child:
                NavigationTile(icon: Icons.location_on, title: 'Meu Endereço'),
          ),
          const SizedBox(height: 20),
          if (showDeleteAccountForm)
            Form(key: _formKey, child: Column(children: deleteAccountFields))
          else
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isLoggedIn ? AppColor.lightBlue : AppColor.darkOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      if (isLoggedIn) {
                        context.userProvider.logOutUser();
                        Get.offAll(const LoginScreen());
                      } else {
                        Get.to(const LoginScreen());
                      }
                    },
                    child: Text(
                      isLoggedIn ? 'Sair' : 'Entrar',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () =>
                        setState(() => showDeleteAccountForm = true),
                    child: const Text(
                      'Excluir Conta',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

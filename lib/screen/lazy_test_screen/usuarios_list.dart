import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mekto/screen/lazy_test_screen/usuarios_repository.dart';

class UsuariosList extends StatefulWidget {
  const UsuariosList({super.key});

  @override
  State<UsuariosList> createState() => _UsuariosListState();
}

class _UsuariosListState extends State<UsuariosList> {
  late UsuariosRepository usuariosRepo;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    usuariosRepo = UsuariosRepository();
    loadUsuarios();
  }

  infiniteScrolling() {
    var loadingBeforePixels = 300;
    if (_scrollController.position.pixels + loadingBeforePixels >=
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      loadUsuarios();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  loadUsuarios() async {
    loading.value = true;
    await usuariosRepo.getUsuarios();
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: usuariosRepo,
        builder: (context, snapshot) {
          return Stack(
            children: [
              ListView.separated(
                  controller: _scrollController,
                  itemBuilder: ((context, index) {
                    final usuario = usuariosRepo.usuarios[index];

                    return ListTile(
                      leading: ClipRRect(
                          child: Image.network(usuario.avatar),
                          borderRadius: BorderRadius.circular(50)),
                      title: Text(usuario.nome),
                    );
                  }),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: usuariosRepo.usuarios.length),
              loadingIndicatorWidget(),
            ],
          );
        });
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 24,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ))
              : Container();
        });
  }
}



class Usuario {
  String nome;
  String avatar;

  Usuario({required this.nome, required this.avatar});

  factory Usuario.fromMap(Map<String, dynamic> map){
    return Usuario(
      nome: map['name'] ?? '',
      avatar: "https://picsum.photos/200/300",
    );
  }
}
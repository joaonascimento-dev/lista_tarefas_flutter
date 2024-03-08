class Tarefa {
  String? nome;
  bool concluido = false;

  Tarefa({required this.nome});

  String? getNome() {
    return nome;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  bool getConcluido() {
    return concluido;
  }

  void setConcluido(bool concluido) {
    this.concluido = concluido;
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "concluido": concluido,
    };
  }
}

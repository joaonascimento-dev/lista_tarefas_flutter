import 'dart:convert';
import 'dart:io';
import 'package:lista_tarefas_flutter/model/tarefa.dart';
import 'package:path_provider/path_provider.dart';

class TarefaRepository {
  TarefaRepository();

  Future<File> _getArquivo() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/dados.json");
  }

  void salvarLista(List<Tarefa> listTarefa) async {
    String dados = json.encode(listTarefa);
    File arquivo = await _getArquivo();
    arquivo.writeAsString(dados);
  }

  Future<List<Tarefa>> buscarLista() async {
    try {
      File arquivo = await _getArquivo();
      String dados = await arquivo.readAsString();
      List<Tarefa> listTarefa = json.decode(dados);
      return listTarefa;
    } catch (e) {
      return [];
    }
  }
}

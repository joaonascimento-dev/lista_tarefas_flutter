import 'package:flutter/material.dart';
import 'package:lista_tarefas_flutter/model/tarefa.dart';
import 'package:lista_tarefas_flutter/repository/tarefa_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tarefaController = TextEditingController();
  TarefaRepository _tarefaRepository = TarefaRepository();
  List<Tarefa> listTarefa = [];

  void _adicionarTarefa() {
    setState(() {
      Tarefa tarefa = Tarefa(nome: tarefaController.text);
      listTarefa.add(tarefa);
      tarefaController.text = "";
      // _tarefaRepository.salvarLista(listTarefa); // <- Não funciona no WEB
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Super Lista de Tarefas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tarefaController,
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _adicionarTarefa,
                  child: Text("Add"),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: listTarefa.length, itemBuilder: construirItem)),
          ],
        ),
      ),
    );
  }

  Widget construirItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(listTarefa[index].getNome()!),
        value: listTarefa[index].getConcluido(),
        onChanged: (checked) {
          setState(() {
            listTarefa[index].setConcluido(checked!);
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          listTarefa.removeAt(index);
        });
      },
    );
  }
}

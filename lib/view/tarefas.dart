import 'package:flutter/material.dart';
import 'package:atividade_lista_banco/model/db_banco.dart'; 

class Tarefas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TarefasScreen(); // Apenas retorna a tela de Tarefas
  }
}

class TarefasScreen extends StatefulWidget {
  @override
  _TarefasScreenState createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  List<Map<String, dynamic>> tarefas = [];

  @override
  void initState() {
    super.initState();
    _carregaTarefa();
  }

  // Carregar tarefas do banco de dados
  Future<void> _carregaTarefa() async {
    final tarefaList = await Bd.instance.getTarefa(); // Chama o método gettarefas
    setState(() {
      tarefas = tarefaList;
    });
  }

  // Inserir um novo pedido e atualizar a lista
  Future<void> criarTafera(String nome, String descricao) async {
    await Bd.instance.criarTafera(nome, descricao); // Insere o pedido
    _carregaTarefa(); // Atualiza a lista de tarefas
  }

  // Atualizar um pedido
  Future<void> updateTarefa(int id, String nome, String descricao) async {
    await Bd.instance.updateTarefa(id, nome,  descricao); // Atualiza o pedido
    _carregaTarefa(); // Atualiza a lista de tarefas
  }

  // Excluir um pedido
  Future<void> deleteTarefa(int id) async {
    await Bd.instance.deleteTarefa(id); // Exclui o pedido
    _carregaTarefa(); // Atualiza a lista de tarefas
  }

  // Método para abrir o diálogo de edição
  void _showEditDialog(BuildContext context, int id, String nome, String descricao) {
    TextEditingController nomeController = TextEditingController(text: nome);
    TextEditingController descricaoController = TextEditingController(text: descricao);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atualizar Pedido"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Tarefa'),
              ),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição Tarefa 1'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Atualizar"),
              onPressed: () {
                updateTarefa(id, nomeController.text, descricaoController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tarefas"),
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tarefas[index]['prato']),
            subtitle: Text('Data: ${tarefas[index]['data']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showEditDialog(
                    context,
                    tarefas[index]['id'],
                    tarefas[index]['prato'],
                    tarefas[index]['data'],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteTarefa(tarefas[index]['id']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(
          child: Text(
            'Lista de Tarefas',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // Título e Subtítulo
              title:  Text(
                  'Tarefa 1',
                  style: TextStyle(color: Colors.white),
                ),
              subtitle: Text(
                  'Descrição Tarefa 1',
                  style: TextStyle(color: Colors.white),
                ),
              tileColor: Colors.blueGrey,
              // Adiciona os ícones no final usando Row
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // Para não ocupar todo o espaço
                children: [
                  GestureDetector(
                    child: Icon(Icons.edit, color: Colors.white),
                    onTap: () {
                      print('Editar Tarefa 1');
                    },
                  ),
                  SizedBox(width: 10), // Espaçamento entre os ícones
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.white),
                    onTap: () {
                      print('Excluir Tarefa 1');
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // Título e Subtítulo
              title: Text(
                  'Tarefa 2',
                  style: TextStyle(color: Colors.white),
                ),
              subtitle: Text(
                  'Descrição Tarefa 2',
                  style: TextStyle(color: Colors.white),
                ),
              tileColor: Colors.blueGrey,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(Icons.edit, color: Colors.white),
                    onTap: () {
                      print('Editar Tarefa 2');
                    },
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.white),
                    onTap: () {
                      print('Excluir Tarefa 2');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

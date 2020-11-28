import 'package:cadastro_tarefas/model/tarefa.dart';
import 'package:flutter/material.dart';

class ListaTarefasPage extends StatefulWidget {
  @override
  _ListaTarefasPageState createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';

  final _tarefas = [
    Tarefa(id: 1, descricao: 'Fazer exercicio 1', prazo: DateTime(2020, 10, 1))
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
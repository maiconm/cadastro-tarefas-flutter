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
  int _ultimoId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirForm,
        tooltip: 'Nova Tarefa',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _criarAppBar() {
    return AppBar(
      title: Text('tarefas'),
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: _abrirPaginaFiltro,
        ),
      ],
    );
  }

  Widget _criarBody() {
    if (_tarefas.isEmpty) {
      return Center(
        child: Text('Nenhuma tarefa cadastrada',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ))
      );
    }

    return ListView.separated(
      itemCount: _tarefas.length,
      itemBuilder: (BuildContext context, int index) {
        final tarefa = _tarefas[index];
        return PopupMenuButton(
          child: ListTile(
            title: Text('${tarefa.id} - ${tarefa.descricao}'),
            subtitle: Text('${tarefa.prazoFormatado}'),
          ),
          itemBuilder: _criarItensMenuPopup,
          onSelected: (String valorSelecionado) {
            if (valorSelecionado == ACAO_EDITAR) {
              _abrirForm();
            } else {
              _excluir();
            }
          }
        );
      },
      separatorBuilder: (_, __) => Divider(),
    );
  }

  List<PopupMenuEntry<String>> _criarItensMenuPopup(BuildContext context) {
    return [
      PopupMenuItem(
        value: ACAO_EDITAR,
        child: Row(
          children: [
            Icon(Icons.edit, color: Colors.green),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Editar'),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: ACAO_EDITAR,
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Excluir'),
            )
          ],
        ),
      )
    ];
  }

  void _abrirForm() {
    // TODO
  }

  void _excluir() {
    // TODO
  }

  void _abrirPaginaFiltro() {
    // TODO
  }
}
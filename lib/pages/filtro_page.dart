
import 'package:cadastro_tarefas/model/tarefa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroPage extends StatefulWidget {
  static const ROUTE_NAME = '/filtro';
  static const CHAVE_CAMPO_ORDENACAO = 'campoOrdenacao';
  static const CHAVE_USAR_ORDEM_DECRESCENTE = 'usarOrdemDecrescente';
  static const CHAVE_FILTRO_DESCRICAO = 'filtroDescricao';

  @override
  _FiltroPageState createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage> {
  final campos = {
    Tarefa.CAMPO_ID: 'Codigo',
    Tarefa.CAMPO_DESCRICAO: 'Descricao',
    Tarefa.CAMPO_PRAZO: 'Prazo',
  };
  SharedPreferences _prefs;
  final _descricaoController = TextEditingController();
  String _campoOrdenacao = Tarefa.CAMPO_ID;
  bool _usarOrdemDecrescente = false;
  bool _alterouValores = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      setState(() {
        _campoOrdenacao = _prefs.getString(FiltroPage.CHAVE_CAMPO_ORDENACAO) ?? Tarefa.CAMPO_ID;
        _usarOrdemDecrescente = _prefs.getBool(FiltroPage.CHAVE_USAR_ORDEM_DECRESCENTE) ?? false;
        _descricaoController.text = _prefs.getString(FiltroPage.CHAVE_FILTRO_DESCRICAO) ?? '';
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      appBar: AppBar( title: Text('Filtro e Ordenação'),),
      body: _criarBody(),
    ),
    onWillPop: _onVoltarClick,
    );
  }

  Widget _criarBody() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10), child: Text('Campo para ordenação'),
        ),
        for (final campo in campos.keys)
          Row(
            children: [
              Radio(
                value: campo,
                groupValue: _campoOrdenacao,
                onChanged: _onCampoOrdenacaoChanged,
              ),
              Text(campos[campo]),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _usarOrdemDecrescente,
                onChanged: _onUsarOrdemDecrescenteChange,
              ),
              Text('Usar ordem decrescente'),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Descrição começa com',),
              // controller: _filtroDescricaoController,
              onChanged: _onFiltroDescricaoChange,
            ),
          ),
      ],
    );
  }

  _lerPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
    
  }

  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;
  }

  void _onCampoOrdenacaoChanged(String valor) {
    _prefs.setString(FiltroPage.CHAVE_CAMPO_ORDENACAO, valor);
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = valor;
    });
  }

  void _onUsarOrdemDecrescenteChange(bool valor) {
    _prefs.setBool(FiltroPage.CHAVE_USAR_ORDEM_DECRESCENTE, valor);
    _alterouValores = true;
    setState(() {
      _usarOrdemDecrescente = valor;
    });
  }

  void _onFiltroDescricaoChange(String valor) {
    _prefs.setString(FiltroPage.CHAVE_FILTRO_DESCRICAO, valor);
    _alterouValores = true;
  }
}

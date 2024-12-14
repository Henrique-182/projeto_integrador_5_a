import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:projeto_integrador_5_a/db.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();  
}

class _MainPageState extends State<MainPage> {

  List<Map<String, dynamic>> _contatosList = [];
  
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _refreshContatos() async {
    final data = await TBContato.all();
    setState(() {
      _contatosList = data;
    });
  }

  @override 
  void initState() {
    super.initState();
    _refreshContatos();
  }

  Future<void> _insert() async {
    await TBContato.insert(_nomeController.text, _telefoneController.text, _emailController.text);
    _refreshContatos();
  }

  Future<void> _update(int id) async {
    await TBContato.update(id, _nomeController.text, _telefoneController.text, _emailController.text);
    _refreshContatos();
  }

  void _deleteById(int id) async {
    await TBContato.delete(id);
    ScaffoldMessenger
      .of(context)
      .showSnackBar(
        const SnackBar(
          content: Text("Contato excluído"),
          backgroundColor: Colors.redAccent,
        )
      );
    _refreshContatos();
  }

  void mostraFormularioRodape(int? id) async {

    if (id != null) {
      final contato = _contatosList.firstWhere((c) => c['id'] == id);
      _nomeController.text = contato['nome'];
      _telefoneController.text = contato['telefone'];
      _emailController.text = contato['email'];
    }

    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome",
                prefixIcon: Icon(Icons.abc)
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Celular',
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.smartphone)
              ),
              inputFormatters: [
                MaskedInputFormatter('(##) #####-####')
              ]
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                prefixIcon: Icon(Icons.email)
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id != null) {
                    await _update(id!);
                  } else {
                    await _insert();
                  }

                  _nomeController.text = '';
                  _telefoneController.text = '';
                  _emailController.text = '';
                  Navigator.of(context).pop();
                }, 
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Incluir contato"  : "Alterar contato",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ),
            )
          ]    
        )
      ),
      elevation: 5,
      isScrollControlled: true
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: Text("Projeto Integrador V-B"),
      ),
      body: _contatosList.isEmpty
      ? Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.no_accounts),
            Text('Sem contatos salvos')
          ],
        ),
      )
      : ListView.builder(
        itemCount: _contatosList.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(15),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "${index+1}# ${_contatosList[index]['nome']}",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            subtitle: Text(
              "${_contatosList[index]['telefone']} \n ${_contatosList[index]['email']}"
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    mostraFormularioRodape(_contatosList[index]['id']);
                  }, 
                  icon: Icon(
                    Icons.edit,
                    color: Colors.indigoAccent,
                  )
                ),
                IconButton(
                  onPressed: () {
                    _deleteById(_contatosList[index]['id']);
                  }, 
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  )
                )
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mostraFormularioRodape(null),
        child: Icon(Icons.add),
      ), 
    );
  }  
}
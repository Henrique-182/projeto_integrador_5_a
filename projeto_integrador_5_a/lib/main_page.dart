import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();  
}

class _MainPageState extends State<MainPage> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void mostraFormularioRodape(int? id) async {

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

                  Navigator.of(context).pop();
                }, 
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Incluir contato",
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
      body: Container(
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
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () => mostraFormularioRodape(null),
        child: Icon(Icons.add),
      ), 
    );
  }  
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas_app/controles/autentificacao.dart';
import 'package:tarefas_app/telas/inicio.dart';
import 'package:tarefas_app/telas/login.dart';

class Authcheck extends StatefulWidget {
  Authcheck({Key? key}) : super(key: key);

  @override
  _AuthcheckState createState() => _AuthcheckState();

}

class _AuthcheckState extends State<Authcheck>{
  @override
  Widget build(BuildContext context){
    autentificacao auth = Provider.of<autentificacao>(context);

    if(auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return Login();
    else 
      return HomePageteste();
  }


  loading(){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
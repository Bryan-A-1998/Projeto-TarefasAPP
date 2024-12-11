import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class authExeption implements Exception{
    String msg;
    authExeption(this.msg);
}
class autentificacao extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  autentificacao(){
    _authCheck();
  }
  
  _authCheck(){
    _auth.authStateChanges().listen((User? user) { 
    usuario = (user == null) ? null : user;
    isLoading = false;
    notifyListeners();
    });
  }
  _getUser(){
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha)async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser(); 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw authExeption('a senha é muito fraca');
      } else if (e.code == 'email-already-in-use'){
        throw authExeption('esse email ja esta cadastrado!');
      }
    }
  }

  login(String email, String senha)async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser(); 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw authExeption('Email não encontrado, cadastre-se');
      } else if (e.code == 'wrong-password'){
        throw authExeption('Senha incorreta, tente novamente');
      }
    }
  }

  Logout()async{
    await _auth.signOut();
    _getUser();
  }
  
  }
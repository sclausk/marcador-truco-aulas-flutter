/*
[x] Não deixar que seja possível ficar com pontos negativos ao clicar em (-1) e também não pode ultrapassar 12 pontos.
[x] Permitir de alguma forma que a partida seja reiniciada, sem zerar o número de vitórias
[x] Transformar o AlertDialog em modal para que somente desapareça da tela ao clicar em CANCEL ou OK.
[ ] Trocar os nomes dos usuários ao clicar em cima do nome.
[x] Exibir uma notificação da mão de ferro.
[x] Instale o plugin Screen e adicione um código para deixar a tela sempre ativa enquanto joga.
*/

import 'package:flutter/material.dart';
import 'package:marcador_truco/views/home_page.dart';
import 'package:screen/screen.dart';

void main() {
  Screen.keepOn(true);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marcador de Truco',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: HomePage(),
    ),

  );
}

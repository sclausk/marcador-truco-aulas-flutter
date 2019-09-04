import 'package:flutter/material.dart';
import 'package:marcador_truco/models/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _playerOne = Player(name: 'Nós', score: 0, victories: 0);
  var _playerTwo = Player(name: 'Elas', score: 0, victories: 0);
  
  void _resetScore(Player player, bool resetScore) {
    setState(() {
      player.score = resetScore ? 0 : player.victories;
      player.score = 0;
    });
  }

void _resetVictories(Player player,  bool resetVictories) {
  setState(() {
   player.score = 0;
   player.victories = resetVictories ? 0 :player.victories;
  });
}
  void _resetVictoriesAll(bool resetVictories) {
    _resetVictories(_playerOne, resetVictories);
    _resetVictories(_playerTwo, resetVictories);
  }

  void _resetScoreAll(bool resetScore) {
    _resetScore(_playerOne, resetScore);
    _resetScore(_playerTwo, resetScore);
  }

  @override
  void initState() {
    super.initState();
    _resetScoreAll(true);
  }

  void initSecondState() {
    super.initState();
    _resetVictoriesAll(true);
  }


  Widget _showPlayerName(String name) {
    return Text(
      name.toUpperCase(),
      style: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w500, color: Colors.black87),
    );
  }

  Widget _showPlayerVictories(int victories) {
    return Text(
      'vitórias ( $victories )',
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
    );
  }

  Widget _showPlayerScore(int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 52.0),
      child: Text(
        '$score',
        style: TextStyle(fontSize: 130.0),
      ),
    );
  }

  Widget _buildRoundedButton({String label, String text, Color color, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          height: 52.0,
          width: 52.0,
          color: color,
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
  

  Widget _showPlayerScoreButtons(Player player) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildRoundedButton(
            label: '-1',
            color: Colors.black87.withOpacity(0.25),
            onTap: () {
              setState(() {
                player.score--;
              if (player.score < 0 ) {
                player.score++;
              }   
              });
            }),
        _buildRoundedButton(
            label: '+1',
            color: Colors.redAccent,
            onTap: () {
              setState(() {
                player.score++;
              if (player.score > 12) {
                player.score--;
              }
              });
                if ((_playerOne.score== 11) && (_playerTwo.score == 11)) 
                {
                  _showAlertDialog(
                    title: 'Mão de Ferro',
                    message: 'Mão de Onze Especial',
                    onCancel: () {
                      setState(() {
                        player.score--;
                      });
                    },
                    );
                }
                else if (player.score == 12) 
                { 
                  _showAlertDialog(
                    title: 'Fim de jogo', 
                    message: 'Deseja jogar outra partida?',
                    onCancel: () {
                      setState(() {
                        player.score--;
                      });}, 
                    onConfirm: () {
                  setState(() {
                    player.victories++;
                    _resetScoreAll(false);
                  });
                });
                }
              }
            ),
            _buildRoundedButton(
              label: '+3',
              color: Colors.black54.withOpacity(0.75),
              onTap: () {
                setState(() {
                  player.score+=3;
                    if (player.score >12) {
                      player.score-=3;
                  }
                });
                 if ((_playerOne.score== 11) && (_playerTwo.score == 11)) 
                {
                  _showAlertDialog(
                    title: 'Mão de Ferro',
                    message: 'Mão de Onze Especial',
                    onCancel: () {
                      setState(() {
                        player.score--;
                      });
                    },
                    );
                }
                else if (player.score == 12) 
                { 
                  _showAlertDialog(
                    title: 'Fim de jogo', 
                    message: 'Deseja jogar outra partida?',
                    onCancel: () {
                      setState(() {
                        player.score--;
                      });}, 
                    onConfirm: () {
                  setState(() {
                    player.victories++;
                    _resetScoreAll(false);
                  });
                });
                }
              })
      ],
    );
  }

  Widget _showAppBar() {
    return AppBar(
        title: Text("Marcador de Pontos (Truco!)"),
        actions: <Widget>[
    IconButton(
    icon: Icon(Icons.redo),
    onPressed: () {
    _showAlertDialog(
    title: 'Reiniciar pontuação',
    message: 'Essa ação zera a pontuação da partida!',
    onConfirm: (){
    _resetScoreAll(true);
    });
    },
    ), 
    IconButton(
      icon: Icon(Icons.refresh),
      onPressed: (){
      _showAlertDialog(
        title: 'Reiniciar partida',
        message: 'Essa ação zera toda a partida!',
        onConfirm: (){
          _resetVictoriesAll(true);
        });
      },)
    ]
    );
  }

Widget _showBoard() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _showBoardPlayer(_playerOne),
      _showBoardPlayer(_playerTwo),
    ],
  );
}

Widget _showBoardPlayer(Player player) {
  return Expanded(
    flex: 1,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _showPlayerName(player.name),
        _showPlayerScore(player.score),
        _showPlayerVictories(player.victories),
        _showPlayerScoreButtons(player),

      ],
    ),
  );
}

void _showAlertDialog(
    {String title, String message, Function onCancel, Function onConfirm, bool barrierDismissible}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                child: Text("Não"), 
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                }),
            FlatButton(
                child: Text("Ok"), 
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                }),
          ],
        );
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar(),
      body: _showBoard(),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return null;
  }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../LocalDB/carta.dart';
import '../LocalDB/mesa.dart';

class Tablero extends StatefulWidget {
  final Function() notifyParent;
  const Tablero({this.notifyParent});

  @override
  _TableroState createState() => _TableroState();
}

class _TableroState extends State<Tablero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(Provider.of<VisibleMesa>(context).getCant().toString()),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: CupertinoColors.white,
                semanticLabel: "Reiniciar Tablero Actual",
              ),
              onPressed: () {
                MesaTotal mesa = Provider.of<MesaTotal>(context, listen: false);
                VisibleMesa visible =
                    Provider.of<VisibleMesa>(context, listen: false);
                mesa.addElementsOf(visible.getMesa());
                visible.deleteElements();
                widget.notifyParent();
              },
            ),
          ]),
      body: Consumer<VisibleMesa>(builder: (context, visible, _) {
        return Center(
          child: GestureDetector(
            onTap: () {
              widget.notifyParent();
            },
            child: Stack(
              alignment: Alignment.center,
              children: visible
                  .getMesa()
                  .map((Carta c) => c.widget(visible, context))
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';

class BottomNavigationLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final void Function(int) onItemTapped;

  const BottomNavigationLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  State<BottomNavigationLayout> createState() => _BottomNavigationLayoutState();
}

class _BottomNavigationLayoutState extends State<BottomNavigationLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff18202b), Color(0xFF090C11)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BottomAppBar(
              color: Colors.transparent,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.dashboard,
                      color: widget.currentIndex == 0
                          ? Colors.amber
                          : Colors.white,
                    ),
                    onPressed: () => widget.onItemTapped(0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.task,
                      color: widget.currentIndex == 1
                          ? Colors.amber
                          : Colors.white,
                    ),
                    onPressed: () => widget.onItemTapped(1),
                  ),
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.lightBlue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_circle_sharp),
                      color: Colors.white,
                      onPressed: () {
                        // Exibir o pop-up
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Ação"),
                              content: const Text("Você clicou no botão central!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Fechar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.list,
                      color: widget.currentIndex == 2
                          ? Colors.amber
                          : Colors.white,
                    ),
                    onPressed: () => widget.onItemTapped(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.list,
                      color: widget.currentIndex == 2
                          ? Colors.amber
                          : Colors.white,
                    ),
                    onPressed: () => widget.onItemTapped(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

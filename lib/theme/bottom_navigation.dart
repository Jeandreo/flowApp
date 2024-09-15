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
              color: Colors.black26, // Cor da sombra
              spreadRadius: 1, // Quanto a sombra vai se espalhar
              blurRadius: 10, // Quanto suave será o desfoque da sombra
              offset: Offset(0, -4), // Posição da sombra (horizontal, vertical)
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
                      onPressed: () {},
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

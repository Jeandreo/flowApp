// lib/bottom_navigation_layout.dart
import 'package:flutter/material.dart';
import 'add_options_modal.dart';

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
  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddOptionsModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(20, 0, 0, 0),
              spreadRadius: 1,
              blurRadius: 15,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BottomAppBar(
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.dashboard,
                      size: 25,
                      color: widget.currentIndex == 0
                          ? Color.fromARGB(255, 0, 171, 209)
                          : Color.fromARGB(255, 58, 75, 114),
                    ),
                    onPressed: () => widget.onItemTapped(0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.task,
                      size: 25,
                      color: widget.currentIndex == 1
                          ? Color.fromARGB(255, 0, 108, 209)
                          : Color.fromARGB(255, 58, 75, 114),
                    ),
                    onPressed: () => widget.onItemTapped(1),
                  ),
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 118, 197, 0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.add_circle_sharp, size: 30, color: Colors.white),
                        onPressed: _showAddOptions,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.list,
                      size: 25,
                      color: widget.currentIndex == 2
                          ? Color.fromARGB(255, 0, 108, 209)
                          : Color.fromARGB(255, 58, 75, 114),
                    ),
                    onPressed: () => widget.onItemTapped(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                      color: widget.currentIndex == 3
                          ? Color.fromARGB(255, 0, 108, 209)
                          : Color.fromARGB(255, 58, 75, 114),
                    ),
                    onPressed: () => widget.onItemTapped(3),
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

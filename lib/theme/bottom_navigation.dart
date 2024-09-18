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
  void _showAddOptions() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador de arrastar
            Container(
              height: 5,
              width: 40,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
              child: Column(
                children: [
                  Text(
                    'O que deseja adicionar?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  _buildOptionButton(Icons.add, 'receita', Colors.green),
                  SizedBox(height: 10),
                  _buildOptionButton(Icons.remove, 'despesa', Colors.red),
                  SizedBox(height: 10),
                  _buildOptionButton(Icons.transfer_within_a_station, 'transferência', Colors.blue),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}



  Widget _buildOptionButton(IconData icon, String label, Color color) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        minimumSize: Size(double.infinity, 60),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: () {
        // Adicione a ação desejada aqui
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                color: color, fontSize: 16), // Ajusta o tamanho da fonte
          ),
          Icon(
            icon,
            color: color,
            size: 24, // Aumenta o tamanho do ícone
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Fundo branco
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
                        icon: const Icon(Icons.add_circle_sharp,
                            size: 30, color: Colors.white),
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
                      color: widget.currentIndex == 2
                          ? Color.fromARGB(255, 0, 108, 209)
                          : Color.fromARGB(255, 58, 75, 114),
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

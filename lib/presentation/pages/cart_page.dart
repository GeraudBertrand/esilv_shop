import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Shop'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
                children: [
                  Text("Votre panier total est de "),
                  Spacer(),
                  Text("0.00€", style: TextStyle(fontWeight: FontWeight.bold))
                ]
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Votre panier est vide"),
                Icon(Icons.add)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

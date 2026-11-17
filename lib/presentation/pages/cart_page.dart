import 'package:esilv_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(cartProvider);

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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Text("Votre panier total est de "),
                const Spacer(),
                Text(
                  ref.read(cartProvider.notifier).priceInEuros,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
              ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Votre panier est vide"),
                  Icon(Icons.add),
                  ],
                ),
              )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return ListTile(
                  title: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    product.getPrice(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Image.network(
                    product.image,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                  trailing: TextButton(
                    onPressed: () =>
                        ref.read(cartProvider.notifier).remove(product),
                    child: Text("Retirer".toUpperCase()),
                  ),
                );
              },
            ),
          ),
          if (products.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.push('/command'),
                  child: const Text("Commander"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

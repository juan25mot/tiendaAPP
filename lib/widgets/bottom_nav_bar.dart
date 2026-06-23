// lib/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget reutilizable para la barra de navegación inferior con badge
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final int cartItemCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.cartItemCount,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text(
              '$cartItemCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            isLabelVisible: cartItemCount > 0,
            child: const Icon(Icons.shopping_cart),
          ),
          label: 'Carrito',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/favorites');
            break;
          case 2:
            context.go('/cart');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
    );
  }
}
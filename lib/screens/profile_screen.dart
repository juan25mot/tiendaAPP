import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/bottom_nav_bar.dart'; // ← AGREGAR

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificaciones = true;
  bool _ofertas = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF01579B),
                child: Icon(Icons.person, size: 48, color: Colors.white),
              ),
            ),
          ),
          const ListTile(
            title: Text('usuario@demo.com'),
            leading: Icon(Icons.email_outlined),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Text(
              'PREFERENCIAS',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibir alertas de pedidos'),
                  value: _notificaciones,
                  onChanged: (v) => setState(() => _notificaciones = v),
                ),
                SwitchListTile(
                  title: const Text('Ofertas y promociones'),
                  value: _ofertas,
                  onChanged: (v) => setState(() => _ofertas = v),
                ),
                SwitchListTile(
                  title: const Text('Modo oscuro'),
                  value: isDark,
                  onChanged: (v) => themeProvider.toggleTheme(),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar sesión',
                style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Cerrar sesión'),
                  content: const Text('¿Estás seguro que deseas salir?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartProvider>().clear();
                        Navigator.pop(context);
                        context.go('/login');
                      },
                      child: const Text('Salir'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // ✅ USAR BottomNavBar
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        cartItemCount: cart.itemCount,
      ),
    );
  }
}
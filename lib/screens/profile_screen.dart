import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificaciones = true;
  bool _ofertas = false;
  bool _modoOscuro = false;

  @override
  Widget build(BuildContext context) {
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
            value: _modoOscuro,
            onChanged: (v) => setState(() => _modoOscuro = v),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar sesión',
                style: TextStyle(color: Colors.red)),
            onTap: () {
              context.read<CartProvider>().clear();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
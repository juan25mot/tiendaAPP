import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/bottom_nav_bar.dart';
import '../data/products_data.dart';
import '../models/product.dart';
import '../utils/formatters.dart';

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
    final favoriteProvider = context.watch<FavoriteProvider>();

    // ✅ Obtener los productos favoritos en tiempo real
    final favoriteProducts =
        kProducts
            .where((p) => favoriteProvider.favoriteIds.contains(p.id))
            .toList();

    final favoriteCount = favoriteProducts.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil'), centerTitle: true),
      body: ListView(
        children: [
          // ✅ Header con favoritos funcionales
          _buildHeader(
            context,
            favoriteCount: favoriteCount,
            favoriteProducts: favoriteProducts,
          ),

          const Divider(height: 0),

          // ✅ Sección de favoritos (solo si tiene favoritos)
          if (favoriteProducts.isNotEmpty) ...[
            _buildFavoriteSection(context, favoriteProducts),
          ],

          // ✅ Preferencias
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              'PREFERENCIAS',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibir alertas de pedidos'),
                  value: _notificaciones,
                  onChanged: (v) => setState(() => _notificaciones = v),
                ),
                const Divider(height: 1, indent: 16),
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: const Text('Ofertas y promociones'),
                  value: _ofertas,
                  onChanged: (v) => setState(() => _ofertas = v),
                ),
                const Divider(height: 1, indent: 16),
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: const Text('Modo oscuro'),
                  value: isDark,
                  onChanged: (v) => themeProvider.toggleTheme(),
                ),
              ],
            ),
          ),

          // ✅ Sección de cuenta
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              'CUENTA',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(Icons.history, color: Colors.blue),
                  title: const Text('Historial de pedidos'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 16),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: const Icon(Icons.help_outline, color: Colors.orange),
                  title: const Text('Ayuda'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ],
            ),
          ),

          // ✅ Botón de cerrar sesión
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text('Cerrar sesión'),
                          content: const Text(
                            '¿Estás seguro que deseas salir?',
                          ),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Salir'),
                            ),
                          ],
                        ),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        cartItemCount: cart.itemCount,
      ),
    );
  }

  // ✅ Header con favoritos en tiempo real
  Widget _buildHeader(
    BuildContext context, {
    required int favoriteCount,
    required List<Product> favoriteProducts,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF01579B),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          // Email
          Text(
            'usuario@demo.com',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),

          // ✅ Chips con estadísticas funcionales
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoChip('12 pedidos', Icons.shopping_bag_outlined),
              const SizedBox(width: 12),
              // ✅ Chip de favoritos clickable
              GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de favoritos
                  context.go('/favorites');
                },
                child: _buildInfoChip(
                  '$favoriteCount favoritos',
                  Icons.favorite_border,
                  isClickable: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ Chip para estadísticas (ahora con opción clickable)
  Widget _buildInfoChip(
    String label,
    IconData icon, {
    bool isClickable = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isClickable ? Colors.grey.shade300 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: isClickable ? Border.all(color: Colors.grey.shade400) : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color:
                isClickable
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade700,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color:
                  isClickable
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade700,
              fontWeight: isClickable ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Sección de favoritos (mini lista en el perfil)
  Widget _buildFavoriteSection(
    BuildContext context,
    List<Product> favoriteProducts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TUS FAVORITOS',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Ver todos →',
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount:
                favoriteProducts.length > 5 ? 5 : favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return _buildFavoriteItem(context, product);
            },
          ),
        ),
      ],
    );
  }

  // ✅ Item de favorito individual (mini card horizontal)
  Widget _buildFavoriteItem(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        // Navegar al detalle del producto
        context.go('/product/${product.id}');
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                product.imageUrl,
                height: 70,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      height: 70,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatPrice(product.price),
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/products_data.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'Todos';

  List<Product> get _filteredProducts {
    return kProducts.where((p) {
      final matchesSearch = p.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Todos' ||
          p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SurfShop'),
        // ✅ ELIMINADOS todos los botones del AppBar
        // Solo queda el título
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _searchQuery = '';
            _selectedCategory = 'Todos';
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de búsqueda
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar productos...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
              const SizedBox(height: 16),

              // Banner carrusel
              const _BannerCarousel(),
              const SizedBox(height: 16),

              // Filtros de categoría
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: kCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = kCategories[index];
                    final isSelected = cat == _selectedCategory;
                    return FilterChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => _selectedCategory = cat);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Grid de productos
              if (_filteredProducts.isEmpty)
                const Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Sin resultados'),
                    ],
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () => context.go('/product/${product.id}'),
                    );
                  },
                ),

              // Footer
              const SizedBox(height: 40),
              _buildFooter(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        cartItemCount: cart.itemCount,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Text(
            'SurfShop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Todo para tu aventura en el mar 🌊',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook, size: 24),
                onPressed: () {},
                color: Colors.grey[600],
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram, size: 24),
                onPressed: () {},
                color: Colors.grey[600],
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.youtube, size: 24),
                onPressed: () {},
                color: Colors.grey[600],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '© 2026 SurfShop. Todos los derechos reservados.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// ============================================================
//  🧩 Widget del carrusel de banners
// ============================================================
class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _controller = PageController();
  int _current = 0;

  final List<String> _banners = [
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    'https://theindianface.com/cdn/shop/articles/2_5bb62d88-2795-4d66-b0a2-107590e6569c.jpg?v=1650970753',
    'https://iso.500px.com/wp-content/uploads/2015/01/re-magic.jpg',
    'https://ichef.bbci.co.uk/ace/ws/640/amz/worldservice/live/assets/images/2015/08/25/150825150249_surfing_640x360_epa_nocredit.jpg.webp',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/30/dc/f2/2a/caption.jpg?w=500&h=400&s=1',
  ];

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return false;
      if (_controller.hasClients) {
        final next = (_current + 1) % _banners.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                _banners[i],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            width: _current == i ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _current == i
                  ? theme.primaryColor
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          )),
        ),
      ],
    );
  }
}


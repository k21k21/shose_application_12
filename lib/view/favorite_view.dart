import 'package:flutter/material.dart';

// Model to hold the data for each favorite item
class FavoriteItem {
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final int reviewCount;
  final int stockLeft;

  const FavoriteItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.stockLeft,
  });
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  // Static list of favorite shoe items with updated images
  final List<FavoriteItem> favoriteItems = const [
    FavoriteItem(
      imageUrl: 'https://lh5.googleusercontent.com/proxy/srTVSxH0BfetxWH_e4iqnWTcTi-QCUbL7TGnmhQtBl2gW0LuJLlNlzzimWlHNU_mpf4l4EJLh4iDjyaiwjVMsKa_quNip65emqCQxZlo1QFs08ffQ75gsOmdqO619kNsWVopL-BdPUrmHWWQ5QRQKYNHOlm7',
      name: 'Nike Air Jordan 1',
      price: 135.00,
      rating: 4.8,
      reviewCount: 310,
      stockLeft: 15,
    ),
    FavoriteItem(
      imageUrl: 'https://images.stockx.com/360/Nike-Air-Force-1-Low-White-07/Images/Nike-Air-Force-1-Low-White-07/Lv2/img01.jpg?w=480&q=60&dpr=1&updated_at=1635275427&h=320',
      name: 'Nike Air Force 1 Low',
      price: 145.00,
      rating: 4.6,
      reviewCount: 250,
      stockLeft: 10,
    ),
    FavoriteItem(
      imageUrl: 'https://images.stockx.com/360/Nike-Air-Force-1-Low-White-07/Images/Nike-Air-Force-1-Low-White-07/Lv2/img01.jpg?w=480&q=60&dpr=1&updated_at=1635275427&h=320',
      name: 'Nike Air Force 1 Low',
      price: 105.00,
      rating: 4.5,
      reviewCount: 420,
      stockLeft: 12,
    ),
    FavoriteItem(
      imageUrl: 'https://lh5.googleusercontent.com/proxy/srTVSxH0BfetxWH_e4iqnWTcTi-QCUbL7TGnmhQtBl2gW0LuJLlNlzzimWlHNU_mpf4l4EJLh4iDjyaiwjVMsKa_quNip65emqCQxZlo1QFs08ffQ75gsOmdqO619kNsWVopL-BdPUrmHWWQ5QRQKYNHOlm7',
      name: 'Nike Air Force 1 Low',
      price: 94.00,
      rating: 4.7,
      reviewCount: 380,
      stockLeft: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          childAspectRatio: 0.65, // Adjust this ratio to fit your content
          crossAxisSpacing: 12.0, // Horizontal spacing
          mainAxisSpacing: 12.0, // Vertical spacing
        ),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return _buildFavoriteItemCard(favoriteItems[index]);
        },
      ),
    );
  }

  Widget _buildFavoriteItemCard(FavoriteItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    item.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                     boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]
                  ),
                  child: const Icon(Icons.favorite, color: Colors.red, size: 22),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${item.stockLeft} Stocks Left',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4.0),
                    Text(
                      '${item.rating} (${item.reviewCount})',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Shoe {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  Shoe({required this.id, required this.name, required this.price, required this.imageUrl});
}

class ShoeCollection {
  final String id;
  final String title;
  final String subtitle;
  final String coverImage;
  final bool isPinned;
  final List<Shoe> shoes;

  ShoeCollection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coverImage,
    this.isPinned = false,
    required this.shoes,
  });
}
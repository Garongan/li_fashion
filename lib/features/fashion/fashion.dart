class Fashion {
  final String name;
  final String price;
  final String description;
  final String category;
  final String link;
  final String mainImage;
  final String variantImage1;
  final String variantImage2;
  final String variantImage3;
  final String variantImage4;

  const Fashion({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.link,
    required this.mainImage,
    required this.variantImage1,
    required this.variantImage2,
    required this.variantImage3,
    required this.variantImage4,
  });

  factory Fashion.fromSheet(List<dynamic> row) {
    return Fashion(
      name: row[0],
      price: row[1],
      description: row[2],
      category: row[3],
      link: row[4],
      mainImage: row[5],
      variantImage1: row[6],
      variantImage2: row[7],
      variantImage3: row[8],
      variantImage4: row[9],
    );
  }
}

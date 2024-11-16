class Fashion {
  final String name;
  final String price;
  final String description;
  final String category;
  final String link;
  final List<String> image;

  const Fashion(
      {required this.name,
      required this.price,
      required this.description,
      required this.category,
      required this.link,
      required this.image});

  factory Fashion.fromSheet(List<dynamic> row) {
    return Fashion(
        name: row[0],
        price: row[1],
        description: row[2],
        category: row[3],
        link: row[4],
        image: List.of([
          row[5],
          row[6],
          row[7],
          row[8],
          row[9],
        ]));
  }
}

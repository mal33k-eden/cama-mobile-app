class Category {
  final String title;
  final int id;

  Category({required this.id, required this.title});

  static List<Category> getCategories() {
    return <Category>[
      Category(id: 1, title: 'Doctor'),
      Category(id: 2, title: 'Nurse'),
      Category(id: 3, title: 'International Nurse'),
      Category(id: 4, title: 'Support Worker'),
      Category(id: 5, title: 'Snr. Healthcare Assistant'),
      Category(id: 6, title: 'Healthcare Assistant'),
    ];
  }
}

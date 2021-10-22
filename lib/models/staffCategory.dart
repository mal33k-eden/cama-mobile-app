class Category {
  final String title;
  final int id;

  Category({required this.id, required this.title});

  static List<Category> getCategories() {
    return <Category>[
      Category(id: 1, title: 'Doctor'),
      Category(id: 2, title: 'Nurse'),
      Category(id: 3, title: 'Intl-Nurse'),
      Category(id: 4, title: 'Support Worker'),
      Category(id: 5, title: 'Senior Health Care Assistant'),
      Category(id: 6, title: 'Health Care Assistant'),
    ];
  }
}

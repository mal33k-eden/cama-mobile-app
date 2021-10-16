import 'package:cama/models/staffCategory.dart';
import 'package:flutter/material.dart';

class StaffCategory extends StatefulWidget {
  Function categoryUpdater;
  int selectedIndex;
  StaffCategory(
      {Key? key, required this.categoryUpdater, required this.selectedIndex})
      : super(key: key);

  @override
  State<StaffCategory> createState() => _StaffCategoryState();
}

class _StaffCategoryState extends State<StaffCategory> {
  List<Category> _categories = Category.getCategories();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 30,
      scrollable: true,
      title: const Text('Select Your Field'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: _categories
              .map((e) => RadioListTile(
                  title: Text(e.title),
                  value: e.id,
                  groupValue: widget.selectedIndex,
                  onChanged: (val) {
                    setState(() {
                      debugPrint('VAL = $val');
                      widget.selectedIndex = e.id;
                      widget.categoryUpdater(e.title, e.id);
                    });
                  }))
              .toList(),
        ),
      ),
    );
  }
}

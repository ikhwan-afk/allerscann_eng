import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllergyProvider with ChangeNotifier {
  final List<String> availableAllergies = [
    'Gluten',
    'Nuts',
    'Lactose',
    'Seafood',
  ];

  final List<String> _selectedAllergies = [];
  List<String> get selectedAllergies => _selectedAllergies;

  final Map<String, List<String>> allergyChildren = {
    'Gluten': ['Wheat', 'Barley', 'Rye', 'Seitan', 'Flour', 'Cornstarch'],
    'Nuts': ['Peanut', 'Almond', 'Cashew'],
    'Lactose': ['Milk', 'Lactose', 'Cheese', 'Yogurt'],
    'Seafood': ['Shrimp', 'Crab', 'Clam', 'Oyster', 'Squid'],
  };

  bool isSelected(String allergy) {
    return _selectedAllergies.contains(allergy);
  }

  void toggleAllergy(String allergy) {
    if (allergyChildren.containsKey(allergy)) {
      if (isSelected(allergy)) {
        // Remove the parent category and its children
        _selectedAllergies.remove(allergy);
        _selectedAllergies.removeWhere(
          (item) => allergyChildren[allergy]!.contains(item),
        );
      } else {
        // Add the parent category and its children
        _selectedAllergies.add(allergy);
        _selectedAllergies.addAll(
          allergyChildren[allergy]!.where(
            (item) => !_selectedAllergies.contains(item),
          ),
        );
      }
    } else {
      if (isSelected(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
      }
    }

    notifyListeners();
    _saveSelectedAllergies();
  }

  void removeAllergyItem(String item) {
    _selectedAllergies.remove(item);

    // If the removed item is a parent allergy, remove all its children
    if (allergyChildren.containsKey(item)) {
      _selectedAllergies.removeWhere(
        (child) => allergyChildren[item]!.contains(child),
      );
    }

    // If the removed item is a child allergy, check if the parent should be removed
    allergyChildren.forEach((parent, children) {
      if (children.contains(item)) {
        final hasOther = children.any(
          (child) => _selectedAllergies.contains(child),
        );
        if (!hasOther) {
          _selectedAllergies.remove(parent);
        }
      }
    });

    notifyListeners();
    _saveSelectedAllergies();
  }

  Future<void> _saveSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedAllergies', _selectedAllergies);
  }

  Future<void> loadSelectedAllergies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAllergies = prefs.getStringList('selectedAllergies') ?? [];
    _selectedAllergies.clear();
    _selectedAllergies.addAll(savedAllergies);
    notifyListeners();
  }
}

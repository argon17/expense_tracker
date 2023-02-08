import 'dart:math';

import 'package:expense_tracker/config/constants.dart';
import 'package:flutter/material.dart';

enum ExpenseCategory {
  grocery,
  travel,
  foodAndDrinks,
  shopping,
  rent,
  health,
  movies,
  goodWork,
  others,
  utilities,
  books,
  flight
}

class ExpenseCategoryItem {
  final String name;
  final IconData iconData;
  final ExpenseCategory category;
  final Color bgColor = iconColors[Random().nextInt(iconColors.length)];
  ExpenseCategoryItem({
    required this.name,
    required this.iconData,
    required this.category,
  });
}

final List<ExpenseCategoryItem> categoryItems = [
  ExpenseCategoryItem(
    name: "Grocery",
    iconData: Icons.shopping_bag,
    category: ExpenseCategory.grocery,
  ),
  ExpenseCategoryItem(
    name: "Travel",
    iconData: Icons.directions_car_filled,
    category: ExpenseCategory.travel,
  ),
  ExpenseCategoryItem(
    name: "Food & Drinks",
    iconData: Icons.restaurant,
    category: ExpenseCategory.foodAndDrinks,
  ),
  ExpenseCategoryItem(
    name: "Shopping",
    iconData: Icons.shopping_cart,
    category: ExpenseCategory.shopping,
  ),
  ExpenseCategoryItem(
    name: "Rent",
    iconData: Icons.apartment,
    category: ExpenseCategory.rent,
  ),
  ExpenseCategoryItem(
    name: "Health",
    iconData: Icons.health_and_safety,
    category: ExpenseCategory.health,
  ),
  ExpenseCategoryItem(
    name: "Movies",
    iconData: Icons.movie,
    category: ExpenseCategory.movies,
  ),
  ExpenseCategoryItem(
    name: "Good Work",
    iconData: Icons.volunteer_activism,
    category: ExpenseCategory.goodWork,
  ),
  ExpenseCategoryItem(
    name: "Others",
    iconData: Icons.shopping_cart,
    category: ExpenseCategory.others,
  ),
  ExpenseCategoryItem(
    name: "Utilities",
    iconData: Icons.build,
    category: ExpenseCategory.utilities,
  ),
  ExpenseCategoryItem(
    name: "Books",
    iconData: Icons.book,
    category: ExpenseCategory.books,
  ),
  ExpenseCategoryItem(
    name: "Flight",
    iconData: Icons.flight_land,
    category: ExpenseCategory.flight,
  ),
];

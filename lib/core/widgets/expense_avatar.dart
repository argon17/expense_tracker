import 'dart:math';

import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/config/theme.dart';

class ExpenseAvatar extends StatelessWidget {
  final ExpenseCategory category;
  const ExpenseAvatar(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryItem =
        categoryItems.singleWhere((e) => e.category == category);
    return Container(
      padding: const EdgeInsets.all(Insets.sm),
      decoration:
          BoxDecoration(
              color: categoryItem.bgColor,
              shape: BoxShape.circle
          ),
      child: Icon(
        categoryItem.iconData,
        color: Colors.white,
        size: Sizes.s24,
      ),
    );
  }
}

import 'package:expense_tracker/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/utils/expense_category.dart';

import 'package:expense_tracker/core/widgets/expense_avatar.dart';
import 'package:expense_tracker/core/widgets/gap.dart';


class CategoryExpenseListItem extends StatelessWidget {
  const CategoryExpenseListItem(this.categoryExpense, {Key? key}) : super(key: key);
  final CategoryExpense categoryExpense;

  @override
  Widget build(BuildContext context) {

    final categoryItem = categoryItems.singleWhere((e) => e.category == categoryExpense.expenseCategory);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.s12, horizontal: Sizes.s18),
      child: Row(
        children: [
          Row(
            children: [
              ExpenseAvatar(categoryItem.category),
              Gap.md,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryItem.name,
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            "₹ ${categoryExpense.amount}",
          )
        ],
      ),
    );
  }
}

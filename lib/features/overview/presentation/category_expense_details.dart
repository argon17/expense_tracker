import 'package:expense_tracker/core/utils/expense_category.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/expense_avatar.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/widgets/gap.dart';
import 'package:expense_tracker/features/history/presentation/expense_list_item.dart';

class CategoryExpenseDetails extends StatelessWidget {
  final CategoryExpense categoryExpense;
  const CategoryExpenseDetails(this.categoryExpense, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryItem = categoryItems
        .singleWhere((e) => e.category == categoryExpense.expenseCategory);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            color: AppColors.kPrimary500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap.lg,
                IconButton(
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    onPressed: () => {context.pop()},
                    icon: const Icon(Icons.arrow_back)),
                Gap.lg,
                Row(
                  children: [
                    ExpenseAvatar(categoryItem.category),
                    Gap.md,
                    Text(
                      categoryItem.name,
                      style: const TextStyle(fontSize: FontSizes.s32),
                    ),
                  ],
                ),
                Gap.md,
                const Padding(
                  padding: EdgeInsets.only(left: Sizes.s56),
                  child: Text("This month"),
                ),
                Gap.md,
              ],
            ),
          ),
          Expanded(
            // child: SizedBox(
            child: ListView.builder(
              itemCount: categoryExpense.expenseEntities.length,
              itemBuilder: (BuildContext ctx, int ind) {
                return ExpenseListTileItem(
                    categoryExpense.expenseEntities[ind], false);
              },
            ),
            // ),
          ),
        ],
      ),
    );
  }
}

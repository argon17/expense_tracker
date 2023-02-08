import 'package:provider/provider.dart';
import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/data/view_models/expense_view_model.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/gap.dart';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:expense_tracker/core/utils/expense_category.dart';
import 'package:expense_tracker/core/widgets/expense_avatar.dart';
import 'category_expense_details.dart';
import 'detailed_expense.dart';

import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseViewModel = context.watch<ExpenseViewModel>();
    List<ExpenseEntity> expenses =
        expenseViewModel.expenseListEntities.cast<ExpenseEntity>().toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailedExpense()));
        },
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: Column(
              children: [
                Gap.lg,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap.md,
                    const Text(
                      "₹",
                      style: TextStyle(fontSize: FontSizes.s18),
                    ),
                    Gap.md,
                    Text(
                      getCurrentMonthExpense(expenses).toString(),
                      style: const TextStyle(fontSize: FontSizes.s48),
                    ),
                  ],
                ),
                Gap.lg,
                ExpenseList()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExpenseList extends StatelessWidget {
  ExpenseList({Key? key}) : super(key: key);
  final int month = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    ExpenseViewModel expenseViewModel = context.watch<ExpenseViewModel>();
    List<ExpenseEntity> expenses =
        expenseViewModel.expenseListEntities.cast<ExpenseEntity>().toList();
    List<ExpenseEntity> filteredExpenses =
        expenses.where((expense) => expense.createdAt.month == month).toList();
    List<CategoryExpense> categoryExpenses =
        getCategoryExpenses(filteredExpenses);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: Insets.sm),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categoryExpenses.length,
      itemBuilder: (context, i) =>
          getCategoryExpenseListItemWidget(context, categoryExpenses[i]),
    );
  }
}

Widget getCategoryExpenseListItemWidget(
    context, CategoryExpense categoryExpense) {
  final categoryItem = categoryItems
      .singleWhere((e) => e.category == categoryExpense.expenseCategory);
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryExpenseDetails(categoryExpense)));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Sizes.s12, horizontal: Sizes.s18),
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
    ),
  );
}

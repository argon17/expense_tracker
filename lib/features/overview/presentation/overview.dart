import 'package:provider/provider.dart';
import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/data/view_models/expense_view_model.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/gap.dart';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'add_expense.dart';
import 'category_expense_list_item.dart';

import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseViewModel = context.watch<ExpenseViewModel>();
    List<ExpenseEntity> expenses = expenseViewModel.expenseListEntities.cast<ExpenseEntity>().toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpense())
          );
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
    List<ExpenseEntity> expenses = expenseViewModel.expenseListEntities.cast<ExpenseEntity>().toList();
    List<ExpenseEntity> filteredExpenses = expenses.where((expense) => expense.createdAt.month == month).toList();
    List<CategoryExpense> categoryExpenses = getCategoryExpenses(filteredExpenses);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: Insets.sm),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categoryExpenses.length,
      itemBuilder: (context, i) => CategoryExpenseListItem(categoryExpenses[i]),
    );
  }
}

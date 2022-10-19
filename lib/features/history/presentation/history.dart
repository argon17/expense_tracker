import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/core/widgets/gap.dart';

import 'package:expense_tracker/config/constants.dart';

import 'package:expense_tracker/core/utils/utils.dart';

import 'package:expense_tracker/features/history/presentation/collapsable_monthly_expense.dart';
import 'package:provider/provider.dart';

import '../../../core/data/view_models/expense_view_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExpenseViewModel expenseViewModel = context.watch<ExpenseViewModel>();
    List<ExpenseEntity> expenses = expenseViewModel.expenseListEntities.cast<ExpenseEntity>().toList();
    Map<DateTime, List<ExpenseEntity>> monthlyExpensesMap = getMonthlyExpensesMap(expenses);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: Column(
              children: [
                Gap.lg,
                ...monthlyExpensesMap.entries.map((entry){
                  return CollapsableMonthlyExpense(entry.key, entry.value);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}


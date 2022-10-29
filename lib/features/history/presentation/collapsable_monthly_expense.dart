import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:expense_tracker/features/history/presentation/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/utils/utils.dart';


class CollapsableMonthlyExpense extends StatelessWidget {
  final DateTime date;
  final List<ExpenseEntity> expenseEntities;

  const CollapsableMonthlyExpense(this.date, this.expenseEntities, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(getMonthString(date)),
      controlAffinity: ListTileControlAffinity.leading,
      children: expenseEntities.map((expenseEntity) => ExpenseListTileItem(expenseEntity, true)).toList(),
    );
  }
}
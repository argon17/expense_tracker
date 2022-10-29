import 'dart:collection';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:expense_tracker/core/utils/expense_category.dart';
import 'package:intl/intl.dart';


class CategoryExpense {
  final ExpenseCategory expenseCategory;
  final int amount;
  List<ExpenseEntity> expenseEntities;

  CategoryExpense({
    required this.expenseCategory,
    required this.amount,
    required this.expenseEntities,
  });
}

List<CategoryExpense> getCategoryExpenses (List<ExpenseEntity> expenses)  {
  Map<ExpenseCategory, List<ExpenseEntity>> category2Entities = {};
  for(final expense in expenses){
    (category2Entities[expense.category] ??= []).add(expense);
  }
  List<CategoryExpense> categoryExpenses = [];
  category2Entities.forEach((expenseCategory, filteredExpenses) {
    categoryExpenses.add(CategoryExpense(expenseCategory: expenseCategory, amount: getTotalAmount(filteredExpenses), expenseEntities: filteredExpenses));
  });
  categoryExpenses.sort((a, b) => (b.amount.compareTo(a.amount)));
  return categoryExpenses;
}

int getTotalAmount(List<ExpenseEntity> expenses) {
  int totalAmount = 0;
  for(final expense in expenses){
    totalAmount += expense.amount;
  }
  return totalAmount;
}

Map<DateTime, List<ExpenseEntity>> getMonthlyExpensesMap (List<ExpenseEntity> expenses){
  Map<DateTime, List<ExpenseEntity>> monthlyExpensesMap = HashMap();
  for(final expense in expenses){
    DateTime curMonth = DateTime(expense.createdAt.year, expense.createdAt.month);
    if(!monthlyExpensesMap.containsKey(curMonth)){
      monthlyExpensesMap[curMonth] = [];
    }
    monthlyExpensesMap[curMonth]?.add(expense);
  }
  Map<DateTime, List<ExpenseEntity>> sortedMonthlyExpensesMap = Map.fromEntries(
      monthlyExpensesMap.entries.toList()..sort(
              (e1, e2) => e2.key.compareTo(e1.key)
      )
  );
  return sortedMonthlyExpensesMap;
}

int getCurrentMonthExpense(List<ExpenseEntity> expenses){
  int totalExpenses = 0;
  for(final expense in expenses){
    totalExpenses += expense.amount;
  }
  return totalExpenses;
}

String getMonthString(DateTime date){
  final String formattedDate = DateFormat(DateFormat.YEAR_ABBR_MONTH).format(date);
  return formattedDate;
}

String getDayString(DateTime date){
  final String formattedDate = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(date);
  return formattedDate;
}
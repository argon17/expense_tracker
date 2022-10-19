import 'package:expense_tracker/core/utils/expense_category.dart';

class ExpenseEntity {
  final DateTime createdAt;
  final ExpenseCategory category;
  final int amount;
  final String desc;

  ExpenseEntity({
    required this.createdAt,
    required this.category,
    required this.amount,
    required this.desc,
  });

  @override
  String toString() {
    return 'ExpenseEntity(createdAt: $createdAt, category: $category, amount: $amount)';
  }
}

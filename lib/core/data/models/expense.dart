import 'package:expense_tracker/core/utils/expense_category.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final DateTime createdAt;
  
  @HiveField(1)
  final ExpenseCategory category;
  
  @HiveField(2)
  final int amount;
  
  @HiveField(3)
  final String desc;

  ExpenseModel({
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

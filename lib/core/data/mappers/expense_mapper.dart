import '../../domain/entities/expense.dart';
import '../models/expense.dart';

extension ExpenseModelExtension on ExpenseModel {
  ExpenseEntity toEntity() => ExpenseEntity(
    createdAt: createdAt,
    desc: desc,
    amount: amount,
    category: category,
  );
}

extension ExpenseEntityExtension on ExpenseEntity {
  ExpenseModel toModel() => ExpenseModel(
    createdAt: createdAt,
    desc: desc,
    amount: amount,
    category: category,
  );
}

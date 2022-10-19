import 'dart:math';

import 'package:expense_tracker/core/data/mappers/expense_mapper.dart';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/expense.dart';

class ExpenseViewModel extends ChangeNotifier{
  static const String _boxName = 'expenseBox';
  List<ExpenseEntity> _expenseListEntities = [];

  List<ExpenseEntity> get expenseListEntities => _expenseListEntities;

  ExpenseViewModel(){
    getExpenses();
  }

  setUserListModel(List<ExpenseEntity> expenseListModel) {
    _expenseListEntities = expenseListModel;
  }

  getExpenses() async {
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    _expenseListEntities = box.values.map((e) => e.toEntity()).toList();
    notifyListeners();
  }

  addExpense(ExpenseEntity expenseEntity) async{
    _expenseListEntities.add(expenseEntity);
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    await box.add(expenseEntity.toModel());
    notifyListeners();
  }
}
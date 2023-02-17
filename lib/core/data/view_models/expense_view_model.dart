import 'dart:io';

import 'package:expense_tracker/core/data/mappers/expense_mapper.dart';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/expense.dart';
import 'package:path/path.dart';

class ExpenseViewModel extends ChangeNotifier {
  static const String _boxName = 'expenseBox';
  List<ExpenseEntity> _expenseListEntities = [];

  List<ExpenseEntity> get expenseListEntities => _expenseListEntities;

  ExpenseViewModel() {
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

  addExpense(ExpenseEntity expenseEntity) async {
    _expenseListEntities.add(expenseEntity);
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    await box.put(expenseEntity.toString(), expenseEntity.toModel());
    notifyListeners();
  }

  removeExpense(ExpenseEntity expenseEntity) async {
    _expenseListEntities.remove(expenseEntity);
    final box = await Hive.openBox<ExpenseModel>(_boxName);
    await box.delete(expenseEntity.toString());
    notifyListeners();
  }

  updateExpense(
      ExpenseEntity oldExpenseEntity, ExpenseEntity newExpenseEntity) async {
    removeExpense(oldExpenseEntity);
    addExpense(newExpenseEntity);
  }

  resetExpense() async {
    getExpenses();
    notifyListeners();
  }

  void exportHiveBackup() async {
    final PermissionStatus permissionStatus = await getPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      // Directory dir = await getApplicationDocumentsDirectory();
      Directory dir =
          await Directory('/storage/emulated/0/Download/ExpenseManager')
              .create(recursive: true);
      String backupPath = join(dir.path, "expense_manager_backup.hive");
      final box = await Hive.openBox<ExpenseModel>(_boxName);
      final boxPath = box.path;
      await box.close();

      try {
        File(boxPath!).copy(backupPath);
      } finally {
        await Hive.openBox<ExpenseModel>(_boxName);
        notifyListeners();
      }
    }
  }

  void importHiveBackup() async {
    final PermissionStatus permissionStatus = await getPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      // Directory dir = await getApplicationDocumentsDirectory();
      Directory dir =
          await Directory('/storage/emulated/0/Download/ExpenseManager')
              .create(recursive: true);
      String backupPath = join(dir.path, "expense_manager_backup.hive");
      final box = await Hive.openBox<ExpenseModel>(_boxName);
      final boxPath = box.path;
      await box.close();

      try {
        File(backupPath).copy(boxPath!);
      } finally {
        await Hive.openBox<ExpenseModel>(_boxName);
        notifyListeners();
      }
    }
  }
}

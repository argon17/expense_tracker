import 'package:expense_tracker/core/data/view_models/expense_view_model.dart';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:expense_tracker/core/utils/expense_category.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/widgets/gap.dart';

// ignore: must_be_immutable
class DetailedExpense extends StatefulWidget {
  ExpenseEntity? expenseEntity;
  DetailedExpense({Key? key, this.expenseEntity}) : super(key: key);
  @override
  State<DetailedExpense> createState() => _DetailedExpenseState();
}

class _DetailedExpenseState extends State<DetailedExpense> {
  final TextEditingController dateInputController = TextEditingController();
  final TextEditingController descInputController = TextEditingController();
  final TextEditingController amountInputController = TextEditingController();

  DateTime createdAt = DateTime.now();
  int gridViewIndex = -1;

  @override
  void initState() {
    ExpenseEntity? oldExpenseEntity = widget.expenseEntity;
    dateInputController.text = "Today";
    descInputController.text = "";
    amountInputController.text = "";
    if (oldExpenseEntity != null) {
      dateInputController.text =
          DateFormat('dd/MM/yyyy').format(oldExpenseEntity.createdAt);
      descInputController.text = oldExpenseEntity.desc;
      amountInputController.text = oldExpenseEntity.amount.toString();
      gridViewIndex = categoryItems.indexOf(categoryItems
          .where((expenseCategoryItem) =>
              expenseCategoryItem.category == oldExpenseEntity.category)
          .first);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expenseViewModel = context.watch<ExpenseViewModel>();
    ExpenseEntity? oldExpenseEntity = widget.expenseEntity;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          expenseViewModel.addExpense(ExpenseEntity(
              createdAt: createdAt,
              category: categoryItems[gridViewIndex].category,
              amount: int.parse(amountInputController.text),
              desc: descInputController.text));
          if (oldExpenseEntity != null) {
            expenseViewModel.removeExpense(oldExpenseEntity);
          }
          context.pop();
        },
        child: const Icon(Icons.done),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap.sm,
                IconButton(
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    onPressed: () => {context.pop()},
                    icon: const Icon(Icons.close)),
                Gap.lg,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "₹",
                      style: TextStyle(fontSize: FontSizes.s18),
                    ),
                    Gap.md,
                    Expanded(
                      child: TextFormField(
                        controller: amountInputController,
                        keyboardType: TextInputType.number,
                        cursorHeight: 0,
                        cursorWidth: 0,
                        enableInteractiveSelection: false,
                        autofocus: true,
                        style: const TextStyle(fontSize: FontSizes.s48),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            hintText: "0",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
                Gap.md,
                const Text("Category"),
                Gap.md,
                SelectCategoryScrollableList(gridViewIndex,
                    (val) => setState(() => gridViewIndex = val)),
                Gap.lg,
                const Text("Details"),
                Gap.md,
                TextFormField(
                  controller: dateInputController,
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                        dateInputController.text = formattedDate;
                        createdAt = pickedDate;
                      });
                    }
                  },
                ),
                Gap.md,
                TextField(
                  controller: descInputController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.comment, color: Colors.white),
                      labelText: "Add Description"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SelectCategoryScrollableList extends StatefulWidget {
  final dynamic setSelectedIndex;
  int selectedIndex;
  SelectCategoryScrollableList(this.selectedIndex, this.setSelectedIndex,
      {Key? key})
      : super(key: key);

  @override
  State<SelectCategoryScrollableList> createState() =>
      _SelectCategoryScrollableList();
}

class _SelectCategoryScrollableList
    extends State<SelectCategoryScrollableList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: categoryItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpenseCategoryCard(
              index,
              isSelected: index == widget.selectedIndex,
              widget.setSelectedIndex);
        },
      ),
    );
  }
}

class ExpenseCategoryCard extends StatelessWidget {
  final int curIndex;
  final bool isSelected;
  final dynamic setSelectedIndex;
  const ExpenseCategoryCard(this.curIndex, this.setSelectedIndex,
      {this.isSelected = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExpenseCategoryItem expenseCategoryItem = categoryItems[curIndex];
    return InkWell(
      onTap: () {
        setSelectedIndex(curIndex);
      },
      child: Container(
        margin: const EdgeInsets.all(Sizes.s2),
        color: isSelected ? Colors.blueGrey : Colors.white10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              expenseCategoryItem.iconData,
              size: IconSizes.lg,
              color: isSelected ? Colors.white : expenseCategoryItem.bgColor,
            ),
            Gap.sm,
            Text(
              expenseCategoryItem.name,
            )
          ],
        ),
      ),
    );
  }
}

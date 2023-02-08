import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/core/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/widgets/expense_avatar.dart';
import 'package:expense_tracker/core/widgets/gap.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/overview/presentation/detailed_expense.dart';

class ExpenseListTileItem extends StatelessWidget {
  const ExpenseListTileItem(this.expenseEntity, this.avatarVisible, {Key? key})
      : super(key: key);
  final ExpenseEntity expenseEntity;
  final bool avatarVisible;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedExpense(
                expenseEntity: expenseEntity,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.s8, horizontal: Sizes.s18),
        child: Row(
          children: [
            Row(
              children: [
                avatarVisible
                    ? ExpenseAvatar(expenseEntity.category)
                    : const SizedBox(
                        width: Sizes.s24,
                      ),
                Gap.md,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expenseEntity.desc,
                        ),
                        Gap.sm,
                        Text(getDayString(expenseEntity.createdAt),
                            style: TextStyle(color: AppColors.kGrey))
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text(
              "₹ ${expenseEntity.amount}",
            )
          ],
        ),
      ),
    );
  }
}

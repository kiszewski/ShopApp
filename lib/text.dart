class ExpenseCategories {}

class IncomeCategories {}

class Budget {
  List<IncomeCategories> incomeCategories;
  List<ExpenseCategories> expenseCategories;
  List<Map<String, dynamic>> percentForEachExpenseCategory;

  definePercent() {
    percentForEachExpenseCategory = [
      {
        'category': 'Food',
      },
    ];
  }
}

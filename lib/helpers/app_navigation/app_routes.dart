enum AppRoute {
  dashboardScreen('Dashboard Screen'),
  homeScreen('Home Screen'),
  addExpenseScreen('Add Expense Screen'),
  expenseListScreen('Expense List Screen'),
  statsScreen('Stats Screen');

  const AppRoute(this.routeName);

  final String routeName;
}

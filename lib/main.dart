import 'package:flutter/material.dart';
import 'package:msa_assessment/presentation/add_expense_screen/add_expense_screen.dart';
import 'package:msa_assessment/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:msa_assessment/presentation/expense_list_screen/expense_list_screen.dart';
import 'package:msa_assessment/presentation/home_screen/home_screen.dart';
import 'package:msa_assessment/presentation/stats_screen/stats_screen.dart';
import 'helpers/app_navigation/app_routes.dart';
import 'services/platform_services/local_notification_service/local_notification_service.dart';

void main() {
  // to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // to initialize the notificationservice.
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.homeScreen.routeName,
      routes: {
        AppRoute.homeScreen.routeName: (context) => const HomeScreen(),
        AppRoute.dashboardScreen.routeName: (context) =>
            const DashboardScreen(),
        AppRoute.statsScreen.routeName: (context) =>  StatsScreen(),
        AppRoute.addExpenseScreen.routeName: (context) =>
            const AddExpenseScreen(),
        AppRoute.expenseListScreen.routeName:(context) => const ExpenseListScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

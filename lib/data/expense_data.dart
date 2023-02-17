import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';
import 'package:flutter_application_1/models/expense_item.dart';

class ExpenseData extends ChangeNotifier {

  //list of all expenses
  List<ExpenseItem> overallExpenselist = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList()
  {
    return overallExpenselist;
  }

  // add new expense

  void addNewExpense(ExpenseItem newExpense)
  {
    overallExpenselist.add(newExpense);

    notifyListeners();
  }

  // delete expense
  void deleteExpense(ExpenseItem expense)
  {
    overallExpenselist.remove(expense);

    notifyListeners();
  }

  // get weekday from dateTime object

  String getDayName(DateTime dateTime)
  {
    switch(dateTime.weekday)
    {
      case 1:
      return 'Mon';

       case 2:
      return 'Tue';
      
       case 3:
      return 'Wed';
      
       case 4:
      return 'Thur';
      
       case 5:
      return 'Fri';
      
       case 6:
      return 'Sat';
      
       case 7:
      return 'Sun';
      
      break;
      default:
      return '';
    }
  }

  // gete the date from the start of the week
  DateTime startOfWeekDate()
  {
    DateTime? startOfWeek;

    //get todays date

    DateTime today = DateTime.now();

    // go back from today to find sunday
    for (int i = 0; i < 7; i++)
    {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun')
      {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
     return startOfWeek!; // made return type nullable . option was to make it date time
  }

  /*

  convert overall list of expenses into a daily expense summmary

  e.g
  overallExpenselist =
  [
    [food, 2023/02/10 , ksh4000],
    [nails, 2023/02/11,  ksh1500],
    [hair, 2023/02/11,  ksh3000],
    [jewellery, 2023/02/12, ksh2000],
  ]

  ->

  dailyExpenseSummary =
  [
    [ 20230210 , ksh4000],
    [ 20230211 , ksh4500],
    [ 20230212 , ksh2000],
  ]
  
  */ 
  Map<String,double> calculateDailyExpenseSummary()
  {
    Map<String,double> dailyExpenseSummary = 
    {
      //date {yyyymmdd} : amountTotalForDay
    };
    for (var expense in overallExpenselist)
    {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date))
      {
        double currentAmount =dailyExpenseSummary[date]!;
        currentAmount += amount  ;
        dailyExpenseSummary[date] = currentAmount;
      }
      else{
        dailyExpenseSummary.addAll({date: amount});
      }

    } 
    return dailyExpenseSummary;
    
  }
}
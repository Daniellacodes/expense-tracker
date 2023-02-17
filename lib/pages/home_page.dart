import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/expense_summary.dart';
import 'package:flutter_application_1/components/expense_tile.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/models/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
  // add new expense

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
         
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
        ),
        body: ListView(children: [
          //weekly summary
          ExpenseSummary(startOfWeek: value.startOfWeekDate()),
          SizedBox(height: 20),
        
        //expense list
         ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                ),)
                ]),
      ),
    );
  }

  //text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseShillingsController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

// new position add new
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
              hintText: "Expense name"
            ),
            ),


            //expense amount
            // shillings
            Row(children: [
            Expanded(
            child: TextField(
            controller: newExpenseShillingsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Shillings"
            ),
           ),
            ),


           // cents
           Expanded(
            child: TextField(
            controller: newExpenseCentsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Cents"
            ),
           ),
            ),

          ],
          ),
          ],
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          //cancel button
          MaterialButton(onPressed: cancel, child: Text('Cancel'))
        ],
      ),
    );
  }

  //save
  void save() {
    // putting shs and cts together
    String amount ='${newExpenseShillingsController.text}.${newExpenseCentsController.text}';
    //create expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );
    //add the new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseShillingsController.clear();
    newExpenseCentsController.clear();
  }
}

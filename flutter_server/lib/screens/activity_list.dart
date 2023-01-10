import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/entry.dart';
import '../utils/entry_service.dart';
import '../utils/api_service.dart';
import 'entry_detail.dart';


class EntryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EntryListState();
  }
}

class EntryListState extends State<EntryList> {
  //DatabaseHelper databaseHelper = DatabaseHelper();
  APIService apiService = APIService();
  List<Entry> entriesList = [];
  int count = 0;


  @override
  Widget build(BuildContext context) {
    if (entriesList == null) {
      entriesList = <Entry>[];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('COINTRACK'),
        ),
      ),
      body: getEntryListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(
              Entry('', 0, 0, 0, 0, '', 0, ''), 'Add Entry');
        },
        tooltip: 'Add Entry',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getEntryListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;
    updateListView();
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getMoodColor(this.entriesList[position].value ?? 1),
              child: getExpenseIcon(this.entriesList[position].value ?? 1),
            ),
            title: Text(
              this.entriesList[position].name ?? 'default',
              style: titleStyle,
            ),
            subtitle: Text(this.entriesList[position].details ?? 'default'),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                debugPrint("POSITION TO DELETE: ${entriesList[position]}");
                _delete(context, entriesList[position]);
                updateListView();
              },
            ),
            onTap: () {
              debugPrint("entry to update: ${this.entriesList[position].name}");
              navigateToDetail(this.entriesList[position], 'Edit Entry');
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getMoodColor(int value) {
    int aux = value > 0? 1 : 0;
    switch (aux) {
      case 0:
        return Colors.red;
        break;
      case 1:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  // Returns the expense or income icon
  Icon getExpenseIcon(int value) {
    int aux = value > 0? 1 : 0;
    switch (aux) {

      case 0:
        return Icon(Icons.money_off_csred_outlined);
        break;
      case 1:
        return Icon(Icons.attach_money);
        break;

      default:
        return Icon(Icons.attach_money);
    }
  }

  void _delete(BuildContext context, Entry entry) async {
    bool val = showConfirmationDialog(context, entry);
    updateListView();
  }

  bool showConfirmationDialog(BuildContext context, Entry entry) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        debugPrint("ACTTIVITY ID${entry.id}");
        bool result = await APIService.deleteEntry(entry.id);
        if (result != false) {
          _showSnackBar(context, 'Entry Deleted Successfully');
          updateListView();
        }
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure you want to delete this entry?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Entry entry, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EntryDetail(entry, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
      Future<List<Entry>?> entryListFuture = APIService.getEntries();
      entryListFuture.then((entryList) {
        setState(() {
          this.entriesList = entryList!;
          this.count = entryList.length;
        });
      });
  }
}


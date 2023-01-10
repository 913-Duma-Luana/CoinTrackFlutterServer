import 'package:flutter/material.dart';
import '../models/entry.dart';
import '../utils/entry_service.dart';
import '../utils/api_service.dart';

class EntryDetail extends StatefulWidget {
  final String appBarTitle;
  final Entry entry;

  EntryDetail(this.entry, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return EntryDetailState(this.entry, this.appBarTitle);
  }
}

class EntryDetailState extends State<EntryDetail> {

  //DatabaseHelper helper = DatabaseHelper();
  APIService apiService = APIService();
  String appBarTitle;
  Entry entry;

  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  EntryDetailState(this.entry, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;

    titleController.text = entry.name;
    valueController.text = entry.value.toString();
    detailsController.text = entry.details;
    categoryController.text = entry.category;
    yearController.text = entry.year.toString();
    monthController.text = entry.month.toString();
    dayController.text = entry.day.toString();
    timeController.text = entry.time.toString();


    return WillPopScope(
        onWillPop: () async {
          bool? result= moveToLastScreen();
          result ??= false;
          return result;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                // First element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: valueController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Value Text Field');
                      updateValue();
                    },
                    decoration: InputDecoration(
                        labelText: 'Value',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // ListTile(
                //   title: DropdownButton(
                //       items: _value.map((String dropDownStringItem) {
                //         return DropdownMenuItem<String>(
                //           value: dropDownStringItem,
                //           child: Text(dropDownStringItem),
                //         );
                //       }).toList(),
                //       style: textStyle,
                //       value: getPriorityAsString(entry.value),
                //       onChanged: (valueSelectedByUser) {
                //         setState(() {
                //           debugPrint('User selected $valueSelectedByUser');
                //           updateValue(valueSelectedByUser!);
                //         });
                //       }),
                // ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: detailsController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDetails();
                    },
                    decoration: InputDecoration(
                        labelText: 'Details',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: categoryController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateCategory();
                    },
                    decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                // Fifth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(children: <Widget>[Expanded(child: TextField(
                    controller: yearController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateYear();
                    },
                    decoration: InputDecoration(
                        labelText: 'Year',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),

                Expanded(child: TextField(
                    controller: monthController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateMonth();
                    },
                    decoration: InputDecoration(
                        labelText: 'Month',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),

                  Expanded(child: TextFormField(
                    controller: dayController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDay();
                    },
                    decoration: InputDecoration(
                        labelText: 'Day',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ))]
                )),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: timeController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateTime();
                    },
                    decoration: InputDecoration(
                        labelText: 'Time',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Sixth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (int.tryParse(dayController.text) == null) {
                              final snackBar = SnackBar(
                                  content: Text("Day is not a number"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (int.tryParse(yearController.text) ==
                                null) {
                              final snackBar = SnackBar(
                                  content: Text("Year is not a number"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (int.tryParse(monthController.text) ==
                                null) {
                              final snackBar = SnackBar(
                                  content: Text("Month is not a number"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (int.tryParse(timeController.text) ==
                                null) {
                              final snackBar = SnackBar(
                                  content: Text("Time is not a number"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (int.parse(dayController.text) < 1 ||
                                int.parse(dayController.text) > 31) {
                              final snackBar = SnackBar(
                                  content:
                                      Text("Day should be between 1 and 31"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (int.parse(yearController.text) < 2022 ||
                                int.parse(yearController.text) > 2024) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      "Year should be between 2022 and 2024"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (int.parse(monthController.text) < 1 ||
                                int.parse(monthController.text) > 12) {
                              final snackBar = SnackBar(
                                  content:
                                      Text("Month should be between 1 and 12"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (detailsController.text.length < 3) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      "Details should be at least 3 characters long"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }  else if (categoryController.text.length < 3) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      "Category should be at least 3 characters long"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (titleController.text.length < 3) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      "Name should be at least 3 characters long"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              setState(() {
                                debugPrint("Save button clicked");
                                _save();
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      // Expanded(
                      //   child: MaterialButton(
                      //     color: Theme.of(context).primaryColorDark,
                      //     textColor: Theme.of(context).primaryColorLight,
                      //     child: Text(
                      //       'Delete',
                      //       textScaleFactor: 1.5,
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         debugPrint("Delete button clicked");
                      //         _delete();
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool moveToLastScreen() {
    Navigator.pop(context, true);
    return true;
  }

  // Update the title of Note object
  void updateTitle() {
    entry.name = titleController.text;
  }

  void updateValue() {
    entry.value = int.parse(valueController.text);
  }

  // Update the description of Note object
  void updateDetails() {
    entry.details = detailsController.text;
  }

  void updateCategory() {
    entry.category = categoryController.text;
  }

  void updateYear() {
    entry.year = int.parse(yearController.text);
  }

  void updateMonth() {
    entry.month = int.parse(monthController.text);
  }

  void updateDay() {
    entry.day = int.parse(dayController.text);
  }

  void updateTime() {
    entry.time = int.parse(timeController.text);
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    //entry.date = DateFormat.yMMMd().format(DateTime.now());
    bool result;
    debugPrint("entry to update ${entry.id}");
    if (entry.id != null) {
      // Case 1: Update operation
      result = await APIService.saveEntry(entry, true);
    } else {
      // Case 2: Insert Operation
      result = await APIService.saveEntry(Entry(
          entry.name,
          entry.year,
          entry.month,
          entry.day,
          entry.time,
          entry.category,
          entry.value,
          entry.details), false);
    }

    if (result != false) {
      // Success
      _showAlertDialog('Status', 'Entry Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (entry.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    bool result = await APIService.deleteEntry(entry.id);
    if (result != false) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}

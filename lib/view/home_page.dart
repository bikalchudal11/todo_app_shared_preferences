// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_app_shared_preferences/view/resources/colors.dart';
import 'package:todo_app_shared_preferences/view_model/shared_preferences_db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController noteController = TextEditingController();
  String? notes;

  @override
  void initState() {
    super.initState();
  }

  void noteAddDialog(context) {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text(
              "Add note!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                  controller: noteController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Type something",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    onPressed: () {
                      saveNote(noteController.text);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  saveNote(String note) {
    SharedPreferencesHelper.saveNote('notes', note);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: primaryColor, content: Text("Note added!")));
    Navigator.pop(context);

    noteController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    notes = SharedPreferencesHelper.getNote('notes');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondaryColor,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "ToDo",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          noteAddDialog(context);
        },
        child: Icon(
          Icons.add,
          color: secondaryColor,
        ),
      ),
      body: notes == null
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.8,
                      image: AssetImage(
                        'assets/images/bg.jpg',
                      ))),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  notes.toString(),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

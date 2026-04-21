import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/data/firestore_data.dart';
import 'package:to_do_list/models/notes_model.dart';
import 'package:to_do_list/screens/edit_task.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  final NotesModel _note;
  // ignore: prefer_const_constructors_in_immutables
  TaskWidget(this._note, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

  bool isDone = false;

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDone;
    return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 165,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget._note.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                            Checkbox(
                              activeColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              value: isDone, onChanged: (value) {
                              setState(() {
                                isDone = !isDone;
                              });
                              FirestoreData().isDone(widget._note.id, isDone);
                            }),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget._note.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor.withValues(alpha: 0.8),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                  onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTask(widget._note)));
                                      },
                                  style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  child: Text("Edit",
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ),
                ),
              );
  }
}
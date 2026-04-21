import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/data/firestore_data.dart';
import 'package:to_do_list/screens/add_screen.dart';
import 'package:to_do_list/widgets/task_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  bool show = true;
class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        shadowColor: AppColors.blackColor,
        title: Text(
          "My Tasks",
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            } else if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreData().getNotesStream(),
            builder: (context, asyncSnapshot) {
              if (!asyncSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: AppColors.whiteColor,
                  ),
                );
              }
              final noteslist = FirestoreData().getNotes(asyncSnapshot);
              if (noteslist.isEmpty) {
                return Center(
                  child: Image(image: AssetImage('assets/images/1.png'), width: 500, height: 500),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final note = noteslist[index];
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white, size: 40),
                    ),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      FirestoreData().deleteNote(note.id);
                    },
                    child: TaskWidget(note),
                  );
                },
                itemCount: noteslist.length,
              );
            }
          ),
        ),
      ),
    );
  }
}

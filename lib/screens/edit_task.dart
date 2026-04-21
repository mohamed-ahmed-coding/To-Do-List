import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/data/firestore_data.dart';
import 'package:to_do_list/models/notes_model.dart';
import 'package:to_do_list/widgets/login_image.dart';
import 'package:to_do_list/widgets/primary_button.dart';
import 'package:to_do_list/widgets/text_field_widget.dart';

// ignore: must_be_immutable
class EditTask extends StatefulWidget {
  final NotesModel _note;
  const EditTask(this._note, {super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController? title;
  TextEditingController? description;

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget._note.title);
    description = TextEditingController(text: widget._note.description);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                LoginImage(),
                TextFieldWidget(controller: title,
                focusNode: titleFocusNode, 
                hintText: 'Title', 
                icon: Icons.title, 
                obscureText: false
                ),
                SizedBox(height: 20),
                TextFieldWidget(controller: description, 
                focusNode: descriptionFocusNode, 
                hintText: 'Description', 
                icon: Icons.description, 
                obscureText: false,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(text: "Save", size: Size(170, 48) ,onPressed: () {
                      FirestoreData().updateNote(widget._note.id, title!.text, description!.text);
                      Navigator.pop(context);
                    }
                    ),
                    PrimaryButton(text: "Cancel", size: Size(170, 48), backgroundColor: Colors.red, onPressed: () {
                      Navigator.pop(context);
                    }
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
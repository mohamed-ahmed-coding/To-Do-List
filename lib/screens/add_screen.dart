import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/data/firestore_data.dart';
import 'package:to_do_list/widgets/login_image.dart';
import 'package:to_do_list/widgets/primary_button.dart';
import 'package:to_do_list/widgets/text_field_widget.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final title = TextEditingController();
  final description = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
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
                      FirestoreData().addNote(title.text.trim(), description.text.trim());
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
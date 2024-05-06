import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/core/providers/task_provider.dart';
import 'package:todo_app/app/screens/widget/custom_input_field.dart';
import 'package:todo_app/app/screens/widget/submit_button.dart';

void showBottonSheet(BuildContext context, pageheading) {
  final hundredPercentageWidth = MediaQuery.of(context).size.width * 1;
  final bottonSheetHeight = MediaQuery.of(context).size.height * 1;

  showModalBottomSheet(
    isScrollControlled: true,
    // useSafeArea: true,
    shape: const ContinuousRectangleBorder(),
    context: context,
    builder: (BuildContext context) {
      return Consumer<TaskProvider>(builder: (context, value, child) {
        return Container(
          width: hundredPercentageWidth,
          height: bottonSheetHeight,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: value.taskFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  pageheading,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Georgia'
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: value.taskNameController,
                  hintText: "Title",
                  fieldValidator: (value) {
                    if (value == null || value == "") {
                      return 'This field is required!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: value.taskDescriptionController,
                  hintText: "Description",
                  fieldValidator: (value) {
                    if (value == null || value == "") {
                      return 'This field is required!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                SubmitButton(
                  width: hundredPercentageWidth,
                  height: 45,
                  onBtnPress: () {
                    if (value.taskFormKey.currentState!.validate()) {
                      if (value.isUpdate) {
                        value.updateTask();
                      } else {
                        value.addTask();
                      }
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
    },
  ).then((value) {
    Provider.of<TaskProvider>(context, listen: false).clearTaskFields();
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/widget/custom_input_field.dart';
import 'package:todo_app/ui/widget/submit_button.dart';

void showBottonSheet(BuildContext context) {
  final hundredPercentageWidth = MediaQuery.of(context).size.width * 1;
  final bottonSheetHeight = MediaQuery.of(context).size.height * 1;

  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                CustomInputField(
                  controller: value.taskNameController,
                  hintText: "Task name",
                  fieldValidator: (value) {
                    if (value == null || value == "") {
                      return 'This field is required!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  controller: value.taskDescriptionController,
                  hintText: "Task description",
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

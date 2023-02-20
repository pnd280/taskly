import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/widgets/color_picker.dart';
import 'package:taskly/widgets/rich_editor.dart';

import '../widgets/custom_text_field.dart';

class TaskEditorPage extends StatefulWidget {
  bool isNewTask;

  TaskEditorPage({
    super.key,
    this.isNewTask = true,
  });

  @override
  State<TaskEditorPage> createState() => _TaskEditorPageState();
}

class _TaskEditorPageState extends State<TaskEditorPage> {
  String title = '';

  void updateTitle(value) {
    setState(() {
      title = value;
    });
  }

  Color pickerColor = TasklyColor.VeriPeri;
  Color currentColor = TasklyColor.VeriPeri;

  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                splashRadius: 25,
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.trash,
                ),
              ),
            ),
            IconButton(
              splashRadius: 25,
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.checkmark_alt,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ColorPickerCluster(
                        onColorChange: changeColor,
                      ),
                    ),
                    Expanded(
                      child: ShadowBoxWithTitle(
                        title: 'Title',
                        child: [
                          Expanded(
                            child: InputField(
                              updateCallBack: updateTitle,
                              initialValue: 'afw',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ShadowBoxWithTitle(
                          title: 'Start Date',
                          child: [
                            Expanded(
                              child: InputField(
                                updateCallBack: updateTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ShadowBoxWithTitle(
                        title: 'Start Time',
                        child: [
                          Expanded(
                            child: InputField(
                              updateCallBack: updateTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ShadowBoxWithTitle(
                          title: 'End Date',
                          child: [
                            Expanded(
                              child: InputField(
                                updateCallBack: updateTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ShadowBoxWithTitle(
                        title: 'End Time',
                        child: [
                          Expanded(
                            child: InputField(
                              updateCallBack: updateTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(child: RichEditor())
              const Expanded(
                child: RichEditor(),
              )
            ],
          ),
        ));
  }

  Widget ColorPickerCluster({required onColorChange}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: pickerColor,
                  onColorChanged: onColorChange,
                  layoutBuilder: pickerLayoutBuilder,
                  itemBuilder: pickerItemBuilder,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  )),
                  child: const Text('Change'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: ShadowBoxWithTitle(
        title: 'Color',
        child: [
          Row(
            children: [
              Icon(
                Icons.circle,
                color: currentColor,
                size: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget ShadowBoxWithTitle(
      {required String title, required List<Widget> child}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(color: TasklyColor.greyText, fontSize: 13),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [TasklyStyle.shadow],
              borderRadius: BorderRadius.circular(11),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

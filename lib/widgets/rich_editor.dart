import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/widgets/custom_snackbar.dart';

class RichEditor extends StatefulWidget {
  var onUpdateCallBack;

  RichEditor({super.key, required this.onUpdateCallBack});

  @override
  State<RichEditor> createState() => _RichEditorState();
}

class _RichEditorState extends State<RichEditor> {
  final QuillEditorController controller = QuillEditorController();

  final customToolBarList = [
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.strike,
  ];

  final _toolbarColor = TasklyColor.VeriPeri;
  final _backgroundColor = Colors.white;
  final _toolbarIconColor = Colors.white;
  final _editorTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black54, fontWeight: FontWeight.normal);
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.teal, fontWeight: FontWeight.normal);

  @override
  void initState() {
    controller.onTextChanged((text) {
      // debugPrint('listening to $text');
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [TasklyStyle.shadow],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: TasklyColor.VeriPeri,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11)),
                child: Container(
                  color: Colors.transparent,
                  child: QuillHtmlEditor(
                    text: '<i>Hello</i> from <b>Taskly<b>! 😊',
                    hintText: '',
                    controller: controller,
                    isEnabled: true,
                    height: MediaQuery.of(context).size.height,
                    textStyle: _editorTextStyle,
                    hintTextStyle: _hintTextStyle,
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    hintTextPadding: EdgeInsets.zero,
                    backgroundColor: _backgroundColor,
                    onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
                    // onFocusChanged: (hasFocus) => {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     scrollController
                    //         .jumpTo(scrollController.position.maxScrollExtent);
                    //   })
                    // },
                    // onTextChanged: (text) => debugPrint('widget text change $text'),
                    onTextChanged: (text) {
                      widget.onUpdateCallBack(text);
                    },
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11)),
            child: ToolBar(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: _toolbarIconColor,
              activeIconColor: Colors.black,
              controller: controller,
              toolBarConfig: customToolBarList,
              customButtons: [
                InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey.shade100,
                          content: Container(
                            // color: Colors.grey.shade300,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MultiSelectContainer(
                                    controller: tagSelectionController,
                                    itemsDecoration: MultiSelectDecorations(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: TasklyColor.VeriPeri),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                    ),
                                    items: [
                                      MultiSelectCard(
                                        value: 'Important',
                                        label: 'Important',
                                      ),
                                      MultiSelectCard(
                                        value: 'Work',
                                        label: 'Work',
                                      ),
                                      MultiSelectCard(
                                        value: 'Personal',
                                        label: 'Personal',
                                      ),
                                      MultiSelectCard(
                                        value: 'Entertainment',
                                        label: 'Entertainment',
                                      ),
                                    ],
                                    onMaximumSelected:
                                        (allSelectedItems, selectedItem) {
                                      CustomSnackBar.showInSnackBar(
                                          'The limit has been reached',
                                          context);
                                    },
                                    onChange:
                                        (allSelectedItems, selectedItem) {}),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: IconButton(
                                    splashRadius: 25,
                                    color: TasklyColor.VeriPeri,
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.add,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.tag,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: _toolbarColor,
                child: Row(
                  children: [
                    textButton(
                        text: 'Set Text',
                        onPressed: () {
                          setHtmlText("This text is set by the setText method");
                        }),
                    textButton(
                        text: 'Insert Text',
                        onPressed: () {
                          insertHtmlText(
                              "This text is set by the insertText method");
                        }),
                    textButton(
                        text: 'Insert Index',
                        onPressed: () {
                          insertHtmlText(
                              "This text is set by the insertText method",
                              index: 10);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    // debugPrint(htmlText.toString());
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);
}

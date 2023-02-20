import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/styles.dart';

class RichEditor extends StatefulWidget {
  const RichEditor({super.key});

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
                  // onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
                  // onTextChanged: (text) => debugPrint('widget text change $text'),
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
              // customButtons: [
              //   InkWell(
              //       onTap: () async {},
              //       child: const Icon(
              //         Icons.favorite,
              //         color: Colors.black,
              //       )),
              //   InkWell(
              //       onTap: () {},
              //       child: const Icon(
              //         Icons.add_circle,
              //         color: Colors.black,
              //       )),
              // ],
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

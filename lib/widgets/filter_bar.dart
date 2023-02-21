import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/widgets/tag.dart';

Widget FilterBar(
    {required List tags,
    required List<String> userTags,
    required int currentChosenTag,
    required String currentChosenDropdownItem,
    required dropdownOnTap,
    required Color primaryColor,
    required tagOnTap}) {
  Widget DropdownTag(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TasklyColor.blackText.withOpacity(.1)),
        borderRadius: BorderRadius.circular(11),
        gradient: (currentChosenTag < 0)
            ? TasklyGradient.purpleBackground
            : TasklyGradient.lightBackground,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentChosenDropdownItem,
          dropdownColor: (currentChosenTag < 0) ? primaryColor : Colors.white,
          icon: Icon(
            CupertinoIcons.chevron_down,
            color: (currentChosenTag < 0) ? Colors.white : primaryColor,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            dropdownOnTap(value);
          },
          items: userTags.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  value,
                  style: (currentChosenTag < 0)
                      ? const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                      : TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
    child: SizedBox(
      width: double.infinity,
      height: 39,
      child: RefreshIndicator( 
        onRefresh: () async {
          debugPrint('Refresh!!!');
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: tags.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                // onTap: tagOnTap,
                child: (index <= tags.length - 1)
                    ? Tag(tags[index], primaryColor, index, tagOnTap,
                        currentChosenTag == index ? true : false)
                    : DropdownTag(primaryColor));
          },
        ),
      ),
    ),
  );
}

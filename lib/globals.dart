import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:flutter/material.dart';
import 'package:taskly/miscs/utils.dart';
import 'dart:developer';

int currentNavPage = 0;

int currentCalendarView = 0;

bool isTaskCreatePageVisible = false;

int currentChosenTag = 0;

String currentChosenDropdownItem = dummyUserTags.first;

EventController pageController = EventController();

FocusNode focusNode = FocusNode();

MultiSelectController tagSelectionController = MultiSelectController();

List<List> finalFormattedTasks = [];

ScrollController scrollController = ScrollController();

Set uniqueDays = {};

EventController calendarController = EventController();

var _temp = log('globals');

List placeholderTasks = [];

Function forceRedrawCb_ = () {};


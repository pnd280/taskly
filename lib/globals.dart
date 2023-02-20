import 'package:calendar_view/calendar_view.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:flutter/material.dart';

int currentNavPage = 0;

int currentCalendarView = 0;

bool isTaskCreatePageVisible = false;

int currentChosenTag = 0;

String currentChosenDropdownItem = dummyUserTags.first;

EventController pageController = EventController();

FocusNode focusNode = FocusNode();
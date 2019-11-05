import 'dart:async';
import 'package:flutter/material.dart';
import 'ListWidget.dart';
import 'package:date_utils/date_utils.dart';

enum TypeList { DateList, OtherList }

class UniversalListView {
  final TypeList typeList;

  Widget universalList;

  int numMonth;
  int numDay;
  int numYear;

  var textItemFirstList;
  var textItemSecondList;
  var textItemThirdList;
  var textItemFourthList;


  final List firstList;
  final List secondList;
  final List thirdList;
  final List fourthList;

  final String prefixText;
  final String postfixText;

  final Color colorCenteredLines;
  final Color textColor;
  final double textSize;

  final double itemExtent;
  final double diameterRatio;
  final double offAxisFraction;
  final double squeeze;



  final streamController = StreamController<bool>.broadcast();

  int fromYear;
  int toYear;
  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<int> days = List();
  List<int> years = List();


  ListWidgetViewState view;



  UniversalListView({
    @required this.typeList,
    this.fromYear,
    this.toYear,
    this.firstList,
    this.secondList,
    this.thirdList,
    this.fourthList,
    this.prefixText = '',
    this.postfixText = '',
    this.colorCenteredLines = Colors.black,
    this.textSize = 20,
    this.textColor = Colors.black,
    this.itemExtent = 30,
    this.diameterRatio = 1.0,
    this.offAxisFraction = -0.5,
    this.squeeze = 1.2,
  }) {

    if(typeList == TypeList.DateList)
    initDateData();

    if(typeList == TypeList.OtherList)
      initOtherData();


    universalList = ListWidgetView(
      presenter: this,
    );
  }

  initDateData(){
    if (years.isEmpty) setYears();
    if (days.isEmpty) setDays(years[0], 1);
    if (numMonth == null) numMonth = 1;
    if (numYear == null) numYear = years[0];
    if (numDay == null) numDay = 1;
  }

  initOtherData(){
    if(firstList != null)
      textItemFirstList = firstList[0];
    if(secondList != null)
      textItemSecondList = secondList[0];
    if(thirdList != null)
      textItemThirdList = thirdList[0];
    if(fourthList != null)
      textItemFourthList = fourthList[0];

  }

  void setYears() {
    years.clear();
    for (int i = fromYear; i <= toYear; i++) years.add(i);
  }

  void setDays(int y, int m) {
    days.clear();
    final DateTime date = new DateTime(y, m);
    final DateTime lastDay = Utils.lastDayOfMonth(date);
    for (int i = 1; i <= lastDay.day; i++) days.add(i);
  }

  void onDateItemChanged(int data, var list, int typeData) {
    if (typeData == 0) {
      numDay = list[data];
    }
    if (typeData == 1) {
      numMonth = data + 1;
      setDays(numYear, numMonth);
      view.updateView();
      streamController.sink.add(true);
    }
    if (typeData == 2) {
      numYear = list[data];
      setDays(numYear, numMonth);
      view.updateView();
      streamController.sink.add(true);
    }
  }

  void onSimpleListChanged(var list, int numItem, int countList){
    switch(countList){
      case 0:
        textItemFirstList = list[numItem];
        break;
      case 1:
        textItemSecondList = list[numItem];
        break;
      case 2:
        textItemThirdList = list[numItem];
        break;
      case 3:
        textItemFourthList = list[numItem];
        break;
    }
  }

  void updateDaysList(FixedExtentScrollController fixedExtentScrollController,
      int typeData, List<Widget> widgets, var list) {
    if (typeData == 0) {
      widgets.clear();
      for (int i = 0; i < list.length; i++)
        widgets.add(
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              list[i].toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      fixedExtentScrollController.jumpToItem(0);
    }
  }

  List<Widget> getWidgets(var list) {
    List<Widget> widgets = List();
    for (int i = 0; i < list.length; i++)
      widgets.add(
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            '${prefixText}${list[i].toString()}${postfixText}',
            style: TextStyle(fontSize: textSize),
          ),
        ),
      );
    return widgets;
  }

  String getDay(){
    if(numDay<10)
      return '0${numDay}';
    else return numDay.toString();
  }

  String gerMonth(){
    if(numMonth<10)
      return '0${numMonth}';
    else return numMonth.toString();
  }
  String getYear(){
    return numYear.toString();
  }

  String getTextItemFirstList(){
    return textItemFirstList.toString();
  }

  String getTextItemSecondList(){
    return textItemSecondList.toString();
  }
  String getTextItemThirdList(){
    return textItemThirdList.toString();
  }
  String getTextItemFourthList(){
    return textItemFourthList.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:list_widget/universal_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List widget',
      home: BodyView(),
    );
  }
}

class BodyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BodyViewState();
}

class BodyViewState extends State<BodyView> {

  var testList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  UniversalListView universalListView;

  UniversalListView universalListView2;

  @override
  Widget build(BuildContext context) {
    if(universalListView == null)
      universalListView = UniversalListView(
        typeList: TypeList.DateList, fromYear: 1950, toYear: 2020);

    if(universalListView2 == null)
      universalListView2 = UniversalListView(
      typeList: TypeList.OtherList,
      firstList: testList,
        secondList: testList,
        thirdList: testList,
        fourthList: testList,
        postfixText: ' "'
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('List Widget'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Виджет для выбора даты',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                        top: BorderSide(color: Colors.grey, width: 1.0))),
                child: universalListView.universalList,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0
                ),
                child: Text(
                  'Дата\n ${universalListView.getDay()}.${universalListView.gerMonth()}.${universalListView.getYear()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                    });
                  },
                  child: Text('Показать выбранную дату'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Виджет для выбора/вывода других данных',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                        top: BorderSide(color: Colors.grey, width: 1.0))),
                child: universalListView2.universalList,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0
                ),
                child: Text(
                  'Данные со второго листа\n ${universalListView2.getTextItemFirstList()} '
                      '${universalListView2.getTextItemSecondList()} '
                      '${universalListView2.getTextItemThirdList()} '
                      '${universalListView2.getTextItemFourthList()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                    });
                  },
                  child: Text('Показать выбранные данные'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

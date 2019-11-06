import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:list_widget/custom_physics.dart';
import 'package:list_widget/universal_list.dart';

class ListWidgetView extends StatefulWidget {
  final UniversalListView presenter;

  ListWidgetView({Key key, this.presenter}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListWidgetViewState();
}

class ListWidgetViewState extends State<ListWidgetView> {
  void updateView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.presenter.view == null) widget.presenter.view = this;
    return Container(
      height: 150,
      child: widget.presenter.typeList == TypeList.DateList
          ? Stack(
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child:
                              getDateList(context, widget.presenter.years, 2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child:
                              getDateList(context, widget.presenter.month, 1),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: getDateList(context, widget.presenter.days, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 1.0,
                    margin: EdgeInsets.only(top: 55.0),
                    color: widget.presenter.colorCenteredLines,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 1.0,
                    margin: EdgeInsets.only(top: 95.0),
                    color: widget.presenter.colorCenteredLines,
                  ),
                )
              ],
            )
          : Stack(
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.presenter.firstList != null
                          ? Expanded(
                              child: Container(
                                child: getSimpleList(
                                    context, widget.presenter.firstList, 0),
                              ),
                            )
                          : Container(),
                      widget.presenter.secondList != null
                          ? Expanded(
                              child: Container(
                                child: getSimpleList(
                                    context, widget.presenter.secondList, 1),
                              ),
                            )
                          : Container(),
                      widget.presenter.thirdList != null
                          ? Expanded(
                              child: Container(
                                child: getSimpleList(
                                    context, widget.presenter.thirdList, 2),
                              ),
                            )
                          : Container(),
                      widget.presenter.fourthList != null
                          ? Expanded(
                              child: Container(
                                child: getSimpleList(
                                    context, widget.presenter.fourthList, 3),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 1.0,
                    margin: EdgeInsets.only(top: 55.0),
                    color: widget.presenter.colorCenteredLines,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 1.0,
                    margin: EdgeInsets.only(top: 95.0),
                    color: widget.presenter.colorCenteredLines,
                  ),
                )
              ],
            ),
    );
  }

  Widget getDateList(BuildContext context, List list, int typeData) {
    FixedExtentScrollController fixedExtentScrollController =
        FixedExtentScrollController();

    List<Widget> widgets = widget.presenter.getWidgets(list);

    widget.presenter.streamController.stream.listen((_) {
      widget.presenter
          .updateDaysList(fixedExtentScrollController, typeData, widgets, list);
    });

    fixedExtentScrollController.addListener(() {
      var demension = fixedExtentScrollController.position.maxScrollExtent /
          (list.length - 1);
      widget.presenter.scrollPhysics =
          CustomScrollPhysics(itemDimension: demension);
      updateView();
    });
    return ListWheelScrollView(
        physics: widget.presenter.scrollPhysics,
        controller: fixedExtentScrollController,
        itemExtent: widget.presenter.itemExtent,
        diameterRatio: widget.presenter.diameterRatio,
        offAxisFraction: widget.presenter.offAxisFraction,
        squeeze: widget.presenter.squeeze,
        onSelectedItemChanged: (numItem) {
          widget.presenter.onDateItemChanged(numItem, list, typeData);
        },
        children: widgets);
  }

  Widget getSimpleList(BuildContext context, List list, int numList) {
    FixedExtentScrollController fixedExtentScrollController =
        FixedExtentScrollController();

    List<Widget> widgets = widget.presenter.getWidgets(list);

    fixedExtentScrollController.addListener(() {
      var demension = fixedExtentScrollController.position.maxScrollExtent /
          (list.length - 1);
      widget.presenter.scrollPhysics =
          CustomScrollPhysics(itemDimension: demension);
      updateView();
    });

    return ListWheelScrollView(
        physics: widget.presenter.scrollPhysics,
        controller: fixedExtentScrollController,
        itemExtent: widget.presenter.itemExtent,
        diameterRatio: widget.presenter.diameterRatio,
        offAxisFraction: widget.presenter.offAxisFraction,
        squeeze: widget.presenter.squeeze,
        onSelectedItemChanged: (numItem) {
          widget.presenter.onSimpleListChanged(list, numItem, numList);
        },
        children: widgets);
  }
}

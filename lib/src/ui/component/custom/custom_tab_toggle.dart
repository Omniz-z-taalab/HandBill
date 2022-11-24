import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/tab_toggle_model.dart';

class CustomTabToggle extends StatefulWidget {
  final List<TabToggleModel>? items;
  final int initIndex;
  final Function(int)? onIndexChanged;
  final double marginHor;

  CustomTabToggle(
      {this.items,
      this.initIndex = 0,
      this.marginHor = 16,
      this.onIndexChanged});

  @override
  _CustomTabToggleState createState() => _CustomTabToggleState();
}

class _CustomTabToggleState extends State<CustomTabToggle> {
  TabToggleModel? _selectedTab;
  List<TabToggleModel> _items = [];
  late int _initIndex;

  @override
  void initState() {
    _initIndex = widget.initIndex;
    widget.items!.forEach((element) {
      _items.add(element);
      if (_items.isNotEmpty) {
        setState(() {
          _items[_initIndex].isSelected = true;
          _selectedTab = _items[_initIndex];
        });
      }
    });
    super.initState();
  }

  Color _backColor = Color(0xffffffff);
  Color _selectedColor = Color(0xff2f84ed);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: widget.marginHor),
        padding: EdgeInsets.all(4),
        clipBehavior: Clip.hardEdge,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: _backColor,
            border: Border.all(color: Color(0xffeeeeee)),
            borderRadius: BorderRadius.circular(90)),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(
              clipBehavior: Clip.hardEdge,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  _items.length,
                  (index) => InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedTab != null) {
                            _selectedTab!.isSelected = false;
                          }
                          _items[index].isSelected = !_items[index].isSelected;
                          _selectedTab = _items[index];
                          widget.onIndexChanged!(index);
                        });
                      },
                      child: Container(
                          width: constraints.maxWidth / _items.length,
                          decoration: BoxDecoration(
                            color: _items[index].isSelected
                                ? _selectedColor
                                : _backColor,
                            borderRadius: BorderRadius.circular(900),
                            // border: Border.all(
                            //     color: _items[index].isSelected
                            //         ? Color(0xffeeeeee)
                            //         : Color(0xffffffff)),
                          ),
                          child: Center(
                              child: Text(_items[index].label!,
                                  style: TextStyle(
                                      color: _items[index].isSelected
                                          ? _backColor
                                          : _selectedColor,
                                      fontSize: 16,
                                      fontWeight: _items[index].isSelected
                                          ? FontWeight.w500
                                          : FontWeight.normal)))))));
        }));
  }
}

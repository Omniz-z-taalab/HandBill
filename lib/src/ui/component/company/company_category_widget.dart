import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/category.dart';

class MarketCategoryWidget extends StatelessWidget {
  final CategoryModel model;
  final Function? onTap;

  MarketCategoryWidget({required this.model, this.onTap});

  final Color _selectedColor = Color(0xff2f84ed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap!(),
        behavior: HitTestBehavior.translucent,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: model.selected == true
                    ? _selectedColor
                    : Colors.transparent,
                border: Border.all(color: _selectedColor)),
            child: Center(
                child: Text(model.name!,
                    maxLines: 1,
                    style: TextStyle(
                        color: model.selected == true
                            ? Colors.white
                            : _selectedColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15)))));
  }
}

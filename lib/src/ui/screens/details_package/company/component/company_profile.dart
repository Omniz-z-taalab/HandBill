import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/LeftDetailsOfCompany.dart';
import 'package:hand_bill/src/data/model/local/data_variable.dart';
import 'package:intl/intl.dart';

class CompanyProfile extends StatefulWidget {
  final LeftDataOfCompanies leftDataOfCompanies;

  CompanyProfile({required this.leftDataOfCompanies});

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<DataVariable> _dataList = [];
  @override
  void initState() {
    LeftDataOfCompanies _dataOfCompanies = widget.leftDataOfCompanies;
    if (widget.leftDataOfCompanies != null) {
      if (_dataList.length !=0) {
        print("\n checked");
        _dataList.clear();
        _dataOfCompanies.toJson().forEach((key, value) {
          if (value != null) {
            _dataList.add(DataVariable(
                key: toBeginningOfSentenceCase(key.replaceAll("_", " ")),
                value: value.toString()));
          }
        });
      } else {
        _dataOfCompanies.toJson().forEach((key, value) {
          if (value != null) {
            _dataList.add(DataVariable(
                key: key.replaceAll("_", " "), value: value.toString()));
          }
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        primary: false,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _dataList.length,
                  itemBuilder: (BuildContext context, int index) =>
                  _dataList[index].key!.trim()!="commercial register"
                      &&_dataList[index].key!.trim()!="tax card"?
                      DataRowWidget(model: _dataList[index]):SizedBox()),
            ])
          ],
        ));
  }
}

class DataRowWidget extends StatelessWidget {
  final DataVariable model;

  DataRowWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          Row(children: [
            Expanded(
                child: Text(model.key!,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
            SizedBox(width: 16),
            Expanded(
                child: Text(model.value!,
                    style: TextStyle(
                      fontSize: 14,
                      color: textDarkColor,
                    )))
          ]),
          // SizedBox(height: 16),
          Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 1,
              color: Color(0xffe0e0e0),
              width: double.infinity)
        ]));
  }
}

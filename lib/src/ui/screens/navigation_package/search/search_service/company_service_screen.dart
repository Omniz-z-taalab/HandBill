import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/Companies/bloc.dart';

import '../../../../../blocs/Services/Event.dart';
import '../../../../../blocs/Services/bloc.dart';
import '../../../../../blocs/Services/states.dart';
import '../../../../../data/model/company.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../details_package/company/company_screen.dart';

class CompanyServiceScreen extends StatefulWidget {
  static const routeName = "/CompanyServiceScreen";
  final RouteArgument routeArgument;

  CompanyServiceScreen({required this.routeArgument});

  @override
  State<CompanyServiceScreen> createState() => _CompanyServiceScreenState();
}

class _CompanyServiceScreenState extends State<CompanyServiceScreen> {
  late int companyId;
 late ServiceBlocData serviceBloc;
  List<Company>? company;

  @override
  void initState() {
    companyId = widget.routeArgument.param;
    print(companyId);
    print('aaaaaaaaaaaaaaaa');
    // serviceBloc = BlocProvider.of<ServiceBlocData>(context);
    // serviceBloc.add(ServiceCompanyEvent(searchKey: companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceBlocData, ServiceState>(
      listener: (context, state) {
          if(state is getCompnySuccessState){
            print(state.company!.first.name);
            company = state.company;
            print('yes yes');
          }
          },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () { Navigator.of(context); }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
            elevation: 0,
            toolbarHeight: 33,
            backgroundColor: Colors.white,
            title:
            Text('Back'.tr(),style: TextStyle(color: Colors.black,fontSize: 15),)


          ),
          body:
          company == null ?
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(child: CircularProgressIndicator()),
              )

          : SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SizedBox(
                width: 400,
                height: 400,
                child: Container(
                    width: double.infinity,
                    child: ListView.separated(
                        itemBuilder: (context, index) => CompanyServiceData(company![index],context),
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 10,
                            ),
                        itemCount: company!.length)),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget CompanyServiceData(Company company,context) {
  return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, CompanyScreen.routeName,
              arguments: RouteArgument(param: company.id));
        },
        child: Container(
          height: 60,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffeeeeee), width: 1),
              boxShadow: [
                BoxShadow(
                    color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              company!.name!,
              style: TextStyle(color: Colors.black26),
            ),
          ),
        ),
      ));
}

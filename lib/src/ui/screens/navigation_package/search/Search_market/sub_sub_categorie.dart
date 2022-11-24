import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/search_Subcategoreis_model.dart';

import '../../../../../blocs/search/search_bloc.dart';
import '../../../../../blocs/search/search_event.dart';
import '../../../../../blocs/search/search_state.dart';
import '../../../../../data/model/Search_data.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../../component/custom/login_first_widget_sliver.dart';
import '../../../services_package/patented/patents_screen.dart';
import 'all_products.dart';

class SubSubCategories extends StatefulWidget {
  static const routeName = "/subSubCategoriesScreen";
  final RouteArgument routeArgument;

  SubSubCategories({
    required this.routeArgument,
  });

  @override
  State<SubSubCategories> createState() => _SubSubCategoriesState();
}

class _SubSubCategoriesState extends State<SubSubCategories> {
  late int id;
  late SearchBloc _searchBloc;
  List<Categories>? list;
  var _scrollController = ScrollController();

  @override
  void initState() {
    id = widget!.routeArgument!.param;
    print(id);
    print('id');
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc..add(SearchSubSubCategoriesEvent(id: id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
            Navigator.pop(context);
          },),
          title: Text('Back',style: TextStyle(color: Colors.black),),


      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if(state is SearchSubSubCategoriesSuccessState){
            // print(state.subSubCategories![0].name!);
            if (state.subSubCategories!.isEmpty) {
              list = null;
            } else {
              list = [];
              list!.clear();
              list!.addAll(state.subSubCategories!);
              _searchBloc.isFetching = false;
            }
          }
        },
        builder: (context, state) {
          return  SingleChildScrollView(
              child:  list == null
                  ? Center(child: Padding(padding: EdgeInsets.only(top: 200),child: CircularProgressIndicator(),))
                    :  SizedBox(
                      height: 900,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return SearchSubCategories(model: list![index]);
                        },
                        itemCount: list!.length, separatorBuilder: (BuildContext context, int index)  =>SizedBox(height: 10,)
                      ),
                    ));
        },
      ),
    );
  }
}
class SearchSubCategories extends StatelessWidget {
  final Categories model;
  final bool isHome;

  SearchSubCategories({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(context, AllProducts.routeName,
          arguments: RouteArgument(param: model.id));
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              clipBehavior: Clip.antiAlias,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                   border: Border.all(color: Color(0xffeeeeee), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                       color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
                  ]),
              child: Row(
                children: [
                   Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, AllProducts.routeName,
                                    arguments: RouteArgument(param: model.id));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                // color: Colors.black45,
                                ),
                                child: Image.network(model.image!.thump == null ? '${Icon(Icons.error,color: Colors.black,)}' :'${model.image!.thump}',width: 70,height: 50,),
                              ),
                            )),

                  ),
                  // SizedBox(width: 20,),
                  Expanded(
                  child:
                  Text(model.name!,style: TextStyle(color: Colors.black45,fontSize: 15),),
                  ),
                ],
              ));
        }));
  }
}

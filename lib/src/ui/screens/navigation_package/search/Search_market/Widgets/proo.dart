import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/Search_market/sub_sub_categorie.dart';

import '../../../../../../blocs/search/search_bloc.dart';
import '../../../../../../blocs/search/search_state.dart';
import '../../../../../../data/model/local/route_argument.dart';
import '../Product_Details.dart';


class Producttt extends StatefulWidget {
  static const routeName = "/Producttt";
  final RouteArgument routeArgument;

  const Producttt({required this.routeArgument});

  @override
  State<Producttt> createState() => _ProductttState();
}

class _ProductttState extends State<Producttt> {
  late int id;
  late SearchBloc _searchBloc;
  List<Product>? list;
  var _scrollController = ScrollController();

  @override
  void initState() {
    id = widget!.routeArgument!.param;
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc.add(ProducttEvent(id: id));
    print(id);
    print('djddjdjdjdjdjdj');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Back'.tr(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is ProductSuccesssState) {
            print('sdsdsssswwwwwwww');
            list = state!.products;
            if (list == null) {
              list =[];
            } else {
              list = [];
              list!.clear();
              list = state!.products;
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              controller: _scrollController,
              child: list == null
                  ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(),
                  ))
                  : list!.length== 0
                  ?Container(
                child: Center(
                  child: Padding(padding: EdgeInsets.only(top:200),
                      child: Text('empty'.tr(),style: TextStyle(
                        color: Colors.black,fontSize: 20
                      ),),),
                ),
              ) :SizedBox(
                height: 900,
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Products(model: list![index]);
                    },
                    itemCount: list!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: 10,
                        )),
              ));
        },
      ),
    );
  }
}

class Products extends StatelessWidget {
  final Product model;
  final bool isHome;

  Products({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      print('omnilalalalalaalalalalaaaaaaa');
      print(model.id);
      Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: RouteArgument(param: model));
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              clipBehavior: Clip.antiAlias,
              height: 60,
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
                          onTap: () {
                            Navigator.pushNamed(context, ProductDetails.routeName,
                                arguments: RouteArgument(param: model.id));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black45,
                            ),
                            // child: Image.network(model.images == null ? '${Icon(Icons.error,color: Colors.black,)}' :'${model!.images!}',width: 70,height: 50,),
                          ),
                        )),
                  ),
                  // SizedBox(width: 20,),
                  Expanded(
                    child: Text(
                      model.name!,
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    ),
                  ),
                ],
              ));
        }));
  }
}

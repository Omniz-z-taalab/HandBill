import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/blocs/auth/auth_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/country_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/verification_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../data/model/local/nature_of_activity_model.dart';

// class RegisterScreen extends StatefulWidget {
//   static const routeName = "/registerScreen";

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   final _passwordController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   bool _autoValidate = false, loading = false;
//   double marginVer = 24;
//   AuthBloc? _authBloc;
//   CountryModel? _countryModel;

//   @override
//   void initState() {
//     _countryModel = CountryModel(id: 0, name: translate("signup.select_country"));
//     _authBloc = BlocProvider.of<AuthBloc>(context);
//     _authBloc!.add(FetchCountriesEvent());
//     super.initState();
//   }
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     _onRegisterButtonPressed() {
//       if (_countryModel!.id == 0) {
//         Fluttertoast.showToast(msg: translate("signup.select_country"));
//       }else
//       _authBloc!.add(RegisterButtonPressed(
//           name: _nameController.text.trim(),
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//           country: _countryModel!.name!,
//           phone: _phoneController.text.trim()
//       ));
//     }
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: Colors.white,
//         body: BlocListener<AuthBloc, AuthState>(
//             listener: (BuildContext context, state) {
//               if (state is AuthLoading) {
//                 setState(() => loading = true);
//               }
//               if (state is AuthFailure) {
//                 displaySnackBar(
//                     scaffoldKey: _scaffoldKey, title: state.error ?? "error");
//                 setState(() => loading = false);
//               }
//               if (state is RegisterSuccess) {
//                 if (state.user!.isVerified == "1") {
//                   Navigator.pushNamedAndRemoveUntil(context,
//                       NavigationScreen.routeName, ModalRoute.withName('/'));
//                 } else {
//                   Navigator.pushReplacementNamed(
//                       context, VerificationScreen.routeName,
//                       arguments: RouteArgument(param: state.user!.email));
//                 }
//               }
//             },
//             child: CustomScrollView(slivers: [
//               SliverFillRemaining(
//                   child: ListView(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                     Container(
//                         width: double.infinity,
//                         // color: Colors.black12,
//                         height: size.height * 0.20,
//                         child: Center(
//                             child: Transform.scale(
//                                 scale: 0.5,
//                                 alignment: Alignment.center,
//                                 child: Image.asset(
//                                     "assets/images/hb_logo.jpeg")))),
//                     Form(
//                         key: _key,
//                         child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 24),
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomTextFormField(
//                                       hintText: translate("signup.username"),
//                                       icon: Icons.person_outline,
//                                       controller: _nameController,
//                                       validator: (input) {
//                                         if (input.toString().length < 4) {
//                                           return translate("signup.enter_user_name");
//                                         }
//                                         return null;
//                                       }),
//                                   SizedBox(height: marginVer),
//                                   Row(children: [
//                                     Expanded(
//                                         child: CustomTextFormField(
//                                             hintText: translate("signup.email"),
//                                             icon: Icons.alternate_email,
//                                             isEmail: true,
//                                             controller: _emailController,
//                                             validator: (input) {
//                                               if (!input
//                                                   .toString()
//                                                   .contains('@')) {
//                                                 return translate("signup.valid_email");
//                                               }
//                                               return null;
//                                             }))
//                                   ]),
//                                   SizedBox(height: marginVer),
//                                   Row(children: [
//                                     Expanded(
//                                         child: CustomTextFormField(
//                                             hintText:translate("signup.phone"),
//                                             icon: Icons.phone,
//                                             isEmail: true,
//                                             controller: _phoneController,
//                                             validator: (input) {
//                                               if (input
//                                                   .toString().isEmpty) {
//                                                 return translate("signup.enter_user_phone");
//                                               }
//                                               return null;
//                                             }))
//                                   ]),
//                                   SizedBox(height: marginVer),
//                                   Row(children: [
//                                     Expanded(
//                                         child: CustomTextFormField(
//                                             hintText: translate("signup.password"),
//                                             icon: Icons.lock_outline_rounded,
//                                             controller: _passwordController,
//                                             isPassword: true,
//                                             validator: (input) {
//                                               if (input.toString().length < 6) {
//                                                 return translate("signup.pass_short");
//                                               }
//                                               return null;
//                                             }))
//                                   ]),
//                                   SizedBox(height: marginVer ),
//                                   dialogFiled(
//                                       dialog: MyForm(
//                                           onSubmit: onSubmitCountry,
//                                           items: _authBloc!.countries,
//                                           label: translate("signup.countries")),
//                                       label: _countryModel!.name!,
//                                       icon: Icons.language),
//                                   SizedBox(height: marginVer * 1 +10),
//                                   Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         CustomButton(
//                                             title: translate("signup.signup"),
//                                             width: size.width * 0.7,
//                                             radius: 900,
//                                             onPress: () {
//                                               if (_key.currentState!
//                                                   .validate()) {
//                                                 _onRegisterButtonPressed();
//                                               }
//                                             }),
//                                       ]),
//                                   SizedBox(height: marginVer),
//                                 ]))),
//                     loading == false
//                         ? SizedBox()
//                         : Container(
//                             height: 80,
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   SizedBox(height: marginVer),
//                                   CircularProgressIndicator(
//                                       color: Theme.of(context).accentColor,
//                                       strokeWidth: 2)
//                                 ])),
//                   ])),
//             ])),
//         bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
//           InkWell(
//               onTap: () => Navigator.pushReplacementNamed(
//                   context, LoginScreen.routeName),
//               child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   margin: EdgeInsets.only(bottom: 10.h),
//                   decoration: BoxDecoration(
//                       color: Color(0xfffafafa),
//                       border: Border.symmetric(
//                           horizontal: BorderSide(color: Color(0xfff5f5f5)))),
//                   child: Center(
//                       child: Text(translate("signup.already_have_account"),
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black))))),
//           SizedBox(
//             height: 10.h,
//           ),
//         ]));
//   }

//   bool byAgent = true;
//   bool byVisa = false;
//   Widget dialogFiled(
//       {required Widget dialog, required String label, required IconData icon}) {
//     return InkWell(
//         onTap: () => showDialog(context: context, builder: (context) => dialog),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Row(children: [
//             Padding(
//                 padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
//                 child: Icon(icon, color: Color(0xffa8a8a8))),
//             Text(label, style: TextStyle(color: textDarkColor, fontSize: 16))
//           ]),
//           Container(width: double.infinity, height: 1, color: Color(0xffe0e0e0))
//         ]));
//   }

//   void onSubmitCountry(CountryModel model) {
//     setState(() {
//       _countryModel = model;
//     });
//   }
// }
// typedef void MyFormCallback(CountryModel result);

// class MyForm extends StatefulWidget {
//   final MyFormCallback onSubmit;
//   final List<CountryModel> items;
//   final String label;

//   MyForm({required this.label, required this.onSubmit, required this.items});

//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   int? value;
//   @override
//   Widget build(BuildContext context) {
//     if (!Platform.isIOS) {
//       return AlertDialog(
//           title: Text(widget.label),
//           content: ListView.builder(
//               itemCount: widget.items.length,
//               primary: false,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return RadioListTile(
//                   value: index,
//                   groupValue: value,
//                   onChanged: (int? ind) => setState(() => value = ind!),
//                   title: Text(widget.items[index].name ?? "name"),
//                 );
//               }),
//           actions: [
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         widget.onSubmit(widget.items[value!]);
//                       },
//                       child: new Text(translate("signup.select")))
//                 ])
//           ]);
//     }

//     // todo : showDialog for ios
//     return CupertinoAlertDialog(
//       title: Text(widget.label),
//       content: Material(
//           color: Colors.transparent,
//           child: Container(
//               height: MediaQuery.of(context).size.height / 2,
//               child: ListView.builder(
//                   itemCount: widget.items.length,
//                   primary: false,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return RadioListTile(
//                       value: index,
//                       groupValue: value,
//                       onChanged: (int? ind) => setState(() => value = ind!),
//                       title: Text(widget.items[index].name ?? "name"),
//                     );
//                   }))),
//       actions: [
//         Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     widget.onSubmit(widget.items[value!]);
//                   },
//                   child: new Text(translate("signup.select")))
//             ])
//       ],
//     );
//   }
// }

class RegisterScreen extends StatefulWidget {
  static const routeName = "/registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _namearController = TextEditingController();
  final _phoneController = TextEditingController();
  String? countryname;

  bool _autoValidate = false, loading = false;
  double marginVer = 24;
  AuthBloc? _authBloc;
  CountryModel? _countryModel;
  Color borderColor = Color(0xffBDBDBD);
  String phoneNumber = '';
  late NatureOfActivityModel _natureOfActivityModel;
  late NatureOfActivityModel _subNatureOfActivityModel;
  bool enableSubNature = false;
  String catgID = '';
  String natureactivity = '';
  List<NatureOfActivityModel> _natureOfActivityList = [
    // NatureOfActivityModel(
    //     id: 1, name: "Customs Clearance", value: "customs_clearance"),
    NatureOfActivityModel(id: 2, name: "Service Company", value: "shipping"),
    NatureOfActivityModel(id: 3, name: "Supplier", value: "Supplier")
  ];
  List<NatureOfActivityModel> _subNatureOfActivityList = [
    NatureOfActivityModel(
        id: 1,
        name: "Shipping and clearance companies",
        value: "shipping_clearance"),
    NatureOfActivityModel(
        id: 2, name: "Contracting companies", value: "contracting"),
    NatureOfActivityModel(id: 3, name: "Tourism companies", value: "tourism"),
    NatureOfActivityModel(
        id: 4, name: "Petroleum companies", value: "petroleum"),
    NatureOfActivityModel(id: 5, name: "Universities", value: "universities"),
    NatureOfActivityModel(id: 6, name: "Hospitals", value: "hospitals"),
    NatureOfActivityModel(
        id: 7, name: "Training centers", value: "training_centers"),
    NatureOfActivityModel(
        id: 8, name: "Consulting offices", value: "consulting_offices"),
    NatureOfActivityModel(
        id: 9, name: "Chartered Accountants", value: "chartered_accountants"),
    NatureOfActivityModel(id: 10, name: "Schools", value: "schools"),
  ];

  @override
  void initState() {
    _natureOfActivityModel =
        NatureOfActivityModel(id: 0, name: "Select Nature Of Activity");
    _countryModel = CountryModel(id: 0, name: "Select country");
    _subNatureOfActivityModel =
        NatureOfActivityModel(id: 0, name: "Select Sub Nature Of Activity");

    _countryModel = CountryModel(id: 0, name: "signup.select_country".tr());
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc!.add(FetchCountriesEvent());
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void onSubmitNatureOfActivity(NatureOfActivityModel model) {
    setState(() {
      _natureOfActivityModel = model;
      if (model.value == "shipping") {
        enableSubNature = true;
        natureactivity = 'shipping';
      } else {
        enableSubNature = false;
        natureactivity = 'customs_clearance';
        catgID = '1';
      }
    });
  }

  void onSubmitSubNatureOfActivity(NatureOfActivityModel model) {
    setState(() {
      _subNatureOfActivityModel = model;
    });
  }

  bool _obscureText = true;

  late String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(
            listener: (BuildContext context, state) {
              if (state is AuthLoading) {
                setState(() => loading = true);
              }
              if (state is AuthFailure) {
                Fluttertoast.showToast(
                    msg: state.error ?? '',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                setState(() => loading = false);
              }
              if (state is RegisterSuccess) {
                if (state.user!.isVerified == "1") {
                  Navigator.pushNamedAndRemoveUntil(context,
                      NavigationScreen.routeName, ModalRoute.withName('/'));
                } else {
                  Navigator.pushReplacementNamed(
                      context, VerificationScreen.routeName,
                      arguments: RouteArgument(param: state.user!.email));
                }
              }
            },
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                  child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Container(
                        width: double.infinity,
                        // color: Colors.black12,
                        height: size.height * 0.20,
                        child: Center(
                            child: Transform.scale(
                                scale: 0.5,
                                alignment: Alignment.center,
                                child: Image.asset(
                                    "assets/images/hb_logo2.jpeg")))),
                    Form(
                        key: _key,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFormField(
                                      hintText: "username".tr(),
                                      icon: Icons.person_outline,
                                      controller: _nameController,
                                      validator: (input) {
                                        if (input.toString().length < 4) {
                                          return "enter_user_name".tr();
                                        }
                                        return null;
                                      }),
                                  SizedBox(height: marginVer),
                                  CustomTextFormField(
                                      hintText: "ArabicName".tr(),
                                      icon: Icons.person_outline,
                                      controller: _namearController,
                                      validator: (input) {
                                        if (input.toString().length < 4) {
                                          return "enter_arabic_name".tr();
                                        }
                                        return null;
                                      }),
                                  SizedBox(height: marginVer),

                                  Row(children: [
                                    Expanded(
                                        child: CustomTextFormField(
                                            hintText: "email".tr(),
                                            icon: Icons.alternate_email,
                                            isEmail: true,
                                            controller: _emailController,
                                            validator: (input) {
                                              if (!input
                                                  .toString()
                                                  .contains('@')) {
                                                return "valid_email".tr();
                                              }
                                              return null;
                                            }))
                                  ]),
                                  SizedBox(height: marginVer),
                                  // Row(children: [
                                  //   Expanded(
                                  //       child: CustomTextFormField(
                                  //           hintText: translate("signup.phone"),
                                  //           icon: Icons.phone,
                                  //           isEmail: true,
                                  //           controller: _phoneController,
                                  //           validator: (input) {
                                  //             if (input.toString().isEmpty) {
                                  //               return translate(
                                  //                   "signup.enter_user_phone");
                                  //             }
                                  //             return null;
                                  //           }))
                                  // ]),
                                  // Row(children: [
                                  //   Expanded(
                                  //       child: CustomTextFormField(

                                  //           hintText:
                                  //               translate("signup.password"),
                                  //           icon: Icons.lock_outline_rounded,
                                  //           controller: _passwordController,
                                  //           isPassword: true,
                                  //           validator: (input) {
                                  //             if (input.toString().length < 6) {
                                  //               return translate(
                                  //                   "signup.pass_short");
                                  //             }
                                  //             return null;
                                  //           }))
                                  // ]),
                                  Row(children: [
                                    Expanded(
                                        child: TextFormField(
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                      obscureText: _obscureText,
                                      // keyboardType:
                                      //     widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_outline_rounded,
                                          ),
                                          suffixIcon: _obscureText
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.visibility,
                                                  ),
                                                  onPressed: _toggle,
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                      Icons.visibility_off,
                                                      color: Colors.blue),
                                                  onPressed: _toggle,
                                                ),
                                          border: new UnderlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: borderColor)),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: borderColor)),
                                          // contentPadding: EdgeInsets.all(0),
                                          hintText: "password".tr(),
                                          hintStyle:
                                              TextStyle(color: textLiteColor)),
                                      controller: _passwordController,

                                      // onSaved: (input) => widget.onSave!(input),
                                      validator: (input) {
                                        if (input.toString().length < 6) {
                                          return "pass_short".tr();
                                        }
                                        return null;
                                      },
                                    ))
                                  ]),
                                  SizedBox(height: marginVer),
                                  // new Container(
                                  //   child: new Column(
                                  //     children: <Widget>[
                                  //       new TextFormField(
                                  //         decoration: const InputDecoration(
                                  //             labelText: 'Password',
                                  //             icon: const Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.only(
                                  //                         top: 15.0),
                                  //                 child:
                                  //                     const Icon(Icons.lock))),
                                  //         validator: (val) => val!.length < 6
                                  //             ? 'Password too short.'
                                  //             : null,
                                  //         onSaved: (val) => _password = val!,
                                  //         obscureText: _obscureText,
                                  //       ),
                                  //       new FlatButton(
                                  //           onPressed: _toggle,
                                  //           child: new Text(
                                  //               _obscureText ? "Show" : "Hide"))
                                  //     ],
                                  //   ),
                                  // ),
                                  Row(children: [
                                    Expanded(
                                        child: CustomTextFormField(
                                            hintText: "toast_sure".tr(),
                                            icon: Icons.lock_outline_rounded,
                                            controller:
                                                _confirmpasswordController,
                                            isPassword: true,
                                            validator: (input) {
                                              if (input.toString().length < 6) {
                                                return "pass_short".tr();
                                              }
                                              return null;
                                            }))
                                  ]),

                                  SizedBox(height: marginVer),

                                  // Row(children: [
                                  //   Expanded(
                                  //       child: CustomTextFormField(
                                  //           hintText: translate(
                                  //               "signup.password_sure"),
                                  //           icon: Icons.lock_outline_rounded,
                                  //           controller: _passwordController,
                                  //           isPassword: true,
                                  //           validator: (input) {
                                  //             if (input.toString().length < 6) {
                                  //               return translate(
                                  //                   "signup.pass_short");
                                  //             }
                                  //             return null;
                                  //           }))
                                  // ]),
                                  // SizedBox(height: marginVer),
                                  // dialogFiled(
                                  //     dialog: MyForm(
                                  //         onSubmit: onSubmitCountry,
                                  //         items: _authBloc!.countries,
                                  //         label: translate("signup.countries")),
                                  //     label: _countryModel!.name!,
                                  //     icon: Icons.language),

                                  ////////////////////////////////////////////////
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     showCountryPicker(
                                  //       context: context,
                                  //       //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                  //       exclude: <String>['KN', 'MF'],
                                  //       favorite: <String>['SE'],
                                  //       //Optional. Shows phone code before the country name.
                                  //       showPhoneCode: true,
                                  //       onSelect: (Country country) {
                                  //         setState(() {
                                  //           countryname = country.displayName;
                                  //           print(countryname);
                                  //         });
                                  //       },
                                  //       // Optional. Sets the theme for the country list picker.
                                  //       countryListTheme: CountryListThemeData(
                                  //         // Optional. Sets the border radius for the bottomsheet.
                                  //         borderRadius: BorderRadius.only(
                                  //           topLeft: Radius.circular(40.0),
                                  //           topRight: Radius.circular(40.0),
                                  //         ),
                                  //         // Optional. Styles the search field.
                                  //         inputDecoration: InputDecoration(
                                  //           labelText: 'Search',
                                  //           hintText: 'Start typing to search',
                                  //           prefixIcon:
                                  //               const Icon(Icons.search),
                                  //           border: OutlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //               color: const Color(0xFF8C98A8)
                                  //                   .withOpacity(0.2),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: const Text('Show country picker'),
                                  // ),

                                  IntlPhoneField(
                                    // initialCountryCode: 'EG',
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.phone),
                                      hintText: "phone".tr(),
                                      hintStyle:
                                          TextStyle(color: textLiteColor),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: borderColor)),
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: borderColor)),
                                    ),
                                    onChanged: (phone) {
                                      // print(phone.completeNumber);
                                      setState(() {
                                        phoneNumber = phone.completeNumber;
                                        print(phoneNumber);
                                      });
                                    },
                                    onCountryChanged: (country) {
                                      print('Country changed to: ' +
                                          country.name);
                                      setState(() {
                                        countryname = country.name;
                                      });
                                    },
                                  ),
                                  // SizedBox(height: marginVer),
                                  // dialogFiled(
                                  //     dialog: NatureOfActivityForm(
                                  //         onSubmit: onSubmitNatureOfActivity,
                                  //         items: _natureOfActivityList,
                                  //         label: "Nature of the activity"),
                                  //     label: _natureOfActivityModel.name!,
                                  //     icon: Icons.work_outline_outlined),
                                  // if (enableSubNature) ...[
                                  //   SizedBox(height: marginVer),
                                  //   dialogFiled(
                                  //       dialog: NatureOfActivityForm(
                                  //           onSubmit:
                                  //               onSubmitSubNatureOfActivity,
                                  //           items: _subNatureOfActivityList,
                                  //           label:
                                  //               "Sub Nature of the activity"),
                                  //       label: _subNatureOfActivityModel.name!,
                                  //       icon: Icons.work_outline_outlined),
                                  // ],

                                  SizedBox(height: marginVer * 1 + 10),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                            title: "signup",
                                            width: size.width * 0.7,
                                            radius: 900,
                                            onPress: () {
                                              if (_key.currentState!
                                                  .validate()) {
                                                print(countryname);
                                                _authBloc!.add(
                                                    RegisterButtonPressed(
                                                        namear: _namearController.text,
                                                        confirimpassword: _passwordController.text,
                                                        name: _nameController.text,
                                                        email: _emailController.text,
                                                        password: _passwordController.text,
                                                        country: countryname!,
                                                        phone: phoneNumber));
                                              }
                                            }),
                                      ]),
                                  SizedBox(height: marginVer),
                                ]))),
                    loading == false
                        ? SizedBox()
                        : Container(
                            height: 80,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: marginVer),
                                  CircularProgressIndicator(
                                      color: Theme.of(context).accentColor,
                                      strokeWidth: 2)
                                ])),
                  ])),
            ])),
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
              onTap: () => Navigator.pushReplacementNamed(
                  context, LoginScreen.routeName),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                      color: Color(0xfffafafa),
                      border: Border.symmetric(
                          horizontal: BorderSide(color: Color(0xfff5f5f5)))),
                  child: Center(
                      child: Text("already_have_account".tr(),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black))))),
          SizedBox(
            height: 10.h,
          ),
        ]));
  }

  bool byAgent = true;
  bool byVisa = false;

  Widget dialogFiled(
      {required Widget dialog, required String label, required IconData icon}) {
    return InkWell(
        onTap: () => showDialog(context: context, builder: (context) => dialog),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                child: Icon(icon, color: Color(0xffa8a8a8))),
            Text(label, style: TextStyle(color: textDarkColor, fontSize: 16))
          ]),
          Container(width: double.infinity, height: 1, color: Color(0xffe0e0e0))
        ]));
  }

  void onSubmitCountry(CountryModel model) {
    setState(() {
      _countryModel = model;
    });
    // typedef void MyFormCallback(CountryModel result);
  }

// typedef void MyFormCallback(CountryModel result);

}

typedef void MyFormCallback(CountryModel result);

class MyForm extends StatefulWidget {
  final MyFormCallback onSubmit;
  final List<CountryModel> items;
  final String label;

  MyForm({required this.label, required this.onSubmit, required this.items});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  int? value;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
          title: Text(widget.label),
          content: ListView.builder(
              itemCount: widget.items.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index,
                  groupValue: value,
                  onChanged: (int? ind) => setState(() => value = ind!),
                  title: Text(widget.items[index].name ?? "name"),
                );
              }),
          actions: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onSubmit(widget.items[value!]);
                      },
                      child: new Text("signup.select".tr()))
                ])
          ]);
    }

    // todo : showDialog for ios
    return CupertinoAlertDialog(
      title: Text(widget.label),
      content: Material(
          color: Colors.transparent,
          child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  itemCount: widget.items.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      value: index,
                      groupValue: value,
                      onChanged: (int? ind) => setState(() => value = ind!),
                      title: Text(widget.items[index].name ?? "name"),
                    );
                  }))),
      actions: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSubmit(widget.items[value!]);
                  },
                  child: new Text("signup.select".tr()))
            ])
      ],
    );
  }
}

typedef void MyFormNatureOfActivityCallback(NatureOfActivityModel result);

class NatureOfActivityForm extends StatefulWidget {
  final MyFormNatureOfActivityCallback onSubmit;
  final List<NatureOfActivityModel> items;
  final String label;

  NatureOfActivityForm(
      {required this.label, required this.onSubmit, required this.items});

  @override
  _NatureOfActivityFormState createState() => _NatureOfActivityFormState();
}

class _NatureOfActivityFormState extends State<NatureOfActivityForm> {
  int? value;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return SimpleDialog(title: Text(widget.label), children: <Widget>[
        Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RadioListTile(
                value: index,
                groupValue: value,
                onChanged: (int? ind) => setState(() {
                  value = ind;
                  print(value.toString());
                  if (value.toString() == 0) {
                  } else if (value.toString() == 1) {}
                }),
                title: Text(widget.items[index].name!),
              );
            },
            itemCount: widget.items.length,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onSubmit(widget.items[value!]);
            },
            child: new Text("Select"))
      ]);
    }

    // todo : showDialog for ios
    return CupertinoAlertDialog(
      title: Text(widget.label),
      content: Material(
          color: Colors.transparent,
          child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  itemCount: widget.items.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      value: index,
                      groupValue: value,
                      onChanged: (int? ind) => setState(() {
                        value = ind;
                        print(value.toString());
                        if (value == 0) {
                        } else if (value == 1) {}
                      }),
                      title: Text(widget.items[index].name ?? "name"),
                    );
                  }))),
      actions: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSubmit(widget.items[value!]);
                  },
                  child: new Text("Select"))
            ])
      ],
    );
  }
}

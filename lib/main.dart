import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/blocs/Companies/bloc.dart';
import 'package:hand_bill/src/blocs/Services/bloc.dart';
import 'package:hand_bill/src/blocs/about_us_bloc/about_us_bloc.dart';
import 'package:hand_bill/src/blocs/about_us/abouUsBloc.dart';
import 'package:hand_bill/src/blocs/assets/assets_bloc.dart';
import 'package:hand_bill/src/blocs/auction/aucations_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';
import 'package:hand_bill/src/blocs/chat/chat_bloc.dart';
import 'package:hand_bill/src/blocs/company/company_bloc.dart';
import 'package:hand_bill/src/blocs/explore/explore_bloc.dart';
import 'package:hand_bill/src/blocs/favorite/favorite_bloc.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_bloc.dart';
import 'package:hand_bill/src/blocs/help/help_bloc.dart';
import 'package:hand_bill/src/blocs/home/home_bloc.dart';
import 'package:hand_bill/src/blocs/job/job_bloc.dart';
import 'package:hand_bill/src/blocs/notification/notifications_bloc.dart';
import 'package:hand_bill/src/blocs/offer/offers_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_bloc.dart';
import 'package:hand_bill/src/blocs/products/products_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_bloc.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/common/routes.dart';
import 'package:hand_bill/src/helper/helpers.dart';
import 'package:hand_bill/src/repositories/global_repository.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/register_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/ShippingBloc%20/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  String? lang = await storage.read(key: "lang");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp();

  runApp(EasyLocalization(
      path: 'assets/translate',
      supportedLocales: const [

        Locale('en','US'),
        Locale('ar','EG'),
        // Locale.fromSubtags(languageCode: 'ar')
      ],
      fallbackLocale: Locale( lang == null ? 'en' : lang),// <-- change the path of the translation files
      child: Phoenix(child: MyApp())

  ));
}

class MyApp extends StatelessWidget {
  final GlobalRepository _globalRepository = GlobalRepository();

  @override
  Widget build(BuildContext context) {
    Helper.chaneStatusBarColor(
        statusBarColor: Colors.white, brightness: Brightness.dark);
    // Helper.chaneStatusBarColor(
    //     statusBarColor: mainColorLite, brightness: Brightness.light);
    return
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GlobalBloc()..add(StartAppEvent())),
            // BlocProvider(create: (context) => GlobalBloc()..add(SaveLanguageEvent())),
            BlocProvider(create: (context) => AuthBloc(context: context)),
            BlocProvider(create: (context) => ExploreBloc(context: context)),
            BlocProvider(create: (context) => NotificationsBloc(context: context)),
            BlocProvider(create: (context) => FavoriteBloc(context: context)),
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => ServiceBloc(context: context),),
            BlocProvider(create: (context) => ServiceBlocData(context: context)),
            BlocProvider(create: (context) => JobsBloc(context: context)),
            BlocProvider(create: (context) => AuctionsBloc(context: context)),
            BlocProvider(create: (context) => OffersBloc(context: context)),
            BlocProvider(create: (context) => ProductsBloc(context: context)),
            BlocProvider(create: (context) => CompanyBloc()),
            BlocProvider(create: (context) => SearchBloc(context: context)),
            BlocProvider(create: (context) => ChatBloc()),
            BlocProvider(create: (context) => HelpBloc(context: context)),
            BlocProvider(create: (context) => OtherCompanyBloc(context: context)),
            BlocProvider(create: (context) => AssetsBloc(context: context)),
            BlocProvider(create: (context) => PatentsBloc(context: context)),
            BlocProvider(create: (context) => HandmadeBloc(context: context)),
            BlocProvider(create: (context) => ProfileBloc(context: context)),
            BlocProvider(create: (context) => ProfileBloc(context: context)),
            BlocProvider(create: (context) => CategoryBloc()),
            BlocProvider(create: (context) => AboutUsBloc()),
            BlocProvider(create: (context) => ShippingBloc()),
          ],
          child:
          BlocBuilder<GlobalBloc, GlobalState>(
              builder: (BuildContext context, state) {
                if (state is StartAppSuccess) {
                  // print("${state.user!.name}");
                }
                return ScreenUtilInit(
                  designSize: const Size(375, 812),
                  builder: (context, child) => MaterialApp(
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      title: 'Handbill',
                      debugShowCheckedModeBanner: false,
                      theme: _globalRepository.liteTheme,
                      themeMode: ThemeMode.light,
                      locale: context.locale,
                      // supportedLocales: [
                      //   const Locale('en'),
                      //   const Locale('ar'),
                      //   const Locale('es'),
                      //   const Locale('de'),
                      //   const Locale('fr'),
                      //   const Locale('el'),
                      //   const Locale('et'),
                      //   const Locale('nb'),
                      //   const Locale('nn'),
                      //   const Locale('pl'),
                      //   const Locale('pt'),
                      //   const Locale('ru'),
                      //   const Locale('hi'),
                      //   const Locale('ne'),
                      //   const Locale('uk'),
                      //   const Locale('hr'),
                      //   const Locale('tr'),
                      //   const Locale('lv'),
                      //   const Locale('lt'),
                      //   const Locale('ku'),
                      //   const Locale.fromSubtags(
                      //       languageCode: 'zh',
                      //       scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
                      //   const Locale.fromSubtags(
                      //       languageCode: 'zh',
                      //       scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
                      // ],
                      home: SplashPage(),
                      // home: ServicesCompanyDetailsScreen(routeArgument: RouteArgument(param: 1),),
                      onGenerateRoute: RouteGenerator.generateRoute),
                );
              }));
  }
}
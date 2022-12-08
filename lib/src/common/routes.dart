import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/component/custom/custom_page_route.dart';
import 'package:hand_bill/src/ui/screens/account_package/agents/agents_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/sub_category_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/sub_sub_categories.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/Search_market/Widgets/proo.dart';
import 'package:hand_bill/src/ui/screens/services_package/asstes/assets_details_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/asstes/assets_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/auctions/auction_details_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/auctions/auctions_screen.dart';
import 'package:hand_bill/src/ui/screens/account_package/edit_account_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/customs/customs_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/hand_made_details_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/hand_made_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/handmade_add_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/my_handmade_screen.dart';
import 'package:hand_bill/src/ui/screens/account_package/help/help_center_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/jobs_add_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/jobs_company_details_screens.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/jobs_user_details_screens.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/companies_jobs_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/my_jobs_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/offers/offers_details_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/offers/offers_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/my_patents_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patented_add_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patented_details_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_details_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_service/shipping_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/auth_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/forget_password_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/register_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/rest_password_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/verification_screen.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/product_details/product_details_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/notification/notification_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/subcategory_products/products_screen.dart';
import 'package:hand_bill/src/ui/screens/account_package/wishlist/wishlist_screen.dart';

import '../ui/screens/account_package/aboutUs/aboutUsScreen.dart';
import '../ui/screens/navigation_package/categories/component/sub_cat.dart';
import '../ui/screens/navigation_package/search/Search_market/CompanySearchScreen.dart';
import '../ui/screens/navigation_package/search/Search_market/all_products.dart';
import '../ui/screens/navigation_package/search/Search_market/Product_Details.dart';
import '../ui/screens/navigation_package/search/Search_market/search_screen1.dart';
import '../ui/screens/navigation_package/search/Search_market/sub_categoies_screen.dart';
import '../ui/screens/navigation_package/search/Search_market/sub_sub_categorie.dart';
import '../ui/screens/navigation_package/search/search_service/company_service_screen.dart';
import '../ui/screens/services_package/shipping/Service_first_company.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments as RouteArgument?;
    switch (settings.name) {
      case ForgetPasswordScreen.routeName:
        return CustomPageRoute(widget: ForgetPasswordScreen());
      case RestPasswordScreen.routeName:return CustomPageRoute(widget: RestPasswordScreen());
      case CompanyServiceScreen.routeName:return CustomPageRoute(widget: CompanyServiceScreen(routeArgument: args!));
      case LoginScreen.routeName:return CustomPageRoute(widget: LoginScreen());
      case Producttt.routeName:return CustomPageRoute(widget: Producttt(routeArgument: args!));
      case RegisterScreen.routeName:
        return CustomPageRoute(widget: RegisterScreen());
      case VerificationScreen.routeName:
        return CustomPageRoute(widget: VerificationScreen(routeArgument: args));
      case NavigationScreen.routeName:
        return CustomPageRoute(widget: NavigationScreen());
      case AuthScreen.routeName:
        return CustomPageRoute(widget: AuthScreen());
      // case SearchCompanyScreen.routeName:
      //   return CustomPageRoute(widget: SearchCompanyScreen());
      // case ChatsScreen.routeName:
      //   return CustomPageRoute(widget: ChatsScreen());
      case EditAccountScreen.routeName:
        return CustomPageRoute(widget: EditAccountScreen());
      case AuctionsScreen.routeName:
        return CustomPageRoute(widget: AuctionsScreen());
      case WishListScreen.routeName:
        return CustomPageRoute(widget: WishListScreen());
      case HelpCenterScreen.routeName:
        return CustomPageRoute(widget: HelpCenterScreen());
      case AgentsScreen.routeName:return CustomPageRoute(widget: AgentsScreen());
      case ProductDetails.routeName:return CustomPageRoute(widget: ProductDetails(routeArgument: args!,));
      case AllProducts.routeName:return CustomPageRoute(widget: AllProducts(routeArgument: args!,));
      case AboutUsScreen.routeName:return CustomPageRoute(widget: AboutUsScreen());
      case SubCategoriesScreen.routeName:return CustomPageRoute(widget: SubCategoriesScreen(routeArgument: args!));
      case SubSubCategories.routeName:return CustomPageRoute(widget: SubSubCategories(routeArgument: args!));
      case ProductDetailsScreen.routeName:
        return CustomPageRoute(
            widget: ProductDetailsScreen(routeArgument: args!));
      case CompanyScreen.routeName:
        return CustomPageRoute(widget: CompanyScreen(routeArgument: args!));
      case ProductsScreen.routeName:return CustomPageRoute(widget: ProductsScreen(routeArgument: args!));
      case CompanySearchScreen.routeName:return CustomPageRoute(widget: CompanySearchScreen(routeArgument: args!));
      case SearchScreen.routeName:
        return CustomPageRoute(widget: SearchByCategoriesScreen());
      // case InboxScreen.routeName:
      //   return CustomPageRoute(widget: InboxScreen(routeArgument: args!));
      case CompaniesJobsScreen.routeName:
        return CustomPageRoute(widget: CompaniesJobsScreen());
      case JobUserDetailsScreen.routeName:
        return CustomPageRoute(
            widget: JobUserDetailsScreen(routeArgument: args!));
      case JobCompanyDetailsScreen.routeName:
        return CustomPageRoute(
            widget: JobCompanyDetailsScreen(routeArgument: args!));
      case JobAddScreen.routeName:
        return CustomPageRoute(widget: JobAddScreen(routeArgument: args));
      case MyJobsScreen.routeName:
        return CustomPageRoute(widget: MyJobsScreen());
      // return PageRouteBuilder(pageBuilder: (_, __, ___) => JobsScreen());
      case AuctionDetailsScreen.routeName:
        return CustomPageRoute(
            widget: AuctionDetailsScreen(routeArgument: args!));
      case OffersScreen.routeName:
        return CustomPageRoute(widget: OffersScreen());
      case OfferDetailsScreen.routeName:
        return CustomPageRoute(
            widget: OfferDetailsScreen(routeArgument: args!));
      case ShippingScreen.routeName:
        return CustomPageRoute(
            widget: ShippingScreen(
          routeArgument: args,
        ));
      case CustomsScreen.routeName:
        return CustomPageRoute(widget: CustomsScreen());
      case ServicesCompanyDetailsScreen.routeName:
      // return CustomPageRoute(
      //     widget: ServicesCompanyDetailsScreen(routeArgument: args!));
      case AssetsScreen.routeName:
        return CustomPageRoute(widget: AssetsScreen());
      case AssetsDetailsScreen.routeName:
        return CustomPageRoute(
            widget: AssetsDetailsScreen(routeArgument: args!));
      case PatentsScreen.routeName:
        return CustomPageRoute(widget: PatentsScreen());
      case PatentedDetailsScreen.routeName:
        return CustomPageRoute(
            widget: PatentedDetailsScreen(routeArgument: args!));
      case MyPatentsScreen.routeName:
        return CustomPageRoute(widget: MyPatentsScreen());
      case PatentedAddScreen.routeName:
        return CustomPageRoute(widget: PatentedAddScreen(routeArgument: args));
      case HandmadeScreen.routeName:
        return CustomPageRoute(widget: HandmadeScreen());
      case HandmadeDetailsScreen.routeName:
        return CustomPageRoute(
            widget: HandmadeDetailsScreen(routeArgument: args!));
      case MyHandmadeScreen.routeName:
        return CustomPageRoute(widget: MyHandmadeScreen());
      case HandmadeAddScreen.routeName:
        return CustomPageRoute(widget: HandmadeAddScreen(routeArgument: args));
      case ImageFullScreen.routeName:
        return CustomPageRoute(widget: ImageFullScreen(routeArgument: args));
      case SubCategories.routeName:return CustomPageRoute(widget: SubCategories(routeArgument: args));
      case ServiceFirstCompany.routeName:return CustomPageRoute(widget: ServiceFirstCompany(routeArgument: args));
      case SubSubCatScreen.routeName:
        return CustomPageRoute(widget: SubSubCatScreen(routeArgument: args));
    }
  }
}

class APIData {
  static const domainLink = "https://test.hand-bill.com/";
  static const domainLinkApi = "https://test.hand-bill.com/api/";

  static const secretKey = "5aoIrZjQvSPA2K3po1HeKHZHowNQdTOPrGQ1Ze0";

  //auth
  static const login = domainLinkApi + 'user/login';
  static const register = domainLinkApi + 'user/register';
  static const restPassword = domainLinkApi + 'user/reset';
  static const forgetPassword = domainLinkApi + 'user/forgot-password';
  static const checkVerificationCode = domainLinkApi + 'user/check-code';
   static const getCountries = domainLinkApi + 'company/countries';
   // Fluttertoast.showToast(
   //                  msg: state.message ?? '',
   //                  toastLength: Toast.LENGTH_SHORT,
   //                  gravity: ToastGravity.CENTER,
   //                  timeInSecForIosWeb: 1,
   //                  backgroundColor: Colors.green,
   //                  textColor: Colors.white,
   //                  fontSize: 16.0
   //              );
  //home
  static const getSliders = domainLinkApi + 'user/top-banners';
  static const getTopCompanies = domainLinkApi + 'user/top-companies';
  static const getPopular = domainLinkApi + 'user/top-products';
  static const userProfile = domainLinkApi + 'user/profile';
  static const editProfile = domainLinkApi + 'user/edit';
  static const changePassword = domainLinkApi + 'user/change-password';

  // categories
  static const getCategories = domainLinkApi + 'user/categories';
  static const getSubCategories = domainLinkApi + 'user/sub-categories';
  static const getSubCategory = domainLinkApi + 'user/subcate-by-cate';
  static const getSubsubCategory = domainLinkApi + 'user/subsubcate-by-subcate';

  // notifications
  static const getNotificationsData = domainLinkApi + 'user/notifications';
  static const removeFromNotifications = domainLinkApi + 'user/notifications';
  static const markReadNotifications = domainLinkApi + 'user/notifications';

  // patents
  static const getAllPatents = domainLinkApi + 'user/patents';
  static const getMyPatents = domainLinkApi + 'user/my-patents';
  static const addPatented = domainLinkApi + 'user/patents';
  static const editPatented = domainLinkApi + 'user/patents';
  static const removePatented = domainLinkApi + 'user/remove-patent';

  // handmade
   static const getAllHandmade = domainLinkApi + 'user/hand-made';
  static const myHandmade = domainLinkApi + 'user/my-hand-made';
  static const addHandmade = domainLinkApi + 'user/hand-made';
  static const editHandmade = domainLinkApi + 'user/hand-made';
  static const removeHandmade = domainLinkApi + 'user/remove-hand-made';

  // jobs
  static const getCompaniesJobs = domainLinkApi + 'user/companies-jobs';
  static const getMyJobs = domainLinkApi + 'user/my-user-jobs';
  static const getJobsCategories = domainLinkApi + 'user/categories-jobs';
  static const getJobsSubCategories =
      domainLinkApi + 'user/sub-categories-jobs';
  static const addJob = domainLinkApi + 'user/users-jobs';
  static const editJob = domainLinkApi + 'user/users-jobs';
  static const removeJob = domainLinkApi + 'user/remove-job';

  // agent
  static const getAllAgent = domainLinkApi + 'user/agents';

  // auction
  static const getAuctionsData = domainLinkApi + 'user/auctions';

  // shipping
  // static const getShippingCompanies = domainLinkApi + 'user/other-companies';
  static const getShippingCompanies = domainLinkApi + 'user/companies-services/category/';

  // customs
  static const getCustomsCompanies = domainLinkApi + 'user/other-companies';

  // offer
  static const getOffersData = domainLinkApi + 'user/offers';

  // assets
  static const getAssetsData = domainLinkApi + 'user/assets';

  // favorite
  static const addToFavorite = domainLinkApi + 'user/favourites';
  static const favouriteProduct = domainLinkApi + 'user/favourites';
  static const removeFromFavorite = domainLinkApi + 'user/favourites';
  static const checkIsFavorite = domainLinkApi + 'favorites/exist';

  // product
  static const productBySubCategory = domainLinkApi + 'user/products/2';
  static const getFeatured = domainLinkApi + 'foods';
  static const productDetails = domainLinkApi + 'user/products/';
  static const productDetailss = domainLinkApi + 'user/products';
  static const productOfCompany = domainLinkApi + 'user/products-companies';

  // company
  static const getCompanyDetails = domainLinkApi + 'user/details-company';
  static const getFeaturedProductOfCompany = domainLinkApi + 'user/featured-products-companies';
  static const getCompanyProducts = domainLinkApi + 'user/products-companies';
  static const getCompanyCategories = domainLinkApi + 'user/service-categories';

  //search
  static const searchCategories = domainLinkApi + 'user/categories';
  static const searchSubCategories = domainLinkApi + 'user/subcate-by-cate';
  // https://test.hand-bill.com/api/user/products?sub_sub_category_id=20
  static const searchSubSubCategories = domainLinkApi + 'user/subsubcate-by-subcate';
  static const searchProduct = domainLinkApi + 'user/search-products';
  static const searchCompanies = domainLinkApi + 'user/search-companies-services';
  // aboutUs
  static const getAboutItem = domainLinkApi + 'user/setting/about-us';
  // // profile

  static const getProfile = domainLinkApi + 'user/profile-page';

  // Help Cernter
  static const helpCenter = domainLinkApi + 'user/help-center';

//banners
  static const CategoryProductBanner = domainLinkApi + 'user/top-banners-sub-category-products';
  static const ServiceBanner = domainLinkApi + 'user/top-banners-sub-category-services';

}

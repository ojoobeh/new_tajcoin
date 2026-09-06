
import 'package:get/get.dart' show GetPage;
import 'package:webazin/pages/pages_cuntact_us/binding/pages_cuntact_us_binding.dart';
import 'package:webazin/pages/pages_cuntact_us/view/pages_cuntact_us_view.dart';

import '../pages/affiliate/bindings/affiliate_binding.dart';
import '../pages/affiliate/views/affiliate_view.dart';
import '../pages/answers_tickets/bindings/answers_tickets_binding.dart';
import '../pages/answers_tickets/views/answer_tickets_view.dart';
import '../pages/auth/bindings/auth_binding.dart';
import '../pages/auth/views/forgot_password_step1_view.dart';
import '../pages/auth/views/forgot_password_step2_view.dart';
import '../pages/auth/views/google_verification_view.dart';
import '../pages/auth/views/login_view.dart';
import '../pages/auth/views/phone_verification_view.dart';
import '../pages/auth/views/register_view.dart';
import '../pages/authentications/bindings/authentication_binding.dart';
import '../pages/authentications/views/authentication_password_view.dart';
import '../pages/authentications/views/authentication_view.dart';
import '../pages/bankCard/bindings/bankCardBinding.dart';
import '../pages/bankCard/views/bankCardView.dart';
import '../pages/calculator/binding/calculator_binding.dart';
import '../pages/calculator/view/calculator_view.dart';
import '../pages/finger_print/bindings/finger_print_binding.dart';
import '../pages/finger_print/views/finger_print_view.dart';
import '../pages/history/bindings/history_binding.dart';
import '../pages/history/views/history_list_view.dart';
import '../pages/home_all_currency/bindings/home_all_order_binding.dart';
import '../pages/home_all_currency/views/home_all_order_view.dart';
import '../pages/market_all_order/bindings/market_all_order_binding.dart';
import '../pages/market_all_order/views/market_all_order_view.dart';
import '../pages/more/binding/more_binding.dart';
import '../pages/more/view/more_view.dart';
import '../pages/order/bindings/order_binding.dart';
import '../pages/order/views/order_list_view.dart';
import '../pages/pages/binding/pages_binding.dart';
import '../pages/pages/view/pagesView.dart';
import '../pages/pages_more/binding/pages_more_binding.dart';
import '../pages/pages_more/view/pages_more_view.dart';
import '../pages/profile/bindings/profile_binding.dart';
import '../pages/profile/views/profile_view.dart';
import '../pages/root/bindings/root_binding.dart';
import '../pages/root/views/root_view.dart';
import '../pages/setting_sms/bindings/setting_sms_binding.dart';
import '../pages/setting_sms/views/setting_sms_view.dart';
import '../pages/settings/bindings/settings_binding.dart';
import '../pages/settings/views/settings_view.dart';
import '../pages/tickets/bindings/tickets_binding.dart';
import '../pages/tickets/views/tickets_view.dart';
import '../pages/vip_packs/binding/vip_packs_binding.dart';
import '../pages/vip_packs/view/vip_packs_view.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(name: Routes.ROOT, page: () => RootView(), binding: RootBinding()),
    GetPage(name: Routes.FINGERPRINT, page: () => FingerPrintView(), binding: FingerPrintBinding()),
    GetPage(name: Routes.TicketS, page: () => TicketsView(), binding: TicketsBinding()),
    GetPage(name: Routes.ORDER, page: () => OrderListView(), binding: OrderCardBinding()),
    GetPage(name: Routes.MARKETALLORDER, page: () => MarketAllOrderView(), binding: MarketAllOrderBinding()),
    GetPage(name: Routes.CALCULATOR, page: () => CalculatorView(), binding: CalculatorBinding()),
    GetPage(name: Routes.HISTORY, page: () => HistoryListView(), binding: HistoryCardBinding()),
    GetPage(name: Routes.BANKCARD, page: () => BankCardView(), binding: BankCardBinding()),
    GetPage(name: Routes.ANSWERSTicketS, page: () => AnswerTicketsView(), binding: AnswersTicketsBinding()),
    GetPage(name: Routes.AFFILIATE, page: () => AffiliateView(), binding: AffiliateBinding()),
    GetPage(name: Routes.SETTINGS, page: () => SettingsView(), binding: SettingsBinding()),
    GetPage(name: Routes.VIPPACKS, page: () => VipPacksView(), binding: VipPacksBinding()),
    GetPage(name: Routes.SETTINGSMS, page: () => SettingSmsView(), binding: SettingSmsBinding()),
    GetPage(name: Routes.PROFILE, page: () => ProfileView(), binding: ProfileBinding()),
    GetPage(name: Routes.MORE, page: () => MoreView(), binding: MoreBinding()),
    GetPage(name: Routes.PAGES, page: () => PagesView(), binding: PagesBinding()),
    GetPage(name: Routes.PAGESCUNTACTUS, page: () => PagesCuntactUsView(), binding: PagesCuntactUsBinding()),
    GetPage(name: Routes.PAGESMORE, page: () => PagesMoreView(), binding: PagesMoreBinding()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(name: Routes.REGISTER, page: () => RegisterView(), binding: AuthBinding()),
    GetPage(
      name: Routes.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(name: Routes.AuthenticationPasswordView, page: () => AuthenticationPasswordView(), binding: AuthenticationBinding()),
    GetPage(name: Routes.FORGOT_PASSWORDSTEP1, page: () => ForgotPasswordStep1View(), binding: AuthBinding()),
    GetPage(name: Routes.FORGOT_PASSWORDSTEP2, page: () => ForgotPasswordStep2View(), binding: AuthBinding()),
    GetPage(name: Routes.PHONE_VERIFICATION, page: () => PhoneVerificationView(), binding: AuthBinding()),
    GetPage(name: Routes.HOMEALLCURRENCIES, page: () => HomeAllOrderView(), binding: HomeAllOrderBinding()),
    GetPage(name: Routes.GOOGLE_VERIFICATION, page: () => GoogleVerificationView(), binding: AuthBinding()),
  ];
}

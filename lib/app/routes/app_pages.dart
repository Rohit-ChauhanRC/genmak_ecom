import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/add_vendor/bindings/add_vendor_binding.dart';
import '../modules/add_vendor/views/add_vendor_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/cutomer_billing_detils/bindings/cutomer_billing_detils_binding.dart';
import '../modules/cutomer_billing_detils/views/cutomer_billing_detils_view.dart';
import '../modules/cutomer_billing_list/bindings/cutomer_billing_list_binding.dart';
import '../modules/cutomer_billing_list/views/cutomer_billing_list_view.dart';
import '../modules/edit_product_item/bindings/edit_product_item_binding.dart';
import '../modules/edit_product_item/views/edit_product_item_view.dart';
import '../modules/edit_vendor/bindings/edit_vendor_binding.dart';
import '../modules/edit_vendor/views/edit_vendor_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manage_products/bindings/manage_products_binding.dart';
import '../modules/manage_products/views/manage_products_view.dart';
import '../modules/order_details/bindings/order_details_binding.dart';
import '../modules/order_details/views/order_details_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/product_list/bindings/product_list_binding.dart';
import '../modules/product_list/views/product_list_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/receipt/bindings/receipt_binding.dart';
import '../modules/receipt/views/receipt_view.dart';
import '../modules/receive_products/bindings/receive_products_binding.dart';
import '../modules/receive_products/views/receive_products_view.dart';
import '../modules/restore_data/bindings/restore_data_binding.dart';
import '../modules/restore_data/views/restore_data_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/total_orders/bindings/total_orders_binding.dart';
import '../modules/total_orders/views/total_orders_view.dart';
import '../modules/vendor_list/bindings/vendor_list_binding.dart';
import '../modules/vendor_list/views/vendor_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVE_PRODUCTS,
      page: () => const ReceiveProductsView(),
      binding: ReceiveProductsBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_PRODUCTS,
      page: () => const ManageProductsView(),
      binding: ManageProductsBinding(),
    ),
    GetPage(
      name: _Paths.TOTAL_ORDERS,
      page: () => const TotalOrdersView(),
      binding: TotalOrdersBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VENDOR,
      page: () => const AddVendorView(),
      binding: AddVendorBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RESTORE_DATA,
      page: () => const RestoreDataView(),
      binding: RestoreDataBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => const ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT_ITEM,
      page: () => const EditProductItemView(),
      binding: EditProductItemBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_LIST,
      page: () => const VendorListView(),
      binding: VendorListBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_VENDOR,
      page: () => const EditVendorView(),
      binding: EditVendorBinding(),
    ),
    GetPage(
      name: _Paths.CUTOMER_BILLING_LIST,
      page: () => const CutomerBillingListView(),
      binding: CutomerBillingListBinding(),
    ),
    GetPage(
      name: _Paths.CUTOMER_BILLING_DETILS,
      page: () => const CutomerBillingDetilsView(),
      binding: CutomerBillingDetilsBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPT,
      page: () => const ReceiptView(),
      binding: ReceiptBinding(),
    ),
  ];
}

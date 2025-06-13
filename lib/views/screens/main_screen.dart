import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/categories_screen.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/dashboard_screen.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/oders_screen.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/products_screen.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/upload_banner_screen.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/vendors_screen.dart';
import 'package:multi_web_admin/views/screens/sidebar_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() => _selectedScreen = DashboardScreen());
        break;
      case VendorsScreen.routeName:
        setState(() => _selectedScreen = VendorsScreen());
        break;
      case WithdrawalScreen.routeName:
        setState(() => _selectedScreen = WithdrawalScreen());
        break;
      case OdersScreen.routeName:
        setState(() => _selectedScreen = OdersScreen());
        break;
      case CategoriesScreen.routeName:
        setState(() => _selectedScreen = CategoriesScreen());
        break;
      case UploadBannerScreen.routeName:
        setState(() => _selectedScreen = UploadBannerScreen());
        break;
      case ProductsScreen.routeName:
        setState(() => _selectedScreen = ProductsScreen());
        break;
      default:
        setState(() => _selectedScreen = DashboardScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      // backgroundColor: Colors.yellow.shade900,
      appBar: AppBar(
        title: const Text('Management', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.yellow.shade900,
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.category,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Vendor',
            icon: Icons.people,
            route: VendorsScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            icon: CupertinoIcons.money_dollar,
            route: WithdrawalScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Oders',
            icon: Icons.shopping_cart,
            route: OdersScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: CategoriesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            icon: Icons.add,
            route: UploadBannerScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: Icons.sell,
            route: ProductsScreen.routeName,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) => screenSelector(item),
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Multi Store Admin',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text('footer', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),

      body: _selectedScreen,
    );
  }
}

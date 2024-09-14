import 'package:flutter/material.dart';
import 'package:mobile_app/ui/screens/escrow_screen.dart';
import '../ui/screens/main_layout_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/payfast_screen.dart';
import '../ui/screens/product_detail_screen.dart';
import '../wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {

      case Wrapper.id:
        return _route(const Wrapper());

      case OnBoardingScreen.id:
        return _route(const OnBoardingScreen());

      case MainLayout.id:
        return _route(const MainLayout());

      case ProductDetailScreen.id:
        return _route(ProductDetailScreen(product: args,));

      case EscrowScreen.id:
        return _route(EscrowScreen(product: args));

      case PayFastWebView.id:
        return _route(PayFastWebView(uri: args.toString()));

      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: Center(
          child: Text(
            'ROUTE \n\n$name\n\nNOT FOUND',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
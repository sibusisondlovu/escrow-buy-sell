import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/config/theme.dart';
import 'package:mobile_app/data/transaction_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayFastWebView extends StatefulWidget {
  const PayFastWebView({super.key, required this.uri});
  final dynamic uri;
  static const id = 'payFast';

  @override
  State<PayFastWebView> createState() => _PayFastWebViewState();
}

class _PayFastWebViewState extends State<PayFastWebView> {
  bool _isLoading = true;
  final _controller = WebViewController();
  String pageStatusMessage = 'please wait...';

  _onUrlChange(String url) {
    if (mounted) {
      setState(() {
        if (url.contains("https://jaspagroup.co.za/payfast/success.html")) {
          Navigator.pushNamed(context, "transactionProgressScreen", arguments: transactions[3]);
        } else if (url
            .contains("https://jaspagroup.co.za/payfast/cancel.html")) {
          Navigator.pushNamed(context, "paymentCancelledScreen");
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onUrlChange: (url) {
            _onUrlChange(url.toString());
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });

            if (url == 'https://jaspagroup.co.za/payfast/success.html') {
              Navigator.pushNamed(context, "transactionProgressScreen", arguments: transactions[3]);

            }
          },
          onHttpError: (HttpResponseError error) {
            // AwesomeDialog(
            //   context: context,
            //   dialogType: DialogType.error,
            //   title: 'Error',
            //   desc: error.response?.statusCode.toString(),
            // ).show();
            // setState(() {
            //   _isLoading = false;
            // });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Removed for testing with google.com
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title:"Error Code: ${error.errorCode}",
              desc: error.description,

            ).show();
            setState(() {
              _isLoading = false;
            });
          },
        ),
      );
      _controller.loadRequest(Uri.parse(widget.uri.toString()));

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          elevation: 0,
          backgroundColor: AppTheme.mainColor,
        ),
        body: Stack(
          children: [
            Opacity(
                opacity: _isLoading ? 0.0 : 1.0,
                child: WebViewWidget(controller: _controller)),
            Center(
              child: Visibility(
                visible: _isLoading,
                child: const SpinKitFadingCube(
                  color: AppTheme.ascentColor,
                  size: 50,
                ),
              ),
            )
          ],
        ));
  }
}

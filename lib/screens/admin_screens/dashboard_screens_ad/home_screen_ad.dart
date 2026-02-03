// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
//
// class HomeScreenAD extends StatefulWidget {
//   const HomeScreenAD({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreenAD> createState() => _HomeScreenADState();
// }
//
// class _HomeScreenADState extends State<HomeScreenAD> {
//   final GlobalKey webViewKey = GlobalKey();
//
//   InAppWebViewController? webViewController;
//
//   PullToRefreshController? pullToRefreshController;
//
//   bool pullToRefreshEnabled = true;
//   bool isPulled = false;
//
//   double doProgress = 0;
//   @override
//   void initState() {
//     super.initState();
//
//     pullToRefreshController = kIsWeb
//         ? null
//         : PullToRefreshController(
//       options: PullToRefreshOptions(
//           backgroundColor: Colors.white,
//           color: Colors.black,
//           size: AndroidPullToRefreshSize.fromValue(50),
//           slingshotDistance: 350,
//           distanceToTriggerSync: 200),
//       onRefresh: () async {
//         if (defaultTargetPlatform == TargetPlatform.android) {
//           webViewController?.reload();
//         } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//           webViewController?.loadUrl(
//               urlRequest:
//               URLRequest(url: await webViewController?.getUrl()));
//         }
//       },
//     );
//   }
//   Future<bool> _goBack() async {
//     if (await webViewController?.canGoBack() ?? true) {
//       webViewController?.goBack();
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future<bool> _willPopCallback() async {
//     _goBack();
//     return Future.value(false);
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return WillPopScope(
//       onWillPop: _willPopCallback,
//       child: AppScaffold(
//           body: Center(child: Text("Web Page for reports from Bold bi"),) /* Stack(
//             children: [
//               Column(children: <Widget>[
//                 // Expanded(
//                 //     child: InAppWebView(
//                 //       key: webViewKey,
//                 //       // initialUrlRequest: URLRequest(
//                 //       //     url: Uri.parse("https://testvpmobile.epistic.net/")),    // Url for testing
//                 //       initialUrlRequest: URLRequest(
//                 //           url: Uri.parse("https://app1696502165.boldbi.com/bi/dashboards/e7ffc228-fc15-450a-ab84-787776e20f38/HealthCare/RespondTraumasa")), // Url for live
//                 //       pullToRefreshController: pullToRefreshController,
//                 //       onWebViewCreated: (InAppWebViewController controller) {
//                 //         webViewController = controller;
//                 //       },
//                 //       onLoadStop: (controller, url) {
//                 //         pullToRefreshController?.endRefreshing();
//                 //       },
//                 //       onProgressChanged: (controller, progress) {
//                 //         pullToRefreshController?.isRefreshing().then((value) {
//                 //           setState(() {
//                 //             isPulled = value;
//                 //           });
//                 //         });
//                 //         setState(() {
//                 //           doProgress = progress / 100;
//                 //         });
//                 //         if (progress == 100) {
//                 //           pullToRefreshController?.endRefreshing();
//                 //         }
//                 //       },
//                 //     )),
//               ]),
//               Center(child: _buildProgressBar()),
//             ],
//           )*/
//       ),
//     );
//   }
//
//   Widget _buildProgressBar() {
//     if (doProgress != 1.0 && isPulled == false) {
//       return const SpinKitRing(
//         duration: Duration(milliseconds: 1000),
//         size: 40,
//         lineWidth: 5,
//         color: Colors.blue,
//       );
//     }
//     return Container();
//   }
// }

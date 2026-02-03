import 'dart:async';

import 'package:sales_app/features/dashboard/presentation/pages/dashboard_screen.dart';

class CartCounterStream {
  // StreamController to manage the stream
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  // Method to increment the counter and add data to the stream
  void updateCartCounter() {
    _controller.sink.add(cartItemCount);
  }

  // Clean up resources when no longer needed
  void dispose() {
    _controller.close();
  }
}

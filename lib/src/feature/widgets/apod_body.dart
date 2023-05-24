import 'package:expunivers/src/feature/models/mars_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/state_manager.dart';

class ApodBody extends ConsumerWidget {
  const ApodBody(this.apod, {super.key});
  final MarsModel apod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scalar = ref.watch(sliderScalarProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Text(
              //   DateFormat('yyyy-MM-dd').format(apod.date!),
              //   style: const TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Chip(
                backgroundColor: Colors.purple,
                label: Text(
                  'Zoom: ${scalar.toStringAsPrecision(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Text(
          //   apod.identifier!,
          //   style: const TextStyle(
          //     fontSize: 18,
          //   ),
          // ),
          const SizedBox(height: 4),
          // Text(
          //   'Copyright: ${apod.version!}',
          //   style: const TextStyle(
          //     fontSize: 16,
          //   ),
          // ),
          const SizedBox(height: 8),
          // Text(
          //   apod.caption!,
          //   style: const TextStyle(
          //     fontSize: 16,
          //   ),
          // ),
        ],
      ),
    );
  }
}

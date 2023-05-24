import 'package:cached_network_image/cached_network_image.dart';
import 'package:expunivers/src/feature/models/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mars_model.dart';
import '../state/state_manager.dart';
import 'apod_detail.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apodFuture = ref.watch(apodResult);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: FutureBuilder<MarsModel>(
          future: apodFuture.maybeWhen(
            data: (apod) => Future.value(apod),
            orElse: () => null,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching Apods: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final photos = snapshot.data!.photos;

              if (photos != null && photos.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final photo = photos[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ApodDetail(
                                photos: photos,
                                initialIndex: index,
                              );
                            },
                          ),
                        );
                      },
                      child: _buildApodCard(photo),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No photos available.'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildApodCard(Photos apod) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: apod.imgSrc ?? '',
          placeholder: (context, url) => Transform.scale(
            scale: 0.3,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:expunivers/src/feature/models/photos_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/mars_model.dart';
// import '../state/state_manager.dart';
// import 'apod_detail.dart';
//
// class HomePage extends ConsumerWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final apodFuture = ref.watch(apodResult);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: SafeArea(
//         child: apodFuture.when(
//           data: (MarsModel apod) {
//             // Retrieve the MarsModel object
//             final photos = apod.photos; // Access the 'photos' list
//
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // Number of columns in the grid
//               ),
//               itemCount: photos?.length ?? 0,
//               itemBuilder: (BuildContext context, int index) {
//                 final photo =
//                     photos![index]; // Get a single photo from the list
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return ApodDetail(apod: photo);
//                         },
//                       ),
//                     );
//                   },
//                   child:
//                       _buildApodCard(photo), // Pass the photo to _buildApodCard
//                 );
//               },
//             );
//           },
//           loading: () {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//           error: (error, stackTrace) {
//             return Center(
//               child: Text('Error fetching Apods: $error'),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildApodCard(Photos apod) {
//   return Card(
//     elevation: 4,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: AspectRatio(
//         aspectRatio: 1.0, // Adjust the aspect ratio as needed
//         child: CachedNetworkImage(
//           imageUrl: apod.imgSrc ?? '',
//           placeholder: (context, url) => Transform.scale(
//             scale: 0.3, // Adjust the scale factor to make it smaller
//             child: const CircularProgressIndicator(
//               strokeWidth:
//                   2, // Adjust the stroke width of the circular progress indicator
//             ),
//           ),
//           errorWidget: (context, url, error) => const Icon(Icons.error),
//           fit: BoxFit.fill,
//         ),
//       ),
//     ),
//   );
// }

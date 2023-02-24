// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:khulasa/Controllers/RSS/articleprovider.dart';
// import 'package:khulasa/Models/article.dart';
// import 'package:khulasa/Views/RSS/article.dart';
// import 'package:khulasa/constants/colors.dart';
// import 'package:khulasa/constants/sizes.dart';
// import 'package:provider/provider.dart';

// class articleList extends StatefulWidget {
//   final String c;
//   const articleList({Key? key, required this.c}) : super(key: key);

//   @override
//   State<articleList> createState() => _articleListState();
// }

// class _articleListState extends State<articleList> {
//   @override
//   Widget build(BuildContext context) {
//     List<article> articlelist =
//         context.watch<articleprovider>().getarticleList();
//     return Scaffold(
//         backgroundColor: background,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 5.0),
//                 child: Text(
//                   widget.c,
//                   style: const TextStyle(
//                     color: text,
//                     fontSize: headingFont,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 20),
//                     itemCount: context.read<articleprovider>().count,
//                     itemBuilder: (context, index) => Card(
//                           color: primary,
//                           child: ListTile(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => Article(
//                                         art: article,
//                                       )));
//                             },
//                             shape: const RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5)),
//                             ),
//                             title: Text(
//                               context.read<articleprovider>().gettitle(index),
//                               textAlign: TextAlign.right,
//                               style: const TextStyle(
//                                   color: secondary,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: headingFont),
//                             ),
//                             subtitle: Text(
//                               textAlign: TextAlign.right,
//                               context.read<articleprovider>().getsummary(index),
//                               style: const TextStyle(
//                                 color: text,
//                               ),
//                             ),
//                             // trailing: GestureDetector(
//                             //     child:
//                             //         (!context.read<catprovider>().getfav(index))
//                             //             ? const Icon(
//                             //                 Icons.favorite_outline_outlined,
//                             //                 color: text,
//                             //               )
//                             //             : const Icon(
//                             //                 Icons.favorite,
//                             //                 color: Colors.red,
//                             //               ),
//                             //     onTap: () {
//                             //       context.read<catprovider>().setfav(
//                             //           index,
//                             //           !context
//                             //               .read<catprovider>()
//                             //               .getfav(index));
//                             //     }),
//                             tileColor: primary,
//                           ),
//                         )),
//               ),
//             ],
//           ),
//         ));
//   }
// }

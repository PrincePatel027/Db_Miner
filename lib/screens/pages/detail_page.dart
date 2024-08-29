// import 'dart:io';
// import 'dart:math';
// import 'dart:ui';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:share_extend/share_extend.dart';
// import '../../model/api_quote_model.dart';
// import '../../provider/like_provider.dart';

// // ignore: must_be_immutable
// class DetailPage extends StatefulWidget {
//   List<ApiQuoteModel> apiQuotes = [];
//   int initialIndex;
//   DetailPage({
//     super.key,
//     required this.apiQuotes,
//     required this.initialIndex,
//   });

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   ImagePicker picker = ImagePicker();
//   Uint8List? image;
//   Color fontColor = Colors.black;

//   List<Color> randomColor = [
//     Colors.primaries[Random().nextInt(15)][100]!,
//     Colors.primaries[Random().nextInt(15)][100]!,
//     Colors.primaries[Random().nextInt(15)][100]!,
//   ];

//   Future<void> shareImage() async {
//     int currentIndex = widget.initialIndex;
//     RenderRepaintBoundary renderRepaintBoundary = repaintKeys[currentIndex]
//         .currentContext!
//         .findRenderObject() as RenderRepaintBoundary;
//     var image = await renderRepaintBoundary.toImage(pixelRatio: 5);
//     var byteData = await image.toByteData(format: ImageByteFormat.png);
//     var fetchImage = byteData!.buffer.asUint8List();
//     Directory directory = await getApplicationCacheDirectory();
//     String path = directory.path;
//     File file = File('$path.png');
//     file.writeAsBytes(fetchImage as List<int>);
//     ShareExtend.share(file.path, "Image");
//   }

//   List<GlobalKey> repaintKeys = [];

//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.apiQuotes.length; i++) {
//       repaintKeys.add(GlobalKey());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Detail Page"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: CarouselSlider(
//                 items: [
//                   ...widget.apiQuotes.map(
//                     (e) => Padding(
//                       padding: EdgeInsets.all(width * 0.02),
//                       child: Column(
//                         children: [
//                           RepaintBoundary(
//                             key: repaintKeys[widget.apiQuotes.indexOf(e)],
//                             child: Container(
//                               height: height / 2,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   colors: randomColor,
//                                 ),
//                                 image: DecorationImage(
//                                   image: (image == null)
//                                       ? const NetworkImage(
//                                           "https://cdn.pixabay.com/photo/2016/12/07/15/57/blur-1889747_960_720.jpg",
//                                         )
//                                       : MemoryImage(image!),
//                                   fit: BoxFit.cover,
//                                   opacity: (image == null) ? 0 : 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               alignment: Alignment.center,
//                               padding: EdgeInsets.all(width * 0.03),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Spacer(),
//                                   GestureDetector(
//                                     onTap: () async {
//                                       XFile? imageFile = await picker.pickImage(
//                                           source: ImageSource.gallery);
//                                       if (imageFile != null) {
//                                         image = await imageFile.readAsBytes();
//                                         setState(() {});
//                                       }
//                                     },
//                                     child: (image != null)
//                                         ? Container()
//                                         : Container(),
//                                   ),
//                                   SizedBox(height: height * 0.08),
//                                   SelectableText(
//                                     textAlign: TextAlign.center,
//                                     widget.apiQuotes[widget.initialIndex].quote,
//                                     style: TextStyle(
//                                       fontSize: width * 0.04,
//                                       fontWeight: FontWeight.bold,
//                                       color: fontColor,
//                                     ),
//                                   ),
//                                   SizedBox(height: height * 0.01),
//                                   const Spacer(),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: SelectableText(
//                                       "~ ${widget.apiQuotes[widget.initialIndex].author}",
//                                       style: TextStyle(
//                                         fontSize: width * .04,
//                                         fontWeight: FontWeight.w500,
//                                         color: fontColor,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: height * 0.01),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//                 options: CarouselOptions(
//                   aspectRatio: 3 / 4,
//                   animateToClosest: true,
//                   autoPlay: false,
//                   enlargeCenterPage: true,
//                   autoPlayCurve: Curves.bounceInOut,
//                   height: height * 0.6,
//                   onPageChanged: (index, reason) {
//                     widget.initialIndex = index;
//                     setState(() {});
//                   },
//                 ),
//               ),
//             ),
//             const Divider(),
//             OutlinedButton.icon(
//               onPressed: () async {
//                 showColorDialog(context);
//               },
//               label: const Text("Chage font color"),
//               icon: const Icon(Icons.font_download),
//             ),
//             (image == null)
//                 ? OutlinedButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         image = null;
//                         randomColor = [
//                           Colors.primaries[Random().nextInt(15)][100]!,
//                           Colors.primaries[Random().nextInt(15)][100]!,
//                           Colors.primaries[Random().nextInt(15)][100]!,
//                         ];
//                         setState(() {});
//                       });
//                     },
//                     label: const Text("Random background Color"),
//                     icon: const Icon(Icons.image_aspect_ratio),
//                   )
//                 : OutlinedButton.icon(
//                     onPressed: () {
//                       image = null;
//                       setState(() {});
//                     },
//                     label: const Text("Remove Image"),
//                     icon: const Icon(Icons.image_aspect_ratio),
//                   ),
//             (image != null)
//                 ? Container()
//                 : OutlinedButton.icon(
//                     onPressed: () async {
//                       XFile? imageFile =
//                           await picker.pickImage(source: ImageSource.gallery);
//                       if (imageFile != null) {
//                         image = await imageFile.readAsBytes();
//                         setState(() {});
//                       }
//                     },
//                     label: const Text("Add background Image"),
//                     icon: const Icon(Icons.font_download),
//                   ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: height * 0.09,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton.filledTonal(
//               onPressed: () {
//                 Provider.of<LikeProvider>(context, listen: false).like(
//                   model: widget.apiQuotes[widget.initialIndex],
//                   // image: image!,
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Added to like succesfully..."),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.favorite_outline),
//             ),
//             IconButton.filledTonal(
//               onPressed: () async {
//                 await Clipboard.setData(
//                   ClipboardData(
//                       text:
//                           "${widget.apiQuotes[widget.initialIndex].quote} \n${widget.apiQuotes[widget.initialIndex].author}"),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Quote copied to clipboard'),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.copy),
//             ),
//             IconButton.filledTonal(
//               onPressed: () {
//                 shareImage();
//               },
//               icon: const Icon(Icons.share),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void showColorDialog(BuildContext context) async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Select a color'),
//           content: Wrap(
//             children: [
//               colorButton(context, Colors.red),
//               colorButton(context, Colors.green),
//               colorButton(context, Colors.blue),
//               colorButton(context, Colors.yellow),
//               colorButton(context, Colors.purple),
//               colorButton(context, Colors.orange),
//               colorButton(context, Colors.pink),
//               colorButton(context, Colors.brown),
//               colorButton(context, Colors.grey),
//               colorButton(context, Colors.black),
//               colorButton(context, Colors.white),
//             ],
//           ),
//           actions: [
//             IconButton.filledTonal(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.cancel,
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   Widget colorButton(BuildContext context, Color color) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           fontColor = color;
//         });
//         Navigator.of(context).pop();
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         margin: const EdgeInsets.only(right: 8, bottom: 6),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: color,
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../model/api_quote_model.dart';
import '../../provider/like_provider.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  List<ApiQuoteModel> apiQuotes = [];
  int initialIndex;
  DetailPage({
    super.key,
    required this.apiQuotes,
    required this.initialIndex,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ImagePicker picker = ImagePicker();
  Uint8List? image;
  Color fontColor = Colors.black;

  List<Color> randomColor = [
    Colors.primaries[Random().nextInt(15)][100]!,
    Colors.primaries[Random().nextInt(15)][100]!,
    Colors.primaries[Random().nextInt(15)][100]!,
  ];

  Future<void> shareImage() async {
    int currentIndex = widget.initialIndex;
    RenderRepaintBoundary renderRepaintBoundary = repaintKeys[currentIndex]
        .currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    var image = await renderRepaintBoundary.toImage(pixelRatio: 5);
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var fetchImage = byteData!.buffer.asUint8List();
    Directory directory = await getApplicationCacheDirectory();
    String path = directory.path;
    File file = File('$path.png');
    file.writeAsBytes(fetchImage as List<int>);
    await Share.shareFiles([file.path], text: 'Image');
  }

  List<GlobalKey> repaintKeys = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.apiQuotes.length; i++) {
      repaintKeys.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detail Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CarouselSlider(
                items: [
                  ...widget.apiQuotes.map((e) => Padding(
                        padding: EdgeInsets.all(width * 0.02),
                        child: Column(
                          children: [
                            RepaintBoundary(
                              key: repaintKeys[widget.apiQuotes.indexOf(e)],
                              child: Container(
                                height: height / 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: randomColor,
                                  ),
                                  image: DecorationImage(
                                    image: (image == null)
                                        ? const NetworkImage(
                                            "https://cdn.pixabay.com/photo/2016/12/07/15/57/blur-1889747_960_720.jpg",
                                          )
                                        : MemoryImage(image!),
                                    fit: BoxFit.cover,
                                    opacity: (image == null) ? 0 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(width * 0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        XFile? imageFile =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);
                                        if (imageFile != null) {
                                          image = await imageFile.readAsBytes();
                                          setState(() {});
                                        }
                                      },
                                      child: (image != null)
                                          ? Container()
                                          : Container(),
                                    ),
                                    SizedBox(height: height * 0.08),
                                    SelectableText(
                                      textAlign: TextAlign.center,
                                      widget
                                          .apiQuotes[widget.initialIndex].quote,
                                      style: TextStyle(
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: fontColor,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: SelectableText(
                                        "~ ${widget.apiQuotes[widget.initialIndex].author}",
                                        style: TextStyle(
                                          fontSize: width * .04,
                                          fontWeight: FontWeight.w500,
                                          color: fontColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
                options: CarouselOptions(
                  aspectRatio: 3 / 4,
                  animateToClosest: true,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.bounceInOut,
                  height: height * 0.6,
                  onPageChanged: (index, reason) {
                    widget.initialIndex = index;
                    setState(() {});
                  },
                ),
              ),
            ),
            const Divider(),
            OutlinedButton.icon(
              onPressed: () async {
                showColorDialog(context);
              },
              label: const Text("Chage font color"),
              icon: const Icon(Icons.font_download),
            ),
            (image == null)
                ? OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        image = null;
                        randomColor = [
                          Colors.primaries[Random().nextInt(15)][100]!,
                          Colors.primaries[Random().nextInt(15)][100]!,
                          Colors.primaries[Random().nextInt(15)][100]!,
                        ];
                        setState(() {});
                      });
                    },
                    label: const Text("Random background Color"),
                    icon: const Icon(Icons.image_aspect_ratio),
                  )
                : OutlinedButton.icon(
                    onPressed: () {
                      image = null;
                      setState(() {});
                    },
                    label: const Text("Remove Image"),
                    icon: const Icon(Icons.image_aspect_ratio),
                  ),
            (image != null)
                ? Container()
                : OutlinedButton.icon(
                    onPressed: () async {
                      XFile? imageFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (imageFile != null) {
                        image = await imageFile.readAsBytes();
                        setState(() {});
                      }
                    },
                    label: const Text("Add background Image"),
                    icon: const Icon(Icons.font_download),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton.filledTonal(
              onPressed: () {
                Provider.of<LikeProvider>(context, listen: false).like(
                  model: widget.apiQuotes[widget.initialIndex],
                  // image: image!,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Added to like succesfully..."),
                  ),
                );
              },
              icon: const Icon(Icons.favorite_outline),
            ),
            IconButton.filledTonal(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(
                      text:
                          "${widget.apiQuotes[widget.initialIndex].quote} \n${widget.apiQuotes[widget.initialIndex].author}"),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Quote copied to clipboard'),
                  ),
                );
              },
              icon: const Icon(Icons.copy),
            ),
            IconButton.filledTonal(
              onPressed: () {
                shareImage();
              },
              icon: const Icon(Icons.share),
            )
          ],
        ),
      ),
    );
  }

  Widget colorButton(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fontColor = color;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 8, bottom: 6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  void showColorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a color'),
          content: Wrap(
            children: [
              colorButton(context, Colors.red),
              colorButton(context, Colors.green),
              colorButton(context, Colors.blue),
              colorButton(context, Colors.yellow),
              colorButton(context, Colors.purple),
              colorButton(context, Colors.orange),
              colorButton(context, Colors.pink),
              colorButton(context, Colors.brown),
              colorButton(context, Colors.grey),
              colorButton(context, Colors.black),
              colorButton(context, Colors.white),
            ],
          ),
          actions: [
            IconButton.filledTonal(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
              ),
            )
          ],
        );
      },
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2/Getx/getx.dart';
import 'package:task2/Theme/themes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Imageupload extends StatelessWidget {
  Imageupload({super.key});

  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Themes.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CachedNetworkImage(
              height: height * 0.1,
              width: width * 0.4,
              imageUrl: 'https://s3-alpha-sig.figma.com/img/0d2a/a494/ecdcaaf7c0b419af571d44966bfc59a5?Expires=1734307200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ACMuUeihSW0q-Va2ckyVzCHXq425XHUP-1mWB~pyHy-xfYebC1BK88HdZ4y3b-shhr8uP0KY4k~zOfhWAoxj6x28R-WUcXwxlLGirnch0rOE1aOFQzO1wkKQzbBzVCIRvS9NcR4gS~XeC-Y9~R56ftNQ1OAdozuy3lfxNz~tBefUFYRGV3PqB9xhE4cH-7ZmTBBEBKOWQrEGlVPfbXOB10cN9CaQgm3K0jpOpDGaiMYuo7CbOKZS0ooMapGM21vIMkCdGnBDy3IQUuEgJLyCgJxjULFAi56UbyWJKJyvvGGxFizt6auxTAVSDeJgGWxILyZ96-d-CLnSuWCfpg6Gwg__'
            ),
          ),
          Container(
            height: height * 0.8,
            width: width,
            decoration: BoxDecoration(
              color: Themes.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Text('Upload Image', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  const SizedBox(height: 20,),
                  ["", null, false, 0].contains(controller.image.value) ?
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: height * 0.3,
                            width: width,
                            decoration: BoxDecoration(
                              color: Themes.white,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Upload via', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                                  const SizedBox(height: 20,),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      final image = await ImagePicker().pickImage(source: ImageSource.camera);
                                      if (image != null) {
                                        controller.imageToFile(File(image.path));
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Themes.backgroundgrey,
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.camera),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Camera',
                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(
                                    height: 25,
                                    color: Themes.backgroundgrey,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Themes.backgroundgrey
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.image),
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        const Text('Gallery', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    },
                    child: Container(
                      height: height * 0.4,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Themes.buttongrey,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: Themes.darkblue,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.add, size: 55, color: Themes.white,),
                        ),
                      ),
                    ),
                  )
                  :Container(
                    height: height * 0.4,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.file(controller.image.value!)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void imageupload(File path) {
    controller.imageToFile(path);
  }
}
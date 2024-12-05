import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2/Getx/getx.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Theme/themes.dart';
class Calcgetx extends StatefulWidget {
  const Calcgetx({super.key});

  @override
  State<Calcgetx> createState() => _CalcgetxState();
}

class _CalcgetxState extends State<Calcgetx> {
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
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: buttons.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => controller.onButtonPressed(buttons[index]),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: controller.getButtonColor(buttons[index]),
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Text(
                                buttons[index],
                                style: TextStyle(
                                  fontSize: controller.fontSize(buttons[index]),
                                  color: controller.getTextColor(buttons[index]),
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Themes.backgroundgrey,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Obx(() => Container(
                          padding: const EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          child: Text(
                            controller.answer.value,
                            style: TextStyle(fontSize: height * 0.05, fontWeight: FontWeight.w400),
                          ),
                        )),
                        Obx(() => Container(
                          padding: const EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          child: Text(
                            controller.question.value,
                            style: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w300, color: Themes.lightgrey),
                          ),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> buttons = [
    'C', '%', '\u232B', '\u00F7',
    '7', '8', '9', '\u00D7',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '.', '0', '00', '='
  ];
}

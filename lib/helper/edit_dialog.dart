import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/custom_form_text_filed.dart';

Future<dynamic> ShowEditDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyBlueGradiant6, MyBlack],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 400,
            width: 324,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Car Name",
                    style: GoogleFonts.inter(
                        color: MyWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextFormField(
                    paddingValue1: 10,
                    paddingValue2: 2,
                    initialValue: "esraa",
                    value: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Car Id",
                    style: GoogleFonts.inter(
                        color: MyWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextFormField(
                    paddingValue1: 10,
                    paddingValue2: 2,
                    initialValue: "esraa",
                    value: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Speed Limit",
                    style: GoogleFonts.inter(
                        color: MyWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextFormField(
                    paddingValue1: 10,
                    paddingValue2: 2,
                    initialValue: "esraa",
                    value: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: 75,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "delete",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: 75,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyBlueGradiant6,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "cancel",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: MyBlueGradiant6,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: 75,
                          decoration: BoxDecoration(
                            color: MyBlueGradiant6,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "save",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: MyWhite1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

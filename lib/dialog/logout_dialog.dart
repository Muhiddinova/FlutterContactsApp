import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> showLogoutDialog({
  required BuildContext context,
  required VoidCallback onLogout,
  required VoidCallback onRegister,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                 Image(image: AssetImage("assets/images/log_out.png"),width: 24,height: 24,),
                  const SizedBox(width: 10),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Text(
                        textAlign: TextAlign.start,
                        "Sign Out",
                        style: TextStyle(
                          color: Color(0xff8E8E93),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "Do you want unregister or ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: "Poppins",
                          ),
                          children: [
                            TextSpan(
                              text: " logout?",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff8E8E93),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel,
                      color: Color(0xffEB5757),
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130,
                    height: 34,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: const Color(0xffEB5757),
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onRegister()
                       ;
                      },
                      child: const Text(
                        "UnRegister",
                        style: TextStyle(
                          color: Color(0xffEB5757),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    height: 34,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffEB5757),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onLogout();
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

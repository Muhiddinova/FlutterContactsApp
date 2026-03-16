import 'package:flutter/material.dart';

Future<void> showDeleteDialog({
  required BuildContext context,
  required String name,
  required VoidCallback onDelete,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.delete, color: Color(0xffEB5757)),
                  const SizedBox(width: 10),

                  /// TEXT AREA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),

                        const Text(
                          "Delete contact",
                          style: TextStyle(
                            color: Color(0xff8E8E93),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: "Poppins",
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text.rich(
                          TextSpan(
                            text: "Do you want delete ",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "Poppins",
                            ),
                            children: [
                              TextSpan(
                                text: "$name?",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff8E8E93),
                                ),
                              ),
                            ],
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// CLOSE ICON
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

              /// BUTTON RIGHT
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 110,
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
                        onDelete();
                      },
                      child: const Text(
                        "Delete",
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

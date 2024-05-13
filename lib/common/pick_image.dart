import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

/*

  */

sourceSelect(BuildContext context,
    {required void Function(ImageSource source) sendImagePick}) {
  try {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext _) {
        return PickImage(
          globalContext: context,
          sendImagePick: sendImagePick,
        );
      },
    );
  } catch (e) {
    Fluttertoast.showToast(msg: "Error while picking image");
  }
}

class PickImage extends StatefulWidget {
  const PickImage(
      {super.key, required this.globalContext, required this.sendImagePick});

  @override
  State<PickImage> createState() => _PickImageState();

  final BuildContext globalContext;

  final void Function(ImageSource source) sendImagePick;
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2 - 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CupertinoButton(
                  child: const Icon(
                    Iconsax.gallery,
                    size: 60,
                  ),
                  onPressed: () {
                    widget.sendImagePick(ImageSource.gallery);
                    context.pop();
                  },
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: CupertinoButton(
                  child: const Icon(
                    Iconsax.camera,
                    size: 60,
                  ),
                  onPressed: () {
                    widget.sendImagePick(ImageSource.camera);
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

Future<dynamic> loadingDialog(BuildContext context) {
  return showAdaptiveDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

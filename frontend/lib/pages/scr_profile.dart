import 'package:flutter/material.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<ProfileState>(
          state: Provider.of<ProfileState>(context),
          builder: (context, state, child) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: theme.themeData.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 24),
                        Center(
                            child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: state.image)),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.width / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: theme.themeData.highlightColor),
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      onPressed: () {
                                        imageSelection(theme, state);
                                      },
                                    ))),
                          ],
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(bottom: 24),
                                          labelText: "Display Name",
                                          labelStyle: theme
                                              .themeData.textTheme.bodySmall,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintText: "Amy",
                                          hintStyle: theme
                                              .themeData.textTheme.bodyMedium)),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(bottom: 24),
                                          labelText: "Username",
                                          labelStyle: theme
                                              .themeData.textTheme.bodySmall,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintText: "amy_stell",
                                          hintStyle: theme
                                              .themeData.textTheme.bodyMedium)),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(bottom: 24),
                                          labelText: "Email",
                                          labelStyle: theme
                                              .themeData.textTheme.bodySmall,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintText: "amy.stell5@gmail.com",
                                          hintStyle: theme
                                              .themeData.textTheme.bodyMedium)),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                ]))
                      ],
                    )));
          }),
    );
  }

  Future imageSelection(ThemeManager theme, ProfileState state) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose photo",
                style: theme.themeData.textTheme.titleSmall),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("From Camera",
                    style: theme.themeData.textTheme.labelSmall),
                onPressed: () {
                  state.selectOrTakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text("From Gallery",
                    style: theme.themeData.textTheme.labelSmall),
                onPressed: () {
                  state.selectOrTakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

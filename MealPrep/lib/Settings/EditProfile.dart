import 'package:flutter/material.dart';
import 'package:foodplanapp/Controls/SinglePicker.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  late PickedFile _imagePicked;
  final ImagePicker _picker = ImagePicker();

  Widget buildCard(String title, String value, Function()? onEdit) {
    Widget? trailing;
    if (onEdit != null) {
      trailing = PopupMenuButton(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: Icon(Icons.more_vert)),
        itemBuilder: (context) {
          return List.generate(1, (index) {
            return PopupMenuItem(
              value: index,
              child: Text('Edit'),
            );
          });
        },
        onSelected: (index) {
          onEdit();
        },
      );
    }

    return Card(
      child: ListTile(
        title: Text(title + ': ' + value,
            style: TextStyle(fontSize: 15, color: Colors.black)),
        trailing: trailing,
      ),
      color: Colors.grey[350],
      shadowColor: Colors.grey[600],
      elevation: 10.0,
    );
  }

  String getUserHeight() {
    int? height = CurrentSession.currentProfile.heightInInches;

    if (height == null) {
      return "";
    }

    int feet = (height ~/ 12);
    int inches = height % 12;

    return feet.toString() + " ft  " + inches.toString() + " in";
  }

  void editWithStringField(
      String title, String? currentValue, Function(String) onEnteredValue) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: TextField(
                  controller: controller,
                  decoration: MyStyles.defaultInputDecoration),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onEnteredValue(controller.text);
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  void editWithRadioField(String title, String? currentValue,
      List<String> options, Function(String?) onEnteredValue) {
    SinglePickerController controller =
        SinglePickerController(initialOption: currentValue);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: SinglePicker(
                controller: controller,
                options: options,
                itemWidth: 130,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onEnteredValue(controller.currentOption);
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  void editWithHeightField(
      String title, int? currentValue, Function(int) onEnteredValue) {
    int? currentHeight = CurrentSession.currentProfile.heightInInches;
    int? feet;
    int? inches;

    if (currentHeight != null) {
      feet = (currentHeight ~/ 12);
      inches = currentHeight % 12;
    }

    TextEditingController feetController =
        TextEditingController(text: feet == null ? "" : feet.toString());
    TextEditingController inchesController =
        TextEditingController(text: inches == null ? "" : inches.toString());
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Container(
                width: 300,
                height: 300,
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: feetController,
                            decoration: MyStyles.defaultInputDecoration,
                            textAlign: TextAlign.right),
                      ),
                      Text("  Feet"),
                      Container(width: 25),
                      Expanded(
                        child: TextField(
                            controller: inchesController,
                            decoration: MyStyles.defaultInputDecoration,
                            textAlign: TextAlign.right),
                      ),
                      Text("  inches"),
                    ],
                  )
                ]),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      int? feetFromController =
                          int.tryParse(feetController.text);
                      int feetInInches = feetFromController == null
                          ? 0
                          : feetFromController * 12;

                      int? inchesFromController =
                          int.tryParse(inchesController.text) ?? 0;

                      currentHeight = feetInInches + inchesFromController;
                      onEnteredValue(currentHeight!);
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  void editWithDateField(
      {required DateTime? currentValue,
      required DateTime initialDate,
      required DateTime lastDate,
      required Function(DateTime?) onEnteredValue}) async {
    DateTime initial = currentValue ?? initialDate;

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(1900),
        lastDate: lastDate);

    onEnteredValue(picked);
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('MMMM d, yyyy');

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 25,
          backgroundColor: MyColors.accentColor,
          title: const Text('Edit Profile'),
        ),
        body: Column(children: <Widget>[
          Container(height: 25),
          profileImage(),
          SizedBox(
            height: 20,
          ),
          Container(height: 20),
          buildCard("Username", CurrentSession.currentProfile.username, () {
            editWithStringField(
                "Enter Username", CurrentSession.currentProfile.username,
                (str) {
              setState(() {
                CurrentSession.currentProfile.username = str;
                CurrentSession.currentProfile.save();
              });
            });
          }),
          Container(height: 20),
          buildCard("Email", CurrentSession.currentProfile.email, null),
          Container(height: 20),
          buildCard(
              "Birthday",
              CurrentSession.currentProfile.birthday == null
                  ? ""
                  : format.format(CurrentSession.currentProfile.birthday!), () {
            editWithDateField(
                currentValue: CurrentSession.currentProfile.birthday,
                initialDate: DateTime(1995),
                lastDate: DateTime.now(),
                onEnteredValue: (pickedTime) {
                  setState(() {
                    CurrentSession.currentProfile.birthday = pickedTime;
                  });
                  CurrentSession.currentProfile.save();
                });
          }),
          Container(height: 20),
          buildCard("Height", getUserHeight(), () {
            editWithHeightField("Enter Your Height",
                CurrentSession.currentProfile.heightInInches, (heightInInches) {
              setState(() {
                CurrentSession.currentProfile.heightInInches = heightInInches;
                CurrentSession.currentProfile.save();
              });
            });
          }),
          Container(height: 20),
          buildCard("Gender", CurrentSession.currentProfile.gender ?? "", () {
            editWithRadioField(
                "Select Gender",
                CurrentSession.currentProfile.gender,
                ["Male", "Female"], (str) {
              setState(() {
                CurrentSession.currentProfile.gender = str;
                CurrentSession.currentProfile.save();
              });
            });
          })
        ]));
  }

  Widget profileImage() {
    ImageProvider<Object>? imageProvider;
    var profileImageData = CurrentSession.currentProfile.profilePicture;
    if (profileImageData != null) {
      imageProvider =
          MemoryImage(CurrentSession.currentProfile.profilePicture!);
    } else {
      imageProvider = AssetImage("images/lake.jpg");
    }

    return Center(
        child: Stack(children: <Widget>[
      CircleAvatar(radius: 80.0, backgroundImage: imageProvider),
      Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomPop()),
                );
              },
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: 25.0,
              )))
    ]));
  }

  Widget bottomPop() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(children: <Widget>[
          Text("Choose a profile picture", style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 20.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePicture(ImageSource.camera);
                },
                label: Text('Camera')),
            Container(width: 50),
            TextButton.icon(
                icon: Icon(Icons.photo_size_select_actual_outlined),
                onPressed: () {
                  takePicture(ImageSource.gallery);
                },
                label: Text('Gallery')),
          ])
        ]));
  }

  void takePicture(ImageSource source) async {
    XFile? pickedImage = await _picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedImage != null) {
      var fileData = await pickedImage.readAsBytes();
      CurrentSession.currentProfile.profilePicture = fileData;
      CurrentSession.currentProfile.save();
      setState(() {});
    }
  }
}

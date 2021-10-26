import 'package:flutter/material.dart';
import 'package:foodplanapp/CurrentSession.dart';
import 'package:foodplanapp/MyColors.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  late PickedFile _imagePicked;
  final ImagePicker _picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.accentColor,
        title: const Text('Edit Profile'),
      ),
        body: Column(
          children: <Widget>[
            Container(height: 25),
            profileImage(),
              SizedBox(
                height: 20,
              ),

            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Username: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),

            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Email: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),
            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Birthday: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),       
            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Height: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),         
            Container(height: 20),
            Card(
               child: ListTile(
                  title: const Text('Gender: ', style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Icon(Icons.more_vert)
                ),
              color: Colors.white54,
              shadowColor: Colors.grey[300],
              elevation: 10.0,
            ),                                            
            
          ]
        )
    );
  }

  Widget currentInfo() {
    return Card();
  }
  Widget changesToProfile(){
    return Center(
      child: Text('this is a test'),
    );
  }

  Widget profileImage(){
    ImageProvider<Object>? imageProvider;
    var profileImageData = CurrentSession.currentProfile.profilePicture;
    if (profileImageData != null){
      imageProvider = MemoryImage(CurrentSession.currentProfile.profilePicture!);
    }
    else{
      imageProvider = AssetImage("images/defaultPic.jpg");
    }

    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: imageProvider
        ),
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
            )
          )
        )
      ])
     );
  }

  Widget bottomPop() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text("Choose a profile picture", style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera), 
                onPressed: (){
                  takePicture(ImageSource.camera);
                }, 
                label: Text('Camera')
                ),
              
              Container(width: 50),
              TextButton.icon(
                icon: Icon(Icons.photo_size_select_actual_outlined), 
                onPressed: (){
                  takePicture(ImageSource.gallery);
                }, 
                label: Text('Gallery')),
            ]
          )
        ]
      )
    );
  }

  void takePicture(ImageSource source) async{
    	XFile? pickedImage = await _picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500
      );
      if (pickedImage != null){
        var fileData = await pickedImage.readAsBytes();
        CurrentSession.currentProfile.profilePicture = fileData;
        CurrentSession.currentProfile.save();
        setState(() { });
      }
  }
}
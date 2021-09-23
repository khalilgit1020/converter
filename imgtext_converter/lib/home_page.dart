

import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String result ='';
   File? image;
   ImagePicker imagePicker =ImagePicker();

  getImage(ImageSource src)async{
    PickedFile? pickedFile = await imagePicker.getImage(source: src);

    setState(() {
      image;
      if(pickedFile != null) {
        image = File(pickedFile.path);
      }
      performImageLabeling();
    });


  }

    pickImageFromGallery()async{
    PickedFile? pickedFile = await imagePicker.getImage(source: ImageSource.gallery);


    if(pickedFile != null)
      setState(() {
        image = File(pickedFile.path);

        image;

        performImageLabeling();
      });


  }

   captureImageWithCamera() async{
     PickedFile? pickedFile = await imagePicker.getImage(source: ImageSource.camera);

     if(pickedFile != null)
       setState(() {
         image = File(pickedFile.path);

         image;

         performImageLabeling();
       });


  }

  performImageLabeling()async{
    final FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

    VisionText visionText = await recognizer.processImage(firebaseVisionImage);

    result ='';

    setState(() {
      for(TextBlock block in visionText.blocks){
        final String? txt = block.text;
        for(TextLine line in block.lines){
          for(TextElement element in line.elements){
            result +="${element.text} ";
          }
        }
        result += '\n\n';
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit:BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(),

            // show result
            Container(
              height: 350,
              width: 320,
              margin:const EdgeInsets.only(top: 70),
              padding:const EdgeInsets.only(left: 28,bottom: 5,right: 18),
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/note.jpg'),
                  fit:BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SelectableText(
                    result,
                    style:const TextStyle(fontSize: 16,),
                    textAlign: TextAlign.center,
                    showCursor: true,
                  ),
                ),
              ),
            ),

            Container(
              margin:const EdgeInsets.only(top: 80,right: 140),
              child: Stack(
                children: [
                      Center(
                        child: Image.asset('assets/pin.png',height: 240,width: 240,),
                      ),

                  Center(
                    child: FlatButton(
                      onPressed: (){
                       //getImage(ImageSource.gallery);
                         pickImageFromGallery();
                        },
                      onLongPress:() {
                        //getImage(ImageSource.camera);
                         captureImageWithCamera();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            margin:const EdgeInsets.only(top: 25),
                            child: image != null ?Image.file(image!,height: 140,width: 192,fit: BoxFit.fill,):Container(
                              width: 240,
                              height: 200,
                              child:const Icon(Icons.camera_front,size: 100,color: Colors.grey,),
                            ),
                          ),
                          Text(
                            image != null ?'': 'pick image',
                            style: TextStyle(color: Colors.grey[700]),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

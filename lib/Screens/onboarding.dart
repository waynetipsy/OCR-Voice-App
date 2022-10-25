import 'package:flutter/material.dart';
import 'package:ocr_voice_app/Screens/homepage.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
   late PageController _pageController;

   int _pageIndex = 0;

   @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue,Colors.red],
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter
              
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                     setState(() {
                       _pageIndex = index;
                     });
                  },
                    itemCount: demo_data.length,
                    itemBuilder: (context, index) =>
                       OnbordContent(
                        image: demo_data[index].image,
                        title: demo_data[index].title,
                        description: demo_data[index].description
                      ),
                  ),
                ),
               Row(
                 children: [
                 ...List.generate(
                  demo_data.length,
                 (index) =>  Padding(
                  padding: const EdgeInsets.only(right: 4),
                child: DotIndicator(isActive: index == _pageIndex),
                   )
                 ),
                 const Spacer(),
                   SizedBox(height: 60,
                     width: 60,
                     child: ElevatedButton(
                      
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(
                          milliseconds: 300),
                          curve: Curves.ease,
                           );

                          Navigator.of(context).pushReplacementNamed('home');
                      },
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.black,
                        elevation: 8,
                        foregroundColor: Colors.blue,
                        
                        shape: const CircleBorder(
                         
                        )
                      ),
                      child: const Text('Skip',
                      
                       style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                        ),
                      )
                         
                      ),
                    ),
                 ],
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key, 
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 22 : 12,
      width: 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white :
        Colors.black,
      borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

  class Onboard {
    final String image, title, description;

  Onboard({
   required this.image,
  required this.title, 
  required this.description
  });
  }

  final List<Onboard> demo_data = [
    Onboard(
      image: "assets/camera_pic.png" ,
      title: 'Optical Character Recognition', 
      description: ' This app uses OCR technology to extract text and characters from photos, and digital camera-captured images. '
      ),
      
      Onboard(
      image: "assets/pdf_onboard.png", 
      title: 'PDF Maker', 
      description: 'This app uses OCR technology to extract text and characters from photos, and digital camera-captured images. '
      ),

       Onboard(
      image: "assets/loud.png", 
      title: 'Text to Speech', 
      description: 'This app converts your Pdf documents and text documents to audio. Enjoy and listen to your favorite Pdf document and text while sleeping or on the road. '
      ),
  ];

class OnbordContent extends StatelessWidget {
  const OnbordContent({
    Key? key, 
    required this.image, 
    required this.title, 
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const SizedBox(height: 70),
       //const Spacer(),
        Image.asset(image,
        height: 250,
        ),
       const SizedBox(height: 25),
      Text(title,
      style: Theme.of(context).textTheme.headline5!
      .copyWith(fontWeight: FontWeight.w500),
        ),
       const SizedBox(height: 20),
        Text(description,
        style: TextStyle(
          fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                          milliseconds: 300
                          ),
                          curve: Curves.ease,

                          );
                      },
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.black,
                        elevation: 8,
                        foregroundColor: Colors.blue,
                        
                        shape: const CircleBorder()
                      ),
                      child: const Icon(
                        Icons.arrow_right,
                        size: 40,
                        color: Colors.white
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
      height: isActive ? 12 : 4,
      width: 4,
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
      image: '', 
      title: 'Optical Character Recognition', 
      description: 'Convert your image to text,from galley or camera capture'
      ),
      
      Onboard(
      image: '', 
      title: '', 
      description: ''
      ),

       Onboard(
      image: '', 
      title: '', 
      description: ''
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
       const Spacer(),
        Image.asset(image,
        height: 250,
        ),
       const Spacer(),
      Text(title,
      style: Theme.of(context).textTheme.headline5!
      .copyWith(fontWeight: FontWeight.w500),
        ),
        Text(description,
        textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
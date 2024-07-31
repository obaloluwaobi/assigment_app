import 'package:assigment_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutProject extends StatelessWidget {
  const AboutProject({super.key});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(color: Colors.white, fontSize: 20);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: background,
          title: Text(
            'Profile',
            style: size20,
          ),
        ),
        backgroundColor: background2,
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[900],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Adebiyi Matthew Adeola',
                    style: style,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Educ2002011',
                    style: style,
                  ),
                  Text(
                    'Computer science ',
                    style: style,
                  ),
                  Text(
                    'Olabisi Onabanjo University',
                    style: style,
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Text(
            //     'About project',
            //     style: style,
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[900],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Text(
                'Welcome to submit,  project app for online assignment submission, grade management, and student-teacher interaction. This school project is designed to streamline the academic workflow, enhance communication between educators and students, and provide a centralized platform for managing coursework\n\nSubmit leverages advanced cloud technology and intuitive user interface design to offer the following key features\n\n1) Online Assignment Submission: Students can easily upload and submit their assignments through the app, eliminating the need for paper submissions and reducing the risk of lost work. \n\n2) Real-time Grading: Teachers can grade submitted assignments directly within the app, providing instant feedback and scores to students.\n\n3) Deadline Management: The app includes a robust system for setting, tracking, and notifying users of assignment deadlines, helping students stay organized and on top of their work.\n\nThis school project is designed to bridge the gap between traditional classroom interactions and the digital age, making assignment management more efficient and transparent. Submit becomes an invaluable tool for students looking to organize their academic responsibilities, teachers aiming to streamline their grading process, and educational institutions seeking to modernize their assignment workflows.',
                style: style,
              ),
            ),
          ],
        ));
  }
}

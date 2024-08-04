import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

//  Color(0xFFF5F5F5)0xFFf4f7fc
Color background = Colors.grey.shade100;
Color background2 = Colors.white;
Color primaryColor = const Color(0xFF374988);

Color btnColor = Color.fromARGB(255, 235, 207, 207);
Color btnOutlineColor = const Color(0xff000000);

Color dark = const Color(0xff000000);
Color white = const Color(0xffffffff);

//create accoun style
TextStyle createacct = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: dark,
);

//signin styles
TextStyle signin = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: white,
);

//size30normal
TextStyle size30 = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 30,
  color: dark,
);

//size30bold
TextStyle size30bold = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: dark,
);

//size20normal
TextStyle size20 = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 20,
  color: dark,
);

//size20bold
TextStyle size20bold = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: dark,
);
//size16normal
TextStyle size16 = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 16,
  color: dark,
);

//size16bold
TextStyle size16bold = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: dark,
);

//size14normal
TextStyle size14 = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 14,
  color: dark,
);

//size14bold
TextStyle size14bold = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: dark,
);

//size30normal
TextStyle size30w = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 30,
  color: white,
);

//size30bold
TextStyle size30boldw = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: white,
);

//size20normal
TextStyle size20w = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 20,
  color: white,
);

//size20bold
TextStyle size20boldw = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: white,
);
//size16normal
TextStyle size16w = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 16,
  color: white,
);

//size16boldw
TextStyle size16boldw = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: white,
);

//size14normalw
TextStyle size14w = GoogleFonts.poppins(
  fontWeight: FontWeight.normal,
  fontSize: 14,
  color: white,
);

//size14boldw
TextStyle size14boldw = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: white,
);
Future<void> launchEmail() async {
  // ios specification
  final String subject = "Subject:";
  final String stringText = "Same Message:";
  String uri =
      'mailto:hubstech0@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    print("No email client found");
  }
}

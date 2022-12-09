import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:possibilico/models/possibilico_user.dart';
import 'package:possibilico/screens/auth/authenticate.dart';
import 'package:possibilico/screens/auth/signup/onboarding.dart';
import 'package:possibilico/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PossibilicoUser?>(context);
    final List degreePrograms = [
      "Accountancy (BBA)",
      "Accountancy (MACC)",
      "Addiction Studies (BS)",
      "Agricultural, Environmental, and Sustainability Sciences (MS)",
      "American Sign Language and Interpretation (BS)",
      "Anthropology (BA)",
      "Anthropology - Interdisciplinary Studies (MAIS)",
      "Applied Statistics and Data Science (MS)",
      "Art (BFA)",
      "Art (MFA)",
      "Art - Teacher Certification (BA)",
      "Art History - Interdisciplinary Studies (MAIS)",
      "Bilingual Education (MED) ",
      "Biochemistry and Molecular Biology (MS)",
      "Bioethics (MS)",
      "Biology (BS)",
      "Biology (MS)",
      "Biology - Teacher Certification (BS)",
      "Biomedical Science (BS)",
      "Business Administration (MBA)",
      "Business Administration (PhD)",
      "Business Analytics (MS - Healthcare Analytics)",
      "Business Analytics (MS)",
      "Chemistry (BS)",
      "Chemistry (MS)",
      "Chemistry - Teacher Certification (BS)",
      "Civil Engineering (BS)",
      "Civil Engineering (MS)",
      "Clinical Psychology (MA)",
      "Clinical Psychology (PhD)",
      "Clinical Rehabilitation Counseling (MS)",
      "Communication (MA)",
      "Communication Sciences and Disorders (BS)",
      "Communication Sciences and Disorders (MS)",
      "Communication Studies (BA)",
      "Computer Engineering (BSCE)",
      "Computer Science (BS)",
      "Computer Science (MS)",
      "Counseling (MED)",
      "Creative Writing (MFA)",
      "Criminal Justice (BS)",
      "Criminal Justice (MS)",
      "Curriculum & Instruction (MEd - Content Specialization in Elementary Math and Science Education)",
      "Curriculum & Instruction (MEd - Content Specialization in English)",
      "Curriculum & Instruction (MEd - Content Specialization in Mathematics Education)",
      "Curriculum & Instruction (MEd - Content Specialization in Mathematics)",
      "Curriculum and Instruction (EdD)",
      "Cyber Security (BS)",
      "Dance (BA)",
      "Dance (BFA)",
      "Dance - Teacher Certification (BA)",
      "Dietetics (MS)",
      "Disaster Studies (MA)",
      "Doctor of Medicine (M.D.)",
      "Doctor of Podiatric Medicine (D.P.M.)",
      "Early Care and Early Childhood Studies (BS)",
      "Early Care and Early Childhood Studies - Teacher Certification (BS) ",
      "Early Childhood (MED)",
      "Economics (BA)",
      "Economics (BBA) ",
      "Economics and Finance - Double Major (BBA)",
      "Education - Interdisciplinary Studies (BIS)",
      "Educational Leadership (EdD)",
      "Educational Leadership (MED)",
      "Educational Technology (MEd)",
      "Electrical Engineering (BSEE)",
      "Electrical Engineering (MSE)",
      "Engineering Management (MS)",
      "Engineering Technology (BS)",
      "English (BA)",
      "English (MA)",
      "English - Interdisciplinary Studies (MAIS)",
      "English - Teacher Certification (BA)",
      "English as a Second Language (MA)",
      "Entrepreneurship and Innovation (BBA)",
      "Environmental Science (BS)",
      "Exercise Science (BS)",
      "Exercise Science (MS)",
      "Experimental Psychology (MA)",
      "Family Nurse Practitioner (MSN)",
      "Finance (BBA) ",
      "Global Commerce (MS)",
      "Global Supply Chain Management (BBA)",
      "Health (BS)",
      "Health Science (MS - Clinical Laboratory Sciences)",
      "Health Science (MS - Health Professions Education and Technology)",
      "Health Science (MS - Healthcare Administration)",
      "Health Science (MS - Healthcare Informatics)",
      "Health Science (MS - Nutrition)",
      "Health Services Technology (BAT)",
      "History (BA)",
      "History (MA)",
      "History - Interdisciplinary Studies (MAIS)",
      "History - Teacher Certification (BA)",
      "Hospitality and Tourism Management (BS)",
      "Human Dimensions of Organizations (BA) ",
      "Human Genetics (PhD)",
      "Informatics (MS)",
      "Information Systems (BBA)",
      "Integrated Health Science (BS)",
      "International Business (BBA)",
      "Kinesiology (BS)",
      "Kinesiology (MS - Health Professions Education and Technology)",
      "Kinesiology (MS - Physical Education)",
      "Kinesiology (MS - Sport Management)",
      "Kinesiology - Teacher Certification (BS)",
      "Management (BBA)",
      "Manufacturing Engineering (BSMFGE)",
      "Manufacturing Engineering (MSE)",
      "Marine Biology (BS)",
      "Marketing (BBA)",
      "Mass Communication (BA)",
      "Mathematics (BS)",
      "Mathematics (MS)",
      "Mathematics - Teacher Certification (BS)",
      "Mathematics and Statistics with Interdisciplinary Applications (PhD)",
      "Mechanical Engineering (BSME)",
      "Mechanical Engineering (MSE)",
      "Medical Laboratory Science (BS)",
      "Mexican American Studies (BA)",
      "Mexican American Studies - Interdisciplinary Studies (MAIS)",
      "Multidisciplinary Studies (BMS)",
      "Music (MM)",
      "Music - Teacher Certification (BM)",
      "Nursing (BSN)",
      "Nursing Administration (MSN)",
      "Nursing Education (MSN)",
      "Nursing Practice (DNP)",
      "Nutritional Sciences (BS)",
      "Occupational Therapy  (OTD)",
      "Ocean, Coastal and Earth Sciences (MS)",
      "Performance (BM)",
      "Philosophy (BA)",
      "Physician Assistant Studies (MPAS)",
      "Physics (BS)",
      "Physics (MS)",
      "Physics (PhD)",
      "Physics - Teacher (BS)",
      "Political Science (BA)",
      "Political Science (MA)",
      "Psychology (BS)",
      "Public Affairs (MPA)",
      "Public Heritage and Community Engagement (BAIS)",
      "Reading and Literacy (MED)",
      "Rehabilitation Counseling (PhD)",
      "Rehabilitation Services (BS)",
      "School Psychology (MA)",
      "Science and Technology - Interdisciplinary Studies (MSIS) ",
      "Social Studies Composite (BA)",
      "Social Studies Composite - Teacher Certification (BA)",
      "Social Work (BSW)",
      "Social Work (MSSW)",
      "Sociology (BA)",
      "Sociology (MS)",
      "Spanish (BA)",
      "Spanish (MA)",
      "Spanish - Teacher Certification (BA)",
      "Spanish Translation and Interpreting (BA)",
      "Spanish Translation and Interpreting (MA)",
      "Special Education (MEd)",
      "Statistics (BS)",
      "Sustainable Agriculture and Food Systems (BS)",
      "Teacher Leadership (MED)",
      "Theatre (BA)",
      "Theatre - Teacher Certification (BA)",
      "Visual Communication Design (BFA)",
      "Accountancy (BBA)",
      "Accountancy (MACC)",
      "Addiction Studies (BS)",
      "Agricultural, Environmental, and Sustainability Sciences (MS)",
      "American Sign Language and Interpretation (BS)",
      "Anthropology (BA)",
      "Anthropology - Interdisciplinary Studies (MAIS)",
      "Applied Statistics and Data Science (MS)",
      "Art (BFA)",
      "Art (MFA)",
      "Art - Teacher Certification (BA)",
      "Art History - Interdisciplinary Studies (MAIS)",
      "Bilingual Education (MED) ",
      "Biochemistry and Molecular Biology (MS)",
      "Bioethics (MS)",
      "Biology (BS)",
      "Biology (MS)",
      "Biology - Teacher Certification (BS)",
      "Biomedical Science (BS)",
      "Business Administration (MBA)",
      "Business Administration (PhD)",
      "Business Analytics (MS - Healthcare Analytics)",
      "Business Analytics (MS)",
      "Chemistry (BS)",
      "Chemistry (MS)",
      "Chemistry - Teacher Certification (BS)",
      "Civil Engineering (BS)",
      "Civil Engineering (MS)",
      "Clinical Psychology (MA)",
      "Clinical Psychology (PhD)",
      "Clinical Rehabilitation Counseling (MS)",
      "Communication (MA)",
      "Communication Sciences and Disorders (BS)",
      "Communication Sciences and Disorders (MS)",
      "Communication Studies (BA)",
      "Computer Engineering (BSCE)",
      "Computer Science (BS)",
      "Computer Science (MS)",
      "Counseling (MED)",
      "Creative Writing (MFA)",
      "Criminal Justice (BS)",
      "Criminal Justice (MS)",
      "Curriculum & Instruction (MEd - Content Specialization in Elementary Math and Science Education)",
      "Curriculum & Instruction (MEd - Content Specialization in English)",
      "Curriculum & Instruction (MEd - Content Specialization in Mathematics Education)",
      "Curriculum & Instruction (MEd - Content Specialization in Mathematics)",
      "Curriculum and Instruction (EdD)",
      "Cyber Security (BS)",
      "Dance (BA)",
      "Dance (BFA)",
      "Dance - Teacher Certification (BA)",
      "Dietetics (MS)",
      "Disaster Studies (MA)",
      "Doctor of Medicine (M.D.)",
      "Doctor of Podiatric Medicine (D.P.M.)",
      "Early Care and Early Childhood Studies (BS)",
      "Early Care and Early Childhood Studies - Teacher Certification (BS) ",
      "Early Childhood (MED)",
      "Economics (BA)",
      "Economics (BBA) ",
      "Economics and Finance - Double Major (BBA)",
      "Education - Interdisciplinary Studies (BIS)",
      "Educational Leadership (EdD)",
      "Educational Leadership (MED)",
      "Educational Technology (MEd)",
      "Electrical Engineering (BSEE)",
      "Electrical Engineering (MSE)",
      "Engineering Management (MS)",
      "Engineering Technology (BS)",
      "English (BA)",
      "English (MA)",
      "English - Interdisciplinary Studies (MAIS)",
      "English - Teacher Certification (BA)",
      "English as a Second Language (MA)",
      "Entrepreneurship and Innovation (BBA)",
      "Environmental Science (BS)",
      "Exercise Science (BS)",
      "Exercise Science (MS)",
      "Experimental Psychology (MA)",
      "Family Nurse Practitioner (MSN)",
      "Finance (BBA) ",
      "Global Commerce (MS)",
      "Global Supply Chain Management (BBA)",
      "Health (BS)",
      "Health Science (MS - Clinical Laboratory Sciences)",
      "Health Science (MS - Health Professions Education and Technology)",
      "Health Science (MS - Healthcare Administration)",
      "Health Science (MS - Healthcare Informatics)",
      "Health Science (MS - Nutrition)",
      "Health Services Technology (BAT)",
      "History (BA)",
      "History (MA)",
      "History - Interdisciplinary Studies (MAIS)",
      "History - Teacher Certification (BA)",
      "Hospitality and Tourism Management (BS)",
      "Human Dimensions of Organizations (BA) ",
      "Human Genetics (PhD)",
      "Informatics (MS)",
      "Information Systems (BBA)",
      "Integrated Health Science (BS)",
      "International Business (BBA)",
      "Kinesiology (BS)",
      "Kinesiology (MS - Health Professions Education and Technology)",
      "Kinesiology (MS - Physical Education)",
      "Kinesiology (MS - Sport Management)",
      "Kinesiology - Teacher Certification (BS)",
      "Management (BBA)",
      "Manufacturing Engineering (BSMFGE)",
      "Manufacturing Engineering (MSE)",
      "Marine Biology (BS)",
      "Marketing (BBA)",
      "Mass Communication (BA)",
      "Mathematics (BS)",
      "Mathematics (MS)",
      "Mathematics - Teacher Certification (BS)",
      "Mathematics and Statistics with Interdisciplinary Applications (PhD)",
      "Mechanical Engineering (BSME)",
      "Mechanical Engineering (MSE)",
      "Medical Laboratory Science (BS)",
      "Mexican American Studies (BA)",
      "Mexican American Studies - Interdisciplinary Studies (MAIS)",
      "Multidisciplinary Studies (BMS)",
      "Music (MM)",
      "Music - Teacher Certification (BM)",
      "Nursing (BSN)",
      "Nursing Administration (MSN)",
      "Nursing Education (MSN)",
      "Nursing Practice (DNP)",
      "Nutritional Sciences (BS)",
      "Occupational Therapy  (OTD)",
      "Ocean, Coastal and Earth Sciences (MS)",
      "Performance (BM)",
      "Philosophy (BA)",
      "Physician Assistant Studies (MPAS)",
      "Physics (BS)",
      "Physics (MS)",
      "Physics (PhD)",
      "Physics - Teacher (BS)",
      "Political Science (BA)",
      "Political Science (MA)",
      "Psychology (BS)",
      "Public Affairs (MPA)",
      "Public Heritage and Community Engagement (BAIS)",
      "Reading and Literacy (MED)",
      "Rehabilitation Counseling (PhD)",
      "Rehabilitation Services (BS)",
      "School Psychology (MA)",
      "Science and Technology - Interdisciplinary Studies (MSIS) ",
      "Social Studies Composite (BA)",
      "Social Studies Composite - Teacher Certification (BA)",
      "Social Work (BSW)",
      "Social Work (MSSW)",
      "Sociology (BA)",
      "Sociology (MS)",
      "Spanish (BA)",
      "Spanish (MA)",
      "Spanish - Teacher Certification (BA)",
      "Spanish Translation and Interpreting (BA)",
      "Spanish Translation and Interpreting (MA)",
      "Special Education (MEd)",
      "Statistics (BS)",
      "Sustainable Agriculture and Food Systems (BS)",
      "Teacher Leadership (MED)",
      "Theatre (BA)",
      "Theatre - Teacher Certification (BA)",
      "Visual Communication Design (BFA)"
    ];

    //TODO:

    if (user == null) {
      return const Authenticate();
    } else {
      return StreamProvider<DocumentSnapshot?>.value(
        value: user.userData(),
        initialData: null,
        child: const OnboardToggler(),
      );
    }
  }
}

class OnboardToggler extends StatelessWidget {
  const OnboardToggler({super.key});

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot? userData = Provider.of<DocumentSnapshot?>(context);
    if (userData?.data() != null) {
      return const HomePage();
    } else {
      return const OnBoard();
    }
  }
}

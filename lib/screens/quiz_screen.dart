import 'package:flutter/material.dart';
import '../models/question.dart';
import '../utils/constants.dart';
import '../widgets/option_button.dart';
import 'dart:math';
import '../services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  final AuthService authService;
  final String? category;
  const QuizScreen({super.key, required this.authService, this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;
  int? selectedOption;

  List<Question> _quizQuestions = [];

  @override
  void initState() {
    super.initState();
    _generateRandomQuestions();
  }

  void _generateRandomQuestions() {
    List<Question> availableQuestions;

    if (widget.category != null) {
      availableQuestions = dummyQuestions
          .where((q) => q.category == widget.category)
          .toList();
    } else {
      availableQuestions = List.from(dummyQuestions);
    }

    if (availableQuestions.length < 10) {
      _quizQuestions = List.from(availableQuestions);
    } else {
      final random = Random();
      _quizQuestions = (List.from(availableQuestions)..shuffle(random))
          .take(10)
          .toList()
          .cast<Question>();
    }
  }

  void answerQuestion(int selected) {
    setState(() {
      selectedOption = selected;
      if (selected == _quizQuestions[currentQuestion].correctAnswerIndex) {
        score++;
      }
      Future.delayed(Duration(milliseconds: 600), () {
        if (currentQuestion < _quizQuestions.length - 1) {
          setState(() {
            currentQuestion++;
            selectedOption = null;
          });
        } else {
          setState(() {
            quizFinished = true;
            _saveScore();
          });
        }
      });
    });
  }

  Future<void> _saveScore() async {
    final currentUser = widget.authService.currentUser;
    if (currentUser != null) {
      final bool updated = await widget.authService.updateUserHighScore(
        currentUser.username,
        score,
      );
      if (updated && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Skor tinggi baru Anda telah disimpan!')),
        );
      }
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      quizFinished = false;
      selectedOption = null;
      _generateRandomQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('QuizOn!')),
        body: Center(
          child: Text(
            'Tidak ada pertanyaan untuk kategori ini.',
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (quizFinished) {
      return Scaffold(
        appBar: AppBar(title: Text('QuizOn!')),
        body: Padding(
          padding: kPaddingL,
          child: Center(
            child: Card(
              elevation: kElevationL,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadiusL),
              ),
              child: Padding(
                padding: kPaddingXL,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 80,
                      color: kAccentColor,
                    ),
                    SizedBox(height: kSpacingL),
                    Text(
                      'Quiz Selesai!',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    SizedBox(height: kSpacingM),
                    Text(
                      'Skor kamu:',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: kSpacingS),
                    Container(
                      padding: kPaddingM,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(kRadiusM),
                      ),
                      child: Text(
                        '$score / ${_quizQuestions.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: kSpacingXL),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: kPaddingM,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kRadiusM),
                          ),
                          elevation: kElevationM,
                        ),
                        onPressed: restartQuiz,
                        child: Text(
                          'Ulang Quiz',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: kSpacingM),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kPrimaryColor,
                          padding: kPaddingM,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kRadiusM),
                          ),
                          side: BorderSide(color: kPrimaryColor, width: 2),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Kembali ke Home',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    final q = _quizQuestions[currentQuestion];
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizOn!'),
      ),
      body: AnimatedOpacity(
        opacity: selectedOption == null ? 1.0 : 0.7,
        duration: Duration(milliseconds: 300),
        child: Padding(
          padding: kPaddingL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pertanyaan ${currentQuestion + 1} / ${_quizQuestions.length}',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
              SizedBox(height: kSpacingL),
              Card(
                elevation: kElevationL,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusL),
                ),
                child: Padding(
                  padding: kPaddingL,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        q.question,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      SizedBox(height: kSpacingXL),
                      ...List.generate(q.options.length, (i) {
                        return OptionButton(
                          text: q.options[i],
                          onTap: selectedOption == null ? () => answerQuestion(i) : null,
                          isSelected: selectedOption == i,
                          isCorrect: i == q.correctAnswerIndex,
                          showResult: selectedOption != null,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
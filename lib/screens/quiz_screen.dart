import 'package:flutter/material.dart';
import '../models/question.dart';
import '../utils/constants.dart';
import '../widgets/option_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;
  int? selectedOption;

  void answerQuestion(int selected) {
    setState(() {
      selectedOption = selected;
      if (selected == dummyQuestions[currentQuestion].correctAnswerIndex) {
        score++;
      }
      Future.delayed(Duration(milliseconds: 600), () {
        if (currentQuestion < dummyQuestions.length - 1) {
          setState(() {
            currentQuestion++;
            selectedOption = null;
          });
        } else {
          setState(() {
            quizFinished = true;
          });
        }
      });
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      quizFinished = false;
      selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    SizedBox(height: kSpacingM),
                    Text(
                      'Skor kamu:',
                      style: TextStyle(
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
                        '$score / ${dummyQuestions.length}',
                        style: TextStyle(
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
                        ),
                        onPressed: restartQuiz,
                        child: Text(
                          'Ulang Quiz',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

    final q = dummyQuestions[currentQuestion];
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
                'Pertanyaan ${currentQuestion + 1} / ${dummyQuestions.length}',
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
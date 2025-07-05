import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedOption;
  final int? correctAnswer;
  final void Function(int) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
    this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(question, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ...List.generate(options.length, (i) {
              Color? btnColor;
              if (selectedOption != null) {
                if (i == correctAnswer) {
                  btnColor = Colors.green;
                } else if (i == selectedOption) {
                  btnColor = Colors.red;
                } else {
                  btnColor = Colors.grey[300];
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: selectedOption == null ? () => onOptionSelected(i) : null,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(options[i], style: TextStyle(fontSize: 16)),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
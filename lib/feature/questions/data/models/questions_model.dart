class QuestionsModel {
  final String? question;
  final Map<int, dynamic>? answers;

  QuestionsModel({
    this.question,
    this.answers,
  });

  static List<QuestionsModel> questions = [
    QuestionsModel(
      question: 'هل تمارس الرياضة ؟',
      answers: {
        0: 'نعم',
        1: 'لا',
      },
    ),
    QuestionsModel(
      question: 'كم عدد ساعات النوم ؟',
      answers: {
        1: '8 ساعات',
        0: 'أقل من 8 ساعات',
        2: 'أكثر من 8 ساعات',
      },
    ),
    QuestionsModel(
      question:
          'أي من الأمراض أو المشاكل التي تعاني\n منها ( يمكن تحديد أكثر من إختيار ) ؟',
      answers: {
        1: 'ثبات الوزن ',
        0: 'سمنة',
        2: 'نحافة ',
        3: 'ضغط',
        4: 'سكر',
      },
    ),
    QuestionsModel(
      question: 'كم لتر ماء تتناوله يوميا ؟',
      answers: {
        1: '2 لتر',
        0: 'أقل من 2 لتر',
        2: 'أكثر من 2 لتر',
      },
    ),
    QuestionsModel(
      question: 'ما هو هدفك من إتباع نظام غذائي ؟',
      answers: {
        1: 'زيادة الوزن',
        0: 'خسارة الوزن',
        2: 'ثبات الوزن',
      },
    ),
  ];
}

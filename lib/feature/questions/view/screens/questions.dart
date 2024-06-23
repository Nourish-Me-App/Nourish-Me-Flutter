import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/imports/questions_screen_imports.dart';
import '../../../../core/routing/routes.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late QuestionsUICubit questionsUICubit;
  late QuestionsCubit questionsCubit;

  @override
  void initState() {
    super.initState();
    questionsUICubit = BlocProvider.of<QuestionsUICubit>(context);
    questionsCubit = BlocProvider.of<QuestionsCubit>(context);
    questionsCubit.fetchQuestionsAnswers(AppConstants.questions);
  }

  @override
  void dispose() {
    questionsCubit.close();
    questionsUICubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
          child: BlocConsumer<QuestionsCubit, QuestionsState>(
            listener: (context, state) {
              if (state is PostQuestionsFailureState) {
                Navigator.pop(context);
                HelperMethods.showCustomSnackBarError(
                  context,
                  ErrorMessages.errorMessage(state.error),
                );
              }
              if (state is PostQuestionsLoadingState) {
                HelperMethods.showLoadingAlertDialog(context);
              }
              if (state is PostQuestionsSuccessState) {
                Navigator.pop(context);
                CacheHelper().saveData(
                  key: AppConstants.isFirstQuestionsComplete,
                  value: 'yes',
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.bottomNavBar,
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is QuestionsSuccessState) {
                QuestionAndAnswerModel questionsAndAnswersModel =
                    state.questionAndAnswerModel;
                return BlocBuilder<QuestionsUICubit, QuestionsUIState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            'أجب علي الأسئلة التالية',
                            style: AppTextStyles.cairo18BoldBlack
                                .copyWith(fontSize: 16.sp),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CurrentQuestion(
                          index: questionsUICubit.questionNumber.toInt(),
                          numberOfQuestions:
                              questionsAndAnswersModel.data!.questions!.length -
                                  1,
                        ),
                        SizedBox(height: 28.h),
                        Center(
                          child: SvgPicture.asset(Assets.svgsAuthQuestion),
                        ),
                        SizedBox(height: 20.h),
                        QuestionsView(
                          questionsAndAnswersModel: questionsAndAnswersModel,
                          questionsUICubit: questionsUICubit,
                          questionsCubit: questionsCubit,
                        ),
                        questionsUICubit.validate()
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  '! يجب اختيار واحد من الاختيارات السابقة',
                                  style:
                                      AppTextStyles.cairo11MediumTFFErrorColor,
                                ),
                              )
                            : SizedBox(height: 24.h),
                        QuestionsButtons(
                          questionsUICubit: questionsUICubit,
                          questionsCubit: questionsCubit,
                        ),
                      ],
                    );
                  },
                );
              } else if (state is QuestionsFailureState) {
                return OnQuestionsError(
                  questionsCubit: questionsCubit,
                  title: ErrorMessages.errorMessage(state.error),
                );
              } else {
                return Shimmer.fromColors(
                  baseColor: AppColors.currentQuestionColor,
                  highlightColor: AppColors.otpBackGround,
                  child: const CustomQuestionLoading(),
                );
              }
            },
            buildWhen: (context, state) {
              return state is QuestionsSuccessState ||
                  state is QuestionsLoadingState ||
                  state is QuestionsFailureState;
            },
          ),
        ),
      ),
    );
  }
}

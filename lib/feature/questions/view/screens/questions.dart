import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/imports/questions_screen_imports.dart';
import '../../../../core/routing/routes.dart';

class Questions extends StatefulWidget {
  final String? loginType;
  const Questions({super.key, required this.loginType});

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
    questionsCubit.fetchQuestionsAnswers(AppConstants.questions,
        loginType: widget.loginType);
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
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
                widget.loginType == 'googleLogin'
                    ? CacheHelper().saveData(
                        key: 'isFirstQuestionsCompleteGoogle',
                        value: 'yes',
                      )
                    : CacheHelper().saveData(
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
                    return SingleChildScrollView(
                      child: Column(
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
                            numberOfQuestions: questionsAndAnswersModel
                                    .data!.questions!.length -
                                1,
                          ),
                          SizedBox(height: 28.h),
                          Center(
                            child: SvgPicture.asset(Assets.svgsAuthQuestion),
                          ),
                          SizedBox(height: 20.h),
                          questionsUICubit.questionNumber == 2
                              ? num.parse(CacheHelper().getData(
                                          key: widget.loginType == 'googleLogin'
                                              ? 'googleBmi'
                                              : 'bmi')) >=
                                      25
                                  ? Center(
                                      child: Text(
                                        'انت تعاني من السمنة بناءا علي مؤشر كتلة الجسم',
                                        style: AppTextStyles
                                            .cairosemibold16black
                                            .copyWith(fontSize: 14.sp),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          questionsUICubit.questionNumber == 2
                              ? num.parse(CacheHelper().getData(
                                          key: widget.loginType == 'googleLogin'
                                              ? 'googleBmi'
                                              : 'bmi')) <=
                                      18.5
                                  ? Center(
                                      child: Text(
                                        'انت تعاني من النحافة بناءا علي مؤشر كتلة الجسم',
                                        style: AppTextStyles
                                            .cairosemibold16black
                                            .copyWith(fontSize: 14.sp),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          num.parse(CacheHelper().getData(
                                          key: widget.loginType == 'googleLogin'
                                              ? 'googleBmi'
                                              : 'bmi')) >=
                                      25 ||
                                  num.parse(CacheHelper().getData(
                                          key: widget.loginType == 'googleLogin'
                                              ? 'googleBmi'
                                              : 'bmi')) <=
                                      18.4
                              ? SizedBox(height: 10.h)
                              : Container(),
                          QuestionsView(
                            loginType: widget.loginType,
                            questionsAndAnswersModel: questionsAndAnswersModel,
                            questionsUICubit: questionsUICubit,
                            questionsCubit: questionsCubit,
                          ),
                          questionsUICubit.validate()
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text(
                                    '! يجب اختيار واحد من الاختيارات السابقة',
                                    style: AppTextStyles
                                        .cairo11MediumTFFErrorColor,
                                  ),
                                )
                              : SizedBox(height: 24.h),
                          QuestionsButtons(
                            loginType: widget.loginType,
                            questionsUICubit: questionsUICubit,
                            questionsCubit: questionsCubit,
                          ),
                          questionsUICubit.questionNumber == 2 &&
                                  (questionsUICubit.questionThreeValue == 0 ||
                                      questionsUICubit.questionThreeValue == 1)
                              ? SizedBox(height: 16.h)
                              : Container(),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is QuestionsFailureState) {
                return OnQuestionsError(
                  loginType: widget.loginType!,
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

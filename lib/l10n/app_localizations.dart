import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Path of Light'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Journey Through Islamic Knowledge'**
  String get appTagline;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// No description provided for @signInWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get signInWithFacebook;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourName;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmail;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get emailAlreadyInUse;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @authenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get authenticationFailed;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get startQuiz;

  /// No description provided for @continueQuiz.
  ///
  /// In en, this message translates to:
  /// **'Continue Quiz'**
  String get continueQuiz;

  /// No description provided for @quizResults.
  ///
  /// In en, this message translates to:
  /// **'Quiz Results'**
  String get quizResults;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @selectDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Select Difficulty'**
  String get selectDifficulty;

  /// No description provided for @basic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @ofText.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofText;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// No description provided for @totalQuestions.
  ///
  /// In en, this message translates to:
  /// **'Total Questions'**
  String get totalQuestions;

  /// No description provided for @correctAnswers.
  ///
  /// In en, this message translates to:
  /// **'Correct Answers'**
  String get correctAnswers;

  /// No description provided for @wrongAnswers.
  ///
  /// In en, this message translates to:
  /// **'Wrong Answers'**
  String get wrongAnswers;

  /// No description provided for @timeSpent.
  ///
  /// In en, this message translates to:
  /// **'Time Spent'**
  String get timeSpent;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @viewResults.
  ///
  /// In en, this message translates to:
  /// **'View Results'**
  String get viewResults;

  /// No description provided for @shareResults.
  ///
  /// In en, this message translates to:
  /// **'Share Results'**
  String get shareResults;

  /// No description provided for @explanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get explanation;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @noQuestionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No questions available'**
  String get noQuestionsAvailable;

  /// No description provided for @loadingQuestions.
  ///
  /// In en, this message translates to:
  /// **'Loading questions...'**
  String get loadingQuestions;

  /// No description provided for @questionsLoaded.
  ///
  /// In en, this message translates to:
  /// **'{count} questions loaded'**
  String questionsLoaded(int count);

  /// No description provided for @prophet_muhammad.
  ///
  /// In en, this message translates to:
  /// **'Prophet Muhammad (PBUH)'**
  String get prophet_muhammad;

  /// No description provided for @imam_ali.
  ///
  /// In en, this message translates to:
  /// **'Imam Ali (AS)'**
  String get imam_ali;

  /// No description provided for @imam_hassan.
  ///
  /// In en, this message translates to:
  /// **'Imam Hassan (AS)'**
  String get imam_hassan;

  /// No description provided for @imam_hussain.
  ///
  /// In en, this message translates to:
  /// **'Imam Hussain (AS)'**
  String get imam_hussain;

  /// No description provided for @imam_sajjad.
  ///
  /// In en, this message translates to:
  /// **'Imam Sajjad (AS)'**
  String get imam_sajjad;

  /// No description provided for @imam_baqir.
  ///
  /// In en, this message translates to:
  /// **'Imam Baqir (AS)'**
  String get imam_baqir;

  /// No description provided for @imam_sadiq.
  ///
  /// In en, this message translates to:
  /// **'Imam Sadiq (AS)'**
  String get imam_sadiq;

  /// No description provided for @imam_kadhim.
  ///
  /// In en, this message translates to:
  /// **'Imam Kadhim (AS)'**
  String get imam_kadhim;

  /// No description provided for @imam_ridha.
  ///
  /// In en, this message translates to:
  /// **'Imam Ridha (AS)'**
  String get imam_ridha;

  /// No description provided for @imam_jawad.
  ///
  /// In en, this message translates to:
  /// **'Imam Jawad (AS)'**
  String get imam_jawad;

  /// No description provided for @imam_hadi.
  ///
  /// In en, this message translates to:
  /// **'Imam Hadi (AS)'**
  String get imam_hadi;

  /// No description provided for @imam_askari.
  ///
  /// In en, this message translates to:
  /// **'Imam Askari (AS)'**
  String get imam_askari;

  /// No description provided for @imam_mahdi.
  ///
  /// In en, this message translates to:
  /// **'Imam Mahdi (AS)'**
  String get imam_mahdi;

  /// No description provided for @lady_fatimah.
  ///
  /// In en, this message translates to:
  /// **'Lady Fatimah (AS)'**
  String get lady_fatimah;

  /// No description provided for @companions.
  ///
  /// In en, this message translates to:
  /// **'Companions & Friends'**
  String get companions;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @surahs.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahs;

  /// No description provided for @juz.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get juz;

  /// No description provided for @verses.
  ///
  /// In en, this message translates to:
  /// **'Verses'**
  String get verses;

  /// No description provided for @hadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadith;

  /// No description provided for @fiqh.
  ///
  /// In en, this message translates to:
  /// **'Fiqh'**
  String get fiqh;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'Islamic History'**
  String get history;

  /// No description provided for @practices.
  ///
  /// In en, this message translates to:
  /// **'Islamic Practices'**
  String get practices;

  /// No description provided for @ethics.
  ///
  /// In en, this message translates to:
  /// **'Ethics & Morality'**
  String get ethics;

  /// No description provided for @theology.
  ///
  /// In en, this message translates to:
  /// **'Theology'**
  String get theology;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @hearts.
  ///
  /// In en, this message translates to:
  /// **'Hearts'**
  String get hearts;

  /// No description provided for @heartsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} hearts remaining'**
  String heartsRemaining(int count);

  /// No description provided for @outOfEnergy.
  ///
  /// In en, this message translates to:
  /// **'Out of Energy'**
  String get outOfEnergy;

  /// No description provided for @refillEnergy.
  ///
  /// In en, this message translates to:
  /// **'Refill Energy'**
  String get refillEnergy;

  /// No description provided for @energyRefillsIn.
  ///
  /// In en, this message translates to:
  /// **'Energy refills in'**
  String get energyRefillsIn;

  /// No description provided for @nextHeartIn.
  ///
  /// In en, this message translates to:
  /// **'Next heart in'**
  String get nextHeartIn;

  /// No description provided for @watchAdForHeart.
  ///
  /// In en, this message translates to:
  /// **'Watch ad for 1 heart'**
  String get watchAdForHeart;

  /// No description provided for @unlimitedEnergy.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Energy'**
  String get unlimitedEnergy;

  /// No description provided for @getPremium.
  ///
  /// In en, this message translates to:
  /// **'Get Premium'**
  String get getPremium;

  /// No description provided for @energyRefilled.
  ///
  /// In en, this message translates to:
  /// **'Energy Refilled!'**
  String get energyRefilled;

  /// No description provided for @energyFull.
  ///
  /// In en, this message translates to:
  /// **'Your energy is full'**
  String get energyFull;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @dayStreak.
  ///
  /// In en, this message translates to:
  /// **'{count} Day Streak'**
  String dayStreak(int count);

  /// No description provided for @loginStreak.
  ///
  /// In en, this message translates to:
  /// **'Login Streak'**
  String get loginStreak;

  /// No description provided for @quizStreak.
  ///
  /// In en, this message translates to:
  /// **'Quiz Streak'**
  String get quizStreak;

  /// No description provided for @keepItGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep it going!'**
  String get keepItGoing;

  /// No description provided for @streakLost.
  ///
  /// In en, this message translates to:
  /// **'Streak Lost'**
  String get streakLost;

  /// No description provided for @streakFrozen.
  ///
  /// In en, this message translates to:
  /// **'Streak Frozen'**
  String get streakFrozen;

  /// No description provided for @freezeStreak.
  ///
  /// In en, this message translates to:
  /// **'Freeze Streak'**
  String get freezeStreak;

  /// No description provided for @streakDetails.
  ///
  /// In en, this message translates to:
  /// **'Streak Details'**
  String get streakDetails;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get longestStreak;

  /// No description provided for @totalLogins.
  ///
  /// In en, this message translates to:
  /// **'Total Logins'**
  String get totalLogins;

  /// No description provided for @lastLoginDate.
  ///
  /// In en, this message translates to:
  /// **'Last Login'**
  String get lastLoginDate;

  /// No description provided for @consecutiveDays.
  ///
  /// In en, this message translates to:
  /// **'Consecutive Days'**
  String get consecutiveDays;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @streakCelebration.
  ///
  /// In en, this message translates to:
  /// **'You\'re on fire! {count} days in a row!'**
  String streakCelebration(int count);

  /// No description provided for @loginStreakMilestone.
  ///
  /// In en, this message translates to:
  /// **'Alhamdulillah! You reached a {count}-day login streak!'**
  String loginStreakMilestone(int count);

  /// No description provided for @topLearners.
  ///
  /// In en, this message translates to:
  /// **'Top Learners'**
  String get topLearners;

  /// No description provided for @yourRank.
  ///
  /// In en, this message translates to:
  /// **'Your Rank'**
  String get yourRank;

  /// No description provided for @rank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rank;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @totalPoints.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get totalPoints;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @sortByPoints.
  ///
  /// In en, this message translates to:
  /// **'Sort by Points'**
  String get sortByPoints;

  /// No description provided for @sortByStreak.
  ///
  /// In en, this message translates to:
  /// **'Sort by Streak'**
  String get sortByStreak;

  /// No description provided for @sortByAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Sort by Accuracy'**
  String get sortByAccuracy;

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compare;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @addFriend.
  ///
  /// In en, this message translates to:
  /// **'Add Friend'**
  String get addFriend;

  /// No description provided for @challenge.
  ///
  /// In en, this message translates to:
  /// **'Challenge'**
  String get challenge;

  /// No description provided for @noLeaderboardData.
  ///
  /// In en, this message translates to:
  /// **'No leaderboard data available'**
  String get noLeaderboardData;

  /// No description provided for @competeFriends.
  ///
  /// In en, this message translates to:
  /// **'Compete with friends and climb the ranks'**
  String get competeFriends;

  /// No description provided for @noLeadersYet.
  ///
  /// In en, this message translates to:
  /// **'No leaders yet'**
  String get noLeadersYet;

  /// No description provided for @startQuizToCompete.
  ///
  /// In en, this message translates to:
  /// **'Start taking quizzes to compete on the leaderboard'**
  String get startQuizToCompete;

  /// No description provided for @failedLoadLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Failed to load leaderboard'**
  String get failedLoadLeaderboard;

  /// No description provided for @unranked.
  ///
  /// In en, this message translates to:
  /// **'Unranked'**
  String get unranked;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get inviteFriends;

  /// No description provided for @inviteFriendsGetEnergy.
  ///
  /// In en, this message translates to:
  /// **'Invite friends and earn bonus energy for each friend who joins!'**
  String get inviteFriendsGetEnergy;

  /// No description provided for @energyPerInvite.
  ///
  /// In en, this message translates to:
  /// **'+20 energy per successful invite'**
  String get energyPerInvite;

  /// No description provided for @buildLearningCommunity.
  ///
  /// In en, this message translates to:
  /// **'Build your learning community'**
  String get buildLearningCommunity;

  /// No description provided for @shareInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Share Invite Link'**
  String get shareInviteLink;

  /// No description provided for @shareInviteDesc.
  ///
  /// In en, this message translates to:
  /// **'Share your invite code with friends and family'**
  String get shareInviteDesc;

  /// No description provided for @joinPathOfLight.
  ///
  /// In en, this message translates to:
  /// **'Join me on Path of Light!'**
  String get joinPathOfLight;

  /// No description provided for @inviteMessage.
  ///
  /// In en, this message translates to:
  /// **'Join me on Path of Light - A journey through Islamic knowledge! Use my invite code to get started: {link}'**
  String inviteMessage(String link);

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questions;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @joinedDate.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joinedDate;

  /// No description provided for @lastActive.
  ///
  /// In en, this message translates to:
  /// **'Last Active'**
  String get lastActive;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @questionsAnswered.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questionsAnswered;

  /// No description provided for @correctRate.
  ///
  /// In en, this message translates to:
  /// **'Correct Rate'**
  String get correctRate;

  /// No description provided for @averageScore.
  ///
  /// In en, this message translates to:
  /// **'Average Score'**
  String get averageScore;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// No description provided for @categoriesMastered.
  ///
  /// In en, this message translates to:
  /// **'Categories Mastered'**
  String get categoriesMastered;

  /// No description provided for @favoriteCategory.
  ///
  /// In en, this message translates to:
  /// **'Favorite Category'**
  String get favoriteCategory;

  /// No description provided for @friends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// No description provided for @addFriends.
  ///
  /// In en, this message translates to:
  /// **'Add Friends'**
  String get addFriends;

  /// No description provided for @pendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests'**
  String get pendingRequests;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get removePhoto;

  /// No description provided for @quizProgress.
  ///
  /// In en, this message translates to:
  /// **'Quiz Progress'**
  String get quizProgress;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get emailVerified;

  /// No description provided for @phoneVerified.
  ///
  /// In en, this message translates to:
  /// **'Phone Verified'**
  String get phoneVerified;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @accountStatus.
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get accountStatus;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @previewMode.
  ///
  /// In en, this message translates to:
  /// **'Preview Mode - Mock Data'**
  String get previewMode;

  /// No description provided for @signInToViewProfile.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view your actual profile'**
  String get signInToViewProfile;

  /// No description provided for @signInToConnectFriends.
  ///
  /// In en, this message translates to:
  /// **'Sign in to connect with friends'**
  String get signInToConnectFriends;

  /// No description provided for @buildYourLearningCommunity.
  ///
  /// In en, this message translates to:
  /// **'Search for friends, send requests, and build your learning community'**
  String get buildYourLearningCommunity;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @noFriendsYet.
  ///
  /// In en, this message translates to:
  /// **'No friends yet'**
  String get noFriendsYet;

  /// No description provided for @searchForUsersToAdd.
  ///
  /// In en, this message translates to:
  /// **'Search for users to add as friends'**
  String get searchForUsersToAdd;

  /// No description provided for @noPendingRequests.
  ///
  /// In en, this message translates to:
  /// **'No pending requests'**
  String get noPendingRequests;

  /// No description provided for @receivedRequests.
  ///
  /// In en, this message translates to:
  /// **'Received Requests'**
  String get receivedRequests;

  /// No description provided for @sentRequests.
  ///
  /// In en, this message translates to:
  /// **'Sent Requests'**
  String get sentRequests;

  /// No description provided for @enterUsernameOrCode.
  ///
  /// In en, this message translates to:
  /// **'Enter a username or user code'**
  String get enterUsernameOrCode;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsersFound;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @removeFriend.
  ///
  /// In en, this message translates to:
  /// **'Remove Friend'**
  String get removeFriend;

  /// No description provided for @wantsToBeYourFriend.
  ///
  /// In en, this message translates to:
  /// **'Wants to be your friend'**
  String get wantsToBeYourFriend;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get requestSent;

  /// No description provided for @allAchievements.
  ///
  /// In en, this message translates to:
  /// **'All Achievements'**
  String get allAchievements;

  /// No description provided for @unlockedAchievements.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlockedAchievements;

  /// No description provided for @lockedAchievements.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get lockedAchievements;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @rewardPoints.
  ///
  /// In en, this message translates to:
  /// **'Reward: {points} points'**
  String rewardPoints(int points);

  /// No description provided for @todaysPrayers.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Prayers'**
  String get todaysPrayers;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @midnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get midnight;

  /// No description provided for @prayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimes;

  /// No description provided for @islamicCalendar.
  ///
  /// In en, this message translates to:
  /// **'Islamic Calendar'**
  String get islamicCalendar;

  /// No description provided for @islamicDate.
  ///
  /// In en, this message translates to:
  /// **'Islamic Date'**
  String get islamicDate;

  /// No description provided for @gregorianDate.
  ///
  /// In en, this message translates to:
  /// **'Gregorian Date'**
  String get gregorianDate;

  /// No description provided for @dailyDua.
  ///
  /// In en, this message translates to:
  /// **'Daily Du\'a'**
  String get dailyDua;

  /// No description provided for @duaOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Du\'a of the Day'**
  String get duaOfTheDay;

  /// No description provided for @dailyDuas.
  ///
  /// In en, this message translates to:
  /// **'Daily Du\'as'**
  String get dailyDuas;

  /// No description provided for @spiritualGoals.
  ///
  /// In en, this message translates to:
  /// **'Spiritual Goals'**
  String get spiritualGoals;

  /// No description provided for @dailyChecklist.
  ///
  /// In en, this message translates to:
  /// **'Daily Checklist'**
  String get dailyChecklist;

  /// No description provided for @dailySpiritualChecklist.
  ///
  /// In en, this message translates to:
  /// **'Daily Spiritual Checklist'**
  String get dailySpiritualChecklist;

  /// No description provided for @reciteQuran.
  ///
  /// In en, this message translates to:
  /// **'Recite Quran'**
  String get reciteQuran;

  /// No description provided for @performSalah.
  ///
  /// In en, this message translates to:
  /// **'Perform Salah'**
  String get performSalah;

  /// No description provided for @makeDua.
  ///
  /// In en, this message translates to:
  /// **'Make Du\'a'**
  String get makeDua;

  /// No description provided for @giveCharity.
  ///
  /// In en, this message translates to:
  /// **'Give Charity'**
  String get giveCharity;

  /// No description provided for @seekKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Seek Knowledge'**
  String get seekKnowledge;

  /// No description provided for @featuredContent.
  ///
  /// In en, this message translates to:
  /// **'Featured Content'**
  String get featuredContent;

  /// No description provided for @audioLibrary.
  ///
  /// In en, this message translates to:
  /// **'Audio Library'**
  String get audioLibrary;

  /// No description provided for @listenNow.
  ///
  /// In en, this message translates to:
  /// **'Listen Now'**
  String get listenNow;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @browseByTopic.
  ///
  /// In en, this message translates to:
  /// **'Browse by Topic'**
  String get browseByTopic;

  /// No description provided for @continueLearning.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get continueLearning;

  /// No description provided for @dailyQuizChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Quiz Challenge'**
  String get dailyQuizChallenge;

  /// No description provided for @quoteOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Quote of the Day'**
  String get quoteOfTheDay;

  /// No description provided for @testYourKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge with today\'s questions'**
  String get testYourKnowledge;

  /// No description provided for @learnAboutInfallibles.
  ///
  /// In en, this message translates to:
  /// **'Learn about the Infallibles'**
  String get learnAboutInfallibles;

  /// No description provided for @the14Masoomeen.
  ///
  /// In en, this message translates to:
  /// **'The 14 Masoomeen'**
  String get the14Masoomeen;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @bismillahTranslation.
  ///
  /// In en, this message translates to:
  /// **'In the name of Allah, the Most Gracious, the Most Merciful'**
  String get bismillahTranslation;

  /// No description provided for @islamicEvents.
  ///
  /// In en, this message translates to:
  /// **'Islamic Events'**
  String get islamicEvents;

  /// No description provided for @upcomingEvents.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Events'**
  String get upcomingEvents;

  /// No description provided for @nextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next prayer'**
  String get nextPrayer;

  /// No description provided for @unableToLoadPrayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Unable to load prayer times'**
  String get unableToLoadPrayerTimes;

  /// No description provided for @checkLocationPermissions.
  ///
  /// In en, this message translates to:
  /// **'Please check location permissions'**
  String get checkLocationPermissions;

  /// No description provided for @arabicText.
  ///
  /// In en, this message translates to:
  /// **'Arabic Text'**
  String get arabicText;

  /// No description provided for @transliteration.
  ///
  /// In en, this message translates to:
  /// **'Transliteration'**
  String get transliteration;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @meaning.
  ///
  /// In en, this message translates to:
  /// **'Meaning'**
  String get meaning;

  /// No description provided for @tafsir.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsir;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @playAudio.
  ///
  /// In en, this message translates to:
  /// **'Play Audio'**
  String get playAudio;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// No description provided for @tapToViewFull.
  ///
  /// In en, this message translates to:
  /// **'Tap to view full'**
  String get tapToViewFull;

  /// No description provided for @completedTasks.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed'**
  String completedTasks(int completed, int total);

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @pathOfLight.
  ///
  /// In en, this message translates to:
  /// **'Path of Light'**
  String get pathOfLight;

  /// No description provided for @lightOfKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Light of Knowledge'**
  String get lightOfKnowledge;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @recentlyRead.
  ///
  /// In en, this message translates to:
  /// **'Recently Read'**
  String get recentlyRead;

  /// No description provided for @searchBooks.
  ///
  /// In en, this message translates to:
  /// **'Search books...'**
  String get searchBooks;

  /// No description provided for @searchInBook.
  ///
  /// In en, this message translates to:
  /// **'Search in Book'**
  String get searchInBook;

  /// No description provided for @tableOfContents.
  ///
  /// In en, this message translates to:
  /// **'Table of Contents'**
  String get tableOfContents;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @sections.
  ///
  /// In en, this message translates to:
  /// **'Sections'**
  String get sections;

  /// No description provided for @pages.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pages;

  /// No description provided for @readingProgress.
  ///
  /// In en, this message translates to:
  /// **'Reading Progress'**
  String get readingProgress;

  /// No description provided for @continuereading.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continuereading;

  /// No description provided for @startReading.
  ///
  /// In en, this message translates to:
  /// **'Start Reading'**
  String get startReading;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @addBookmark.
  ///
  /// In en, this message translates to:
  /// **'Add Bookmark'**
  String get addBookmark;

  /// No description provided for @removeBookmark.
  ///
  /// In en, this message translates to:
  /// **'Remove Bookmark'**
  String get removeBookmark;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNote;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @deleteNote.
  ///
  /// In en, this message translates to:
  /// **'Delete Note'**
  String get deleteNote;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlights;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get fontFamily;

  /// No description provided for @textAlign.
  ///
  /// In en, this message translates to:
  /// **'Text Alignment'**
  String get textAlign;

  /// No description provided for @lineSpacing.
  ///
  /// In en, this message translates to:
  /// **'Line Spacing'**
  String get lineSpacing;

  /// No description provided for @arabicFont.
  ///
  /// In en, this message translates to:
  /// **'Arabic Font'**
  String get arabicFont;

  /// No description provided for @translationFont.
  ///
  /// In en, this message translates to:
  /// **'Translation Font'**
  String get translationFont;

  /// No description provided for @quranWithTafsir.
  ///
  /// In en, this message translates to:
  /// **'Quran with Tafsir'**
  String get quranWithTafsir;

  /// No description provided for @mafatihAlJinan.
  ///
  /// In en, this message translates to:
  /// **'Mafatih al-Jinan'**
  String get mafatihAlJinan;

  /// No description provided for @nahjAlBalagha.
  ///
  /// In en, this message translates to:
  /// **'Nahj al-Balagha'**
  String get nahjAlBalagha;

  /// No description provided for @saheefaSajjadiya.
  ///
  /// In en, this message translates to:
  /// **'Sahifa Sajjadiya'**
  String get saheefaSajjadiya;

  /// No description provided for @siratIbnHisham.
  ///
  /// In en, this message translates to:
  /// **'Sirat Ibn Hisham'**
  String get siratIbnHisham;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @prayerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Prayer Notifications'**
  String get prayerNotifications;

  /// No description provided for @quizReminders.
  ///
  /// In en, this message translates to:
  /// **'Quiz Reminders'**
  String get quizReminders;

  /// No description provided for @streakReminders.
  ///
  /// In en, this message translates to:
  /// **'Streak Reminders'**
  String get streakReminders;

  /// No description provided for @achievementNotifications.
  ///
  /// In en, this message translates to:
  /// **'Achievement Notifications'**
  String get achievementNotifications;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @setReminder.
  ///
  /// In en, this message translates to:
  /// **'Set Reminder'**
  String get setReminder;

  /// No description provided for @editReminder.
  ///
  /// In en, this message translates to:
  /// **'Edit Reminder'**
  String get editReminder;

  /// No description provided for @deleteReminder.
  ///
  /// In en, this message translates to:
  /// **'Delete Reminder'**
  String get deleteReminder;

  /// No description provided for @activeReminders.
  ///
  /// In en, this message translates to:
  /// **'Active Reminders'**
  String get activeReminders;

  /// No description provided for @noActiveReminders.
  ///
  /// In en, this message translates to:
  /// **'No active reminders'**
  String get noActiveReminders;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder Title'**
  String get reminderTitle;

  /// No description provided for @reminderMessage.
  ///
  /// In en, this message translates to:
  /// **'Reminder Message'**
  String get reminderMessage;

  /// No description provided for @triggerType.
  ///
  /// In en, this message translates to:
  /// **'Trigger Type'**
  String get triggerType;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @specificTime.
  ///
  /// In en, this message translates to:
  /// **'Specific Time'**
  String get specificTime;

  /// No description provided for @prayerTime.
  ///
  /// In en, this message translates to:
  /// **'Prayer Time'**
  String get prayerTime;

  /// No description provided for @dayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeek;

  /// No description provided for @once.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get once;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @enableSound.
  ///
  /// In en, this message translates to:
  /// **'Enable Sound'**
  String get enableSound;

  /// No description provided for @enableVibration.
  ///
  /// In en, this message translates to:
  /// **'Enable Vibration'**
  String get enableVibration;

  /// No description provided for @minutesBefore.
  ///
  /// In en, this message translates to:
  /// **'Minutes Before'**
  String get minutesBefore;

  /// No description provided for @minutesAfter.
  ///
  /// In en, this message translates to:
  /// **'Minutes After'**
  String get minutesAfter;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @selectDays.
  ///
  /// In en, this message translates to:
  /// **'Select Days'**
  String get selectDays;

  /// No description provided for @selectPrayerTime.
  ///
  /// In en, this message translates to:
  /// **'Select Prayer Time'**
  String get selectPrayerTime;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @reminderCreated.
  ///
  /// In en, this message translates to:
  /// **'Reminder created successfully'**
  String get reminderCreated;

  /// No description provided for @reminderUpdated.
  ///
  /// In en, this message translates to:
  /// **'Reminder updated successfully'**
  String get reminderUpdated;

  /// No description provided for @reminderDeleted.
  ///
  /// In en, this message translates to:
  /// **'Reminder deleted successfully'**
  String get reminderDeleted;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text Size'**
  String get textSize;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High Contrast'**
  String get highContrast;

  /// No description provided for @screenReader.
  ///
  /// In en, this message translates to:
  /// **'Screen Reader Support'**
  String get screenReader;

  /// No description provided for @prayerSettings.
  ///
  /// In en, this message translates to:
  /// **'Prayer Settings'**
  String get prayerSettings;

  /// No description provided for @calculationMethod.
  ///
  /// In en, this message translates to:
  /// **'Calculation Method'**
  String get calculationMethod;

  /// No description provided for @asrMethod.
  ///
  /// In en, this message translates to:
  /// **'Asr Calculation'**
  String get asrMethod;

  /// No description provided for @highLatitudes.
  ///
  /// In en, this message translates to:
  /// **'High Latitudes'**
  String get highLatitudes;

  /// No description provided for @prayerTimeAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Prayer Time Adjustment'**
  String get prayerTimeAdjustment;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @errorSavingData.
  ///
  /// In en, this message translates to:
  /// **'Error saving data'**
  String get errorSavingData;

  /// No description provided for @errorDeletingData.
  ///
  /// In en, this message translates to:
  /// **'Error deleting data'**
  String get errorDeletingData;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get networkError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get serverError;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get permissionDenied;

  /// No description provided for @fileNotFound.
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get fileNotFound;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid input'**
  String get invalidInput;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @dataSaved.
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully'**
  String get dataSaved;

  /// No description provided for @dataDeleted.
  ///
  /// In en, this message translates to:
  /// **'Data deleted successfully'**
  String get dataDeleted;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get settingsSaved;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked successfully'**
  String get bookmarked;

  /// No description provided for @bookmarkRemoved.
  ///
  /// In en, this message translates to:
  /// **'Bookmark removed'**
  String get bookmarkRemoved;

  /// No description provided for @noteSaved.
  ///
  /// In en, this message translates to:
  /// **'Note saved successfully'**
  String get noteSaved;

  /// No description provided for @noteDeleted.
  ///
  /// In en, this message translates to:
  /// **'Note deleted successfully'**
  String get noteDeleted;

  /// No description provided for @bismillah.
  ///
  /// In en, this message translates to:
  /// **'Bismillah al-Rahman al-Rahim'**
  String get bismillah;

  /// No description provided for @alhamdulillah.
  ///
  /// In en, this message translates to:
  /// **'Alhamdulillah'**
  String get alhamdulillah;

  /// No description provided for @subhanAllah.
  ///
  /// In en, this message translates to:
  /// **'Subhan Allah'**
  String get subhanAllah;

  /// No description provided for @mashaAllah.
  ///
  /// In en, this message translates to:
  /// **'Masha Allah'**
  String get mashaAllah;

  /// No description provided for @inshAllah.
  ///
  /// In en, this message translates to:
  /// **'Insha Allah'**
  String get inshAllah;

  /// No description provided for @jazakAllah.
  ///
  /// In en, this message translates to:
  /// **'Jazak Allah Khair'**
  String get jazakAllah;

  /// No description provided for @assalamualaikum.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum'**
  String get assalamualaikum;

  /// No description provided for @waalaikumsalam.
  ///
  /// In en, this message translates to:
  /// **'Wa Alaikum Salam'**
  String get waalaikumsalam;

  /// No description provided for @pbuh.
  ///
  /// In en, this message translates to:
  /// **'Peace be upon him'**
  String get pbuh;

  /// No description provided for @as.
  ///
  /// In en, this message translates to:
  /// **'Peace be upon them'**
  String get as;

  /// No description provided for @saww.
  ///
  /// In en, this message translates to:
  /// **'Salla Allahu Alayhi wa Alihi wa Sallam'**
  String get saww;

  /// No description provided for @ahlulBayt.
  ///
  /// In en, this message translates to:
  /// **'Ahlul Bayt'**
  String get ahlulBayt;

  /// No description provided for @the14Infallibles.
  ///
  /// In en, this message translates to:
  /// **'The 14 Infallibles'**
  String get the14Infallibles;

  /// No description provided for @twelveImams.
  ///
  /// In en, this message translates to:
  /// **'Twelve Imams'**
  String get twelveImams;

  /// No description provided for @salah.
  ///
  /// In en, this message translates to:
  /// **'Salah'**
  String get salah;

  /// No description provided for @hajj.
  ///
  /// In en, this message translates to:
  /// **'Hajj'**
  String get hajj;

  /// No description provided for @zakat.
  ///
  /// In en, this message translates to:
  /// **'Zakat'**
  String get zakat;

  /// No description provided for @sawm.
  ///
  /// In en, this message translates to:
  /// **'Sawm'**
  String get sawm;

  /// No description provided for @khums.
  ///
  /// In en, this message translates to:
  /// **'Khums'**
  String get khums;

  /// No description provided for @jihad.
  ///
  /// In en, this message translates to:
  /// **'Jihad'**
  String get jihad;

  /// No description provided for @tawhid.
  ///
  /// In en, this message translates to:
  /// **'Tawhid'**
  String get tawhid;

  /// No description provided for @adl.
  ///
  /// In en, this message translates to:
  /// **'Adl'**
  String get adl;

  /// No description provided for @nubuwwah.
  ///
  /// In en, this message translates to:
  /// **'Nubuwwah'**
  String get nubuwwah;

  /// No description provided for @imamate.
  ///
  /// In en, this message translates to:
  /// **'Imamate'**
  String get imamate;

  /// No description provided for @qiyamah.
  ///
  /// In en, this message translates to:
  /// **'Qiyamah'**
  String get qiyamah;

  /// No description provided for @myCollection.
  ///
  /// In en, this message translates to:
  /// **'My Collection'**
  String get myCollection;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @changeViewMode.
  ///
  /// In en, this message translates to:
  /// **'Change view mode'**
  String get changeViewMode;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @yourCollectionIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your collection is empty'**
  String get yourCollectionIsEmpty;

  /// No description provided for @noItemsInThisCategory.
  ///
  /// In en, this message translates to:
  /// **'No items in this category'**
  String get noItemsInThisCategory;

  /// No description provided for @addDuasSurahsZiyarats.
  ///
  /// In en, this message translates to:
  /// **'Add Du\'as, Surahs, Ziyarats and more'**
  String get addDuasSurahsZiyarats;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @noFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesYet;

  /// No description provided for @addItemsToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add items to your favorites by tapping the star icon'**
  String get addItemsToFavorites;

  /// No description provided for @tapStarIconToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap the star icon to add items to favorites'**
  String get tapStarIconToAdd;

  /// No description provided for @deleteItem.
  ///
  /// In en, this message translates to:
  /// **'Delete Item'**
  String get deleteItem;

  /// No description provided for @areYouSureDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get areYouSureDelete;

  /// No description provided for @areYouSureDeleteItem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {title}?'**
  String areYouSureDeleteItem(String title);

  /// No description provided for @itemDeleted.
  ///
  /// In en, this message translates to:
  /// **'Item deleted successfully'**
  String get itemDeleted;

  /// No description provided for @searchCollection.
  ///
  /// In en, this message translates to:
  /// **'Search Collection'**
  String get searchCollection;

  /// No description provided for @searchByTitleTextTags.
  ///
  /// In en, this message translates to:
  /// **'Search by title, text, or tags...'**
  String get searchByTitleTextTags;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String searchResults(int count, Object query);

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @itemsSaved.
  ///
  /// In en, this message translates to:
  /// **'{count} items saved'**
  String itemsSaved(int count);

  /// No description provided for @daysAsGuest.
  ///
  /// In en, this message translates to:
  /// **'{count} days as guest'**
  String daysAsGuest(int count);

  /// No description provided for @benefitsOfAccount.
  ///
  /// In en, this message translates to:
  /// **'Benefits of creating an account:'**
  String get benefitsOfAccount;

  /// No description provided for @syncAcrossDevices.
  ///
  /// In en, this message translates to:
  /// **'Sync across devices'**
  String get syncAcrossDevices;

  /// No description provided for @neverLoseData.
  ///
  /// In en, this message translates to:
  /// **'Never lose your data'**
  String get neverLoseData;

  /// No description provided for @accessFromAllDevices.
  ///
  /// In en, this message translates to:
  /// **'Access from all devices'**
  String get accessFromAllDevices;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore'**
  String get backupAndRestore;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @unfavorite.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get unfavorite;

  /// No description provided for @todaysProgress.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Progress'**
  String get todaysProgress;

  /// No description provided for @completedOf.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed'**
  String completedOf(int completed, int total);

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String percentComplete(int percent);

  /// No description provided for @noItemsInTodaysChecklist.
  ///
  /// In en, this message translates to:
  /// **'No items in today\'s checklist'**
  String get noItemsInTodaysChecklist;

  /// No description provided for @addItemsFromCollection.
  ///
  /// In en, this message translates to:
  /// **'Add items from your collection'**
  String get addItemsFromCollection;

  /// No description provided for @addToCollection.
  ///
  /// In en, this message translates to:
  /// **'Add to Collection'**
  String get addToCollection;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get selectType;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @titleEnglish.
  ///
  /// In en, this message translates to:
  /// **'Title (English)'**
  String get titleEnglish;

  /// No description provided for @enterTitleEnglish.
  ///
  /// In en, this message translates to:
  /// **'Enter title in English'**
  String get enterTitleEnglish;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// No description provided for @titleArabic.
  ///
  /// In en, this message translates to:
  /// **'Title (Arabic)'**
  String get titleArabic;

  /// No description provided for @enterTitleArabic.
  ///
  /// In en, this message translates to:
  /// **'Enter title in Arabic'**
  String get enterTitleArabic;

  /// No description provided for @arabicTextRequired.
  ///
  /// In en, this message translates to:
  /// **'Arabic Text (Required)'**
  String get arabicTextRequired;

  /// No description provided for @enterArabicText.
  ///
  /// In en, this message translates to:
  /// **'Enter Arabic text'**
  String get enterArabicText;

  /// No description provided for @arabicTextIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Arabic text is required'**
  String get arabicTextIsRequired;

  /// No description provided for @enterTranslation.
  ///
  /// In en, this message translates to:
  /// **'Enter translation'**
  String get enterTranslation;

  /// No description provided for @enterTransliteration.
  ///
  /// In en, this message translates to:
  /// **'Enter transliteration'**
  String get enterTransliteration;

  /// No description provided for @enterSource.
  ///
  /// In en, this message translates to:
  /// **'Enter source reference'**
  String get enterSource;

  /// No description provided for @personalNotes.
  ///
  /// In en, this message translates to:
  /// **'Personal Notes'**
  String get personalNotes;

  /// No description provided for @addPersonalNotes.
  ///
  /// In en, this message translates to:
  /// **'Add your personal notes'**
  String get addPersonalNotes;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @separateTagsWithCommas.
  ///
  /// In en, this message translates to:
  /// **'Separate tags with commas'**
  String get separateTagsWithCommas;

  /// No description provided for @itemAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Item added successfully'**
  String get itemAddedSuccessfully;

  /// No description provided for @dua.
  ///
  /// In en, this message translates to:
  /// **'Du\'a'**
  String get dua;

  /// No description provided for @surah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get surah;

  /// No description provided for @ayah.
  ///
  /// In en, this message translates to:
  /// **'Ayah'**
  String get ayah;

  /// No description provided for @ziyarat.
  ///
  /// In en, this message translates to:
  /// **'Ziyarat'**
  String get ziyarat;

  /// No description provided for @passage.
  ///
  /// In en, this message translates to:
  /// **'Passage'**
  String get passage;

  /// No description provided for @dhikr.
  ///
  /// In en, this message translates to:
  /// **'Dhikr'**
  String get dhikr;

  /// No description provided for @verse.
  ///
  /// In en, this message translates to:
  /// **'Verse'**
  String get verse;

  /// No description provided for @readQuran.
  ///
  /// In en, this message translates to:
  /// **'Read Quran'**
  String get readQuran;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @meccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get medinan;

  /// No description provided for @revelationType.
  ///
  /// In en, this message translates to:
  /// **'Revelation Type'**
  String get revelationType;

  /// No description provided for @verseNumber.
  ///
  /// In en, this message translates to:
  /// **'Verse {number}'**
  String verseNumber(int number);

  /// No description provided for @totalVerses.
  ///
  /// In en, this message translates to:
  /// **'{count} verses'**
  String totalVerses(int count);

  /// No description provided for @readingSurah.
  ///
  /// In en, this message translates to:
  /// **'Reading {surah}'**
  String readingSurah(String surah);

  /// No description provided for @bismillahArRahmanArRahim.
  ///
  /// In en, this message translates to:
  /// **'In the name of Allah, the Most Gracious, the Most Merciful'**
  String get bismillahArRahmanArRahim;

  /// No description provided for @noVersesFound.
  ///
  /// In en, this message translates to:
  /// **'No verses found'**
  String get noVersesFound;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @ramadhan.
  ///
  /// In en, this message translates to:
  /// **'Ramadhan'**
  String get ramadhan;

  /// No description provided for @muharram.
  ///
  /// In en, this message translates to:
  /// **'Muharram'**
  String get muharram;

  /// No description provided for @safar.
  ///
  /// In en, this message translates to:
  /// **'Safar'**
  String get safar;

  /// No description provided for @rajab.
  ///
  /// In en, this message translates to:
  /// **'Rajab'**
  String get rajab;

  /// No description provided for @shaban.
  ///
  /// In en, this message translates to:
  /// **'Sha\'ban'**
  String get shaban;

  /// No description provided for @specialOccasions.
  ///
  /// In en, this message translates to:
  /// **'Special Occasions'**
  String get specialOccasions;

  /// No description provided for @protection.
  ///
  /// In en, this message translates to:
  /// **'Protection'**
  String get protection;

  /// No description provided for @forgiveness.
  ///
  /// In en, this message translates to:
  /// **'Forgiveness'**
  String get forgiveness;

  /// No description provided for @gratitude.
  ///
  /// In en, this message translates to:
  /// **'Gratitude'**
  String get gratitude;

  /// No description provided for @healing.
  ///
  /// In en, this message translates to:
  /// **'Healing'**
  String get healing;

  /// No description provided for @guidance.
  ///
  /// In en, this message translates to:
  /// **'Guidance'**
  String get guidance;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @orSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'OR SIGN UP WITH'**
  String get orSignUpWith;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms and Conditions'**
  String get agreeToTerms;

  /// No description provided for @failedToLinkAccount.
  ///
  /// In en, this message translates to:
  /// **'Failed to link account: {error}'**
  String failedToLinkAccount(String error);

  /// No description provided for @failedToContinueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Failed to continue as guest: {error}'**
  String failedToContinueAsGuest(String error);

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @confirmSignOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get confirmSignOut;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// No description provided for @confirmDeleteBookmark.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this bookmark?'**
  String get confirmDeleteBookmark;

  /// No description provided for @confirmDeleteComment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this comment?'**
  String get confirmDeleteComment;

  /// No description provided for @confirmEndGame.
  ///
  /// In en, this message translates to:
  /// **'Going to the book will end the current game. Are you sure?'**
  String get confirmEndGame;

  /// No description provided for @signInRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in Required'**
  String get signInRequired;

  /// No description provided for @deleteBookmark.
  ///
  /// In en, this message translates to:
  /// **'Delete Bookmark'**
  String get deleteBookmark;

  /// No description provided for @deleteComment.
  ///
  /// In en, this message translates to:
  /// **'Delete Comment'**
  String get deleteComment;

  /// No description provided for @reportComment.
  ///
  /// In en, this message translates to:
  /// **'Report Comment'**
  String get reportComment;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get reportIssue;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get locationPermission;

  /// No description provided for @watchAd.
  ///
  /// In en, this message translates to:
  /// **'Watch Ad'**
  String get watchAd;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @issueType.
  ///
  /// In en, this message translates to:
  /// **'Issue Type'**
  String get issueType;

  /// No description provided for @typoSpellingError.
  ///
  /// In en, this message translates to:
  /// **'Typo/Spelling Error'**
  String get typoSpellingError;

  /// No description provided for @translationError.
  ///
  /// In en, this message translates to:
  /// **'Translation Error'**
  String get translationError;

  /// No description provided for @describeIssue.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue in detail...'**
  String get describeIssue;

  /// No description provided for @notificationTiming.
  ///
  /// In en, this message translates to:
  /// **'Notification Timing'**
  String get notificationTiming;

  /// No description provided for @pleaseDescribeIssue.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue'**
  String get pleaseDescribeIssue;

  /// No description provided for @bookmarkDeleted.
  ///
  /// In en, this message translates to:
  /// **'Bookmark deleted'**
  String get bookmarkDeleted;

  /// No description provided for @bookmarkAdded.
  ///
  /// In en, this message translates to:
  /// **'Bookmark added'**
  String get bookmarkAdded;

  /// No description provided for @commentTooLong.
  ///
  /// In en, this message translates to:
  /// **'Comment cannot exceed 500 characters'**
  String get commentTooLong;

  /// No description provided for @commentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Comment deleted'**
  String get commentDeleted;

  /// No description provided for @commentUpdated.
  ///
  /// In en, this message translates to:
  /// **'Comment updated'**
  String get commentUpdated;

  /// No description provided for @commentReported.
  ///
  /// In en, this message translates to:
  /// **'Comment reported for: {reason}. Thank you for helping keep our community safe.'**
  String commentReported(String reason);

  /// No description provided for @commentEditTimeExpired.
  ///
  /// In en, this message translates to:
  /// **'Comments can only be edited within 5 minutes'**
  String get commentEditTimeExpired;

  /// No description provided for @calendarViewComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Full calendar view coming soon!'**
  String get calendarViewComingSoon;

  /// No description provided for @collectionsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Collections page coming soon'**
  String get collectionsComingSoon;

  /// No description provided for @booksComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Books page coming soon'**
  String get booksComingSoon;

  /// No description provided for @siraComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Sira page coming soon'**
  String get siraComingSoon;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Settings page coming soon'**
  String get settingsComingSoon;

  /// No description provided for @locationPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Location permission granted'**
  String get locationPermissionGranted;

  /// No description provided for @failedToAddBookmark.
  ///
  /// In en, this message translates to:
  /// **'Failed to add bookmark: {error}'**
  String failedToAddBookmark(String error);

  /// No description provided for @purchaseSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Purchase successful! Thank you for supporting Path of Light.'**
  String get purchaseSuccessful;

  /// No description provided for @purchasesRestored.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully!'**
  String get purchasesRestored;

  /// No description provided for @errorRestoringPurchases.
  ///
  /// In en, this message translates to:
  /// **'Error restoring purchases: {error}'**
  String errorRestoringPurchases(String error);

  /// No description provided for @playerOffline.
  ///
  /// In en, this message translates to:
  /// **'{name} is currently offline'**
  String playerOffline(String name);

  /// No description provided for @startingChallenge.
  ///
  /// In en, this message translates to:
  /// **'Starting challenge with {name}...'**
  String startingChallenge(String name);

  /// No description provided for @challengeCreated.
  ///
  /// In en, this message translates to:
  /// **'Challenge created! Starting quiz...'**
  String get challengeCreated;

  /// No description provided for @dailyBonusClaimed.
  ///
  /// In en, this message translates to:
  /// **'Daily bonus claimed! +{bonus} energy'**
  String dailyBonusClaimed(int bonus);

  /// No description provided for @useBookmarkButton.
  ///
  /// In en, this message translates to:
  /// **'Use bookmark button in app bar'**
  String get useBookmarkButton;

  /// No description provided for @textCopied.
  ///
  /// In en, this message translates to:
  /// **'Text copied to clipboard'**
  String get textCopied;

  /// No description provided for @searchForText.
  ///
  /// In en, this message translates to:
  /// **'Search for text...'**
  String get searchForText;

  /// No description provided for @searchFriends.
  ///
  /// In en, this message translates to:
  /// **'Search friends...'**
  String get searchFriends;

  /// No description provided for @searchByUsernameOrCode.
  ///
  /// In en, this message translates to:
  /// **'Search by username or user code...'**
  String get searchByUsernameOrCode;

  /// No description provided for @editYourComment.
  ///
  /// In en, this message translates to:
  /// **'Edit your comment...'**
  String get editYourComment;

  /// No description provided for @streakStatistics.
  ///
  /// In en, this message translates to:
  /// **'Streak Statistics'**
  String get streakStatistics;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @userComparison.
  ///
  /// In en, this message translates to:
  /// **'User Comparison'**
  String get userComparison;

  /// No description provided for @challengeMode.
  ///
  /// In en, this message translates to:
  /// **'Challenge Mode'**
  String get challengeMode;

  /// No description provided for @purchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get purchaseHistory;

  /// No description provided for @receivePrayerNotifications.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications for prayer times'**
  String get receivePrayerNotifications;

  /// No description provided for @dailyQuizReminders.
  ///
  /// In en, this message translates to:
  /// **'Daily quiz reminders'**
  String get dailyQuizReminders;

  /// No description provided for @keepStreakGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep your streak going'**
  String get keepStreakGoing;

  /// No description provided for @newAchievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'New achievements unlocked'**
  String get newAchievementsUnlocked;

  /// No description provided for @playSoundEffects.
  ///
  /// In en, this message translates to:
  /// **'Play sound effects in app'**
  String get playSoundEffects;

  /// No description provided for @hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get hapticFeedback;

  /// No description provided for @eventNotifications.
  ///
  /// In en, this message translates to:
  /// **'Event Notifications'**
  String get eventNotifications;

  /// No description provided for @notifyAboutCelebrations.
  ///
  /// In en, this message translates to:
  /// **'Get notified about upcoming Islamic celebrations'**
  String get notifyAboutCelebrations;

  /// No description provided for @notifyDaysBefore.
  ///
  /// In en, this message translates to:
  /// **'Notify me {days} {daysLabel} before event'**
  String notifyDaysBefore(int days, String daysLabel);

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @viewAllEvents.
  ///
  /// In en, this message translates to:
  /// **'View All Events'**
  String get viewAllEvents;

  /// No description provided for @browseAllCelebrations.
  ///
  /// In en, this message translates to:
  /// **'Browse all Islamic celebrations'**
  String get browseAllCelebrations;

  /// No description provided for @enableAutoScroll.
  ///
  /// In en, this message translates to:
  /// **'Enable Auto Scroll'**
  String get enableAutoScroll;

  /// No description provided for @autoScrollWhileReading.
  ///
  /// In en, this message translates to:
  /// **'Automatically scroll while reading'**
  String get autoScrollWhileReading;

  /// No description provided for @nightMode.
  ///
  /// In en, this message translates to:
  /// **'Night Mode'**
  String get nightMode;

  /// No description provided for @reduceBrightnessNight.
  ///
  /// In en, this message translates to:
  /// **'Reduce brightness for night reading'**
  String get reduceBrightnessNight;

  /// No description provided for @pleaseSignInToViewBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view bookmarks'**
  String get pleaseSignInToViewBookmarks;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @quranAndTafsir.
  ///
  /// In en, this message translates to:
  /// **'Quran & Tafsir'**
  String get quranAndTafsir;

  /// No description provided for @duaAndZiyarat.
  ///
  /// In en, this message translates to:
  /// **'Du\'a Kumayl, Ziyarat Ashura'**
  String get duaAndZiyarat;

  /// No description provided for @nearbyMosques.
  ///
  /// In en, this message translates to:
  /// **'Nearby Mosques'**
  String get nearbyMosques;

  /// No description provided for @soundAndVibration.
  ///
  /// In en, this message translates to:
  /// **'Sound & Vibration'**
  String get soundAndVibration;

  /// No description provided for @chooseNotificationTime.
  ///
  /// In en, this message translates to:
  /// **'Choose notification time'**
  String get chooseNotificationTime;

  /// No description provided for @onTheDay.
  ///
  /// In en, this message translates to:
  /// **'On the day'**
  String get onTheDay;

  /// No description provided for @oneDayBefore.
  ///
  /// In en, this message translates to:
  /// **'1 day before'**
  String get oneDayBefore;

  /// No description provided for @oneWeekBefore.
  ///
  /// In en, this message translates to:
  /// **'1 week before'**
  String get oneWeekBefore;

  /// No description provided for @twoWeeksBefore.
  ///
  /// In en, this message translates to:
  /// **'2 weeks before'**
  String get twoWeeksBefore;

  /// No description provided for @oneMonthBefore.
  ///
  /// In en, this message translates to:
  /// **'1 month before'**
  String get oneMonthBefore;

  /// No description provided for @reportIssueMenu.
  ///
  /// In en, this message translates to:
  /// **'Report issue'**
  String get reportIssueMenu;

  /// No description provided for @noProfileData.
  ///
  /// In en, this message translates to:
  /// **'No profile data'**
  String get noProfileData;

  /// No description provided for @failedToLoadFriends.
  ///
  /// In en, this message translates to:
  /// **'Failed to load friends'**
  String get failedToLoadFriends;

  /// No description provided for @failedToLoadRequests.
  ///
  /// In en, this message translates to:
  /// **'Failed to load requests'**
  String get failedToLoadRequests;

  /// No description provided for @failedToLoadCategories.
  ///
  /// In en, this message translates to:
  /// **'Failed to load categories'**
  String get failedToLoadCategories;

  /// No description provided for @failedToLoadBooks.
  ///
  /// In en, this message translates to:
  /// **'Failed to load books'**
  String get failedToLoadBooks;

  /// No description provided for @errorWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorWithDetails(String error);

  /// No description provided for @failedToLoadBook.
  ///
  /// In en, this message translates to:
  /// **'Failed to load book: {error}'**
  String failedToLoadBook(String error);

  /// No description provided for @failedToLoadComments.
  ///
  /// In en, this message translates to:
  /// **'Failed to load comments'**
  String get failedToLoadComments;

  /// No description provided for @failedToLoadBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Failed to load bookmarks'**
  String get failedToLoadBookmarks;

  /// No description provided for @errorLoadingEnergy.
  ///
  /// In en, this message translates to:
  /// **'Error loading energy'**
  String get errorLoadingEnergy;

  /// No description provided for @signInTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInTooltip;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordRequiresUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordRequiresUppercase;

  /// No description provided for @passwordRequiresLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordRequiresLowercase;

  /// No description provided for @passwordRequiresNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordRequiresNumber;

  /// No description provided for @passwordRequiresSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get passwordRequiresSpecialChar;

  /// No description provided for @pleaseEnterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get pleaseEnterValidPhone;

  /// No description provided for @phoneLengthInvalid.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be 10-15 digits'**
  String get phoneLengthInvalid;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @nameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameMinLength;

  /// No description provided for @nameMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Name must not exceed 50 characters'**
  String get nameMaxLength;

  /// No description provided for @nameInvalidCharacters.
  ///
  /// In en, this message translates to:
  /// **'Name contains invalid characters'**
  String get nameInvalidCharacters;

  /// No description provided for @pleaseEnterUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get pleaseEnterUsername;

  /// No description provided for @usernameLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be 3-20 characters'**
  String get usernameLength;

  /// No description provided for @usernameInvalidCharacters.
  ///
  /// In en, this message translates to:
  /// **'Username can only contain letters, numbers, and underscores'**
  String get usernameInvalidCharacters;

  /// No description provided for @usernameMustStartWithLetter.
  ///
  /// In en, this message translates to:
  /// **'Username must start with a letter'**
  String get usernameMustStartWithLetter;

  /// No description provided for @pleaseEnterValidUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get pleaseEnterValidUrl;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// No description provided for @pleaseEnterNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number'**
  String get pleaseEnterNumber;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @numberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Number is too small'**
  String get numberTooSmall;

  /// No description provided for @numberTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Number is too large'**
  String get numberTooLarge;

  /// No description provided for @pleaseEnterAge.
  ///
  /// In en, this message translates to:
  /// **'Please enter your age'**
  String get pleaseEnterAge;

  /// No description provided for @pleaseEnterValidAge.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age'**
  String get pleaseEnterValidAge;

  /// No description provided for @ageTooYoung.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 13 years old'**
  String get ageTooYoung;

  /// No description provided for @ageTooOld.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age'**
  String get ageTooOld;

  /// No description provided for @pleaseEnterText.
  ///
  /// In en, this message translates to:
  /// **'Please enter text'**
  String get pleaseEnterText;

  /// No description provided for @pleaseEnterArabicText.
  ///
  /// In en, this message translates to:
  /// **'Please enter Arabic text'**
  String get pleaseEnterArabicText;

  /// No description provided for @fieldTooShort.
  ///
  /// In en, this message translates to:
  /// **'This field is too short'**
  String get fieldTooShort;

  /// No description provided for @fieldTooLong.
  ///
  /// In en, this message translates to:
  /// **'This field is too long'**
  String get fieldTooLong;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get errorOccurred;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

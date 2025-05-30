import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ms'),
    Locale('ru'),
    Locale('th'),
    Locale('ur'),
    Locale('zh')
  ];

  /// No description provided for @hotelInternalMessagingSystem.
  ///
  /// In en, this message translates to:
  /// **'Hotel  Internal Messaging System'**
  String get hotelInternalMessagingSystem;

  /// No description provided for @changesAreBeingApplied.
  ///
  /// In en, this message translates to:
  /// **'Changes are being applied'**
  String get changesAreBeingApplied;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @noInternetPleaseCheckYourConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet - Please check your connection'**
  String get noInternetPleaseCheckYourConnection;

  /// No description provided for @youHaveReceivedThisRequest.
  ///
  /// In en, this message translates to:
  /// **'You have received this request'**
  String get youHaveReceivedThisRequest;

  /// No description provided for @setTime.
  ///
  /// In en, this message translates to:
  /// **'Set Time'**
  String get setTime;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @sortTaskBy.
  ///
  /// In en, this message translates to:
  /// **'Sort Task By'**
  String get sortTaskBy;

  /// No description provided for @locationTarget.
  ///
  /// In en, this message translates to:
  /// **'for'**
  String get locationTarget;

  /// No description provided for @setTimeIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Set Time Is Empty'**
  String get setTimeIsEmpty;

  /// No description provided for @unableToAddTheDateWithoutTime.
  ///
  /// In en, this message translates to:
  /// **'Unable To Add The Date Without Time'**
  String get unableToAddTheDateWithoutTime;

  /// No description provided for @assignedThisTaskToAnotherUserOrGroup.
  ///
  /// In en, this message translates to:
  /// **'Assigned This Task To Another User Or Group'**
  String get assignedThisTaskToAnotherUserOrGroup;

  /// No description provided for @byAssignThisTaskToUserOrGroupThatBeingChoosenThisTaskAutomaticallyWillAppearOnTheirDashboard.
  ///
  /// In en, this message translates to:
  /// **'By Assign This Task To User Or Group That Being Choosen This Task Automatically Will Appear On Their Dashboard'**
  String get byAssignThisTaskToUserOrGroupThatBeingChoosenThisTaskAutomaticallyWillAppearOnTheirDashboard;

  /// No description provided for @group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @valuableItem.
  ///
  /// In en, this message translates to:
  /// **'Valuable Item'**
  String get valuableItem;

  /// No description provided for @workPlace.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get workPlace;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @userGroup.
  ///
  /// In en, this message translates to:
  /// **'User Group'**
  String get userGroup;

  /// No description provided for @receiver.
  ///
  /// In en, this message translates to:
  /// **'Receiver'**
  String get receiver;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountType;

  /// No description provided for @allowToOpenOnWeb.
  ///
  /// In en, this message translates to:
  /// **'Allow To Open On Web'**
  String get allowToOpenOnWeb;

  /// No description provided for @allowToAccessLF.
  ///
  /// In en, this message translates to:
  /// **'Allow To Access L&F'**
  String get allowToAccessLF;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @popUpNotification.
  ///
  /// In en, this message translates to:
  /// **'Pop Up Notification'**
  String get popUpNotification;

  /// No description provided for @popUpWindowForEveryNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Pop Up Window For Every New Request'**
  String get popUpWindowForEveryNewRequest;

  /// No description provided for @onDuty.
  ///
  /// In en, this message translates to:
  /// **'On Duty'**
  String get onDuty;

  /// No description provided for @switchOffAllKindOfNotifications.
  ///
  /// In en, this message translates to:
  /// **'Switch Off All Kind Of Notifications'**
  String get switchOffAllKindOfNotifications;

  /// No description provided for @notifiedAcceptedRequest.
  ///
  /// In en, this message translates to:
  /// **'Notified Accepted Request'**
  String get notifiedAcceptedRequest;

  /// No description provided for @getNotifiedWhenYourRequestIsAccepted.
  ///
  /// In en, this message translates to:
  /// **'Get Notified When Your Request Is Accepted'**
  String get getNotifiedWhenYourRequestIsAccepted;

  /// No description provided for @notifiedCloseRequest.
  ///
  /// In en, this message translates to:
  /// **'Notified Close Request'**
  String get notifiedCloseRequest;

  /// No description provided for @getNotifiedWhenYourRequestIsClosed.
  ///
  /// In en, this message translates to:
  /// **'Get Notified When Your Request Is Closed'**
  String get getNotifiedWhenYourRequestIsClosed;

  /// No description provided for @chatNotification.
  ///
  /// In en, this message translates to:
  /// **'Chat Notification'**
  String get chatNotification;

  /// No description provided for @getNotifiedForNewComment.
  ///
  /// In en, this message translates to:
  /// **'Get Notified For New Comment'**
  String get getNotifiedForNewComment;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

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

  /// No description provided for @alwaysRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Always remember me'**
  String get alwaysRememberMe;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register your poperty by contact support@post.com'**
  String get register;

  /// No description provided for @offDuty.
  ///
  /// In en, this message translates to:
  /// **'Off Duty'**
  String get offDuty;

  /// No description provided for @myPost.
  ///
  /// In en, this message translates to:
  /// **'My Post'**
  String get myPost;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @lostAndFound.
  ///
  /// In en, this message translates to:
  /// **'Lost And Found'**
  String get lostAndFound;

  /// No description provided for @doYouWantToAcceptNotificationWhenYourRequestAreAccepted.
  ///
  /// In en, this message translates to:
  /// **'Do you want to accept notification when your request are accepted?'**
  String get doYouWantToAcceptNotificationWhenYourRequestAreAccepted;

  /// No description provided for @doYouWantToAcceptNotificationWhenYourRequestAreClose.
  ///
  /// In en, this message translates to:
  /// **'Do you want to accept notification when your request are close'**
  String get doYouWantToAcceptNotificationWhenYourRequestAreClose;

  /// No description provided for @doYouWantToSendNotificationWhenYouUpdateChat.
  ///
  /// In en, this message translates to:
  /// **'Do you want to send notification when you update a chat?'**
  String get doYouWantToSendNotificationWhenYouUpdateChat;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

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

  /// No description provided for @createRequest.
  ///
  /// In en, this message translates to:
  /// **'Create Request'**
  String get createRequest;

  /// No description provided for @lostAndFoundReport.
  ///
  /// In en, this message translates to:
  /// **'Lost And Found Report'**
  String get lostAndFoundReport;

  /// No description provided for @sendThisTo.
  ///
  /// In en, this message translates to:
  /// **'Send this to'**
  String get sendThisTo;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @typeHere.
  ///
  /// In en, this message translates to:
  /// **'Type here'**
  String get typeHere;

  /// No description provided for @setSchedule.
  ///
  /// In en, this message translates to:
  /// **'Set Schedule'**
  String get setSchedule;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'dd/mm/yyyy'**
  String get date;

  /// No description provided for @attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachment;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @newStatus.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStatus;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @reopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get reopen;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'by'**
  String get by;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @hasAcceptThisRequest.
  ///
  /// In en, this message translates to:
  /// **'has accept this request'**
  String get hasAcceptThisRequest;

  /// No description provided for @hasAssignThisRequestTo.
  ///
  /// In en, this message translates to:
  /// **'has assign this request to'**
  String get hasAssignThisRequestTo;

  /// No description provided for @hasCloseThisRequest.
  ///
  /// In en, this message translates to:
  /// **'has close this request'**
  String get hasCloseThisRequest;

  /// No description provided for @hasReopenThisRequest.
  ///
  /// In en, this message translates to:
  /// **'has reopen this request'**
  String get hasReopenThisRequest;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @escalation.
  ///
  /// In en, this message translates to:
  /// **'ESC'**
  String get escalation;

  /// No description provided for @assign.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get assign;

  /// No description provided for @editDueDate.
  ///
  /// In en, this message translates to:
  /// **'Edit due date'**
  String get editDueDate;

  /// No description provided for @deleteDueDate.
  ///
  /// In en, this message translates to:
  /// **'Delete due date'**
  String get deleteDueDate;

  /// No description provided for @addDueDate.
  ///
  /// In en, this message translates to:
  /// **'Add due date'**
  String get addDueDate;

  /// No description provided for @onHold.
  ///
  /// In en, this message translates to:
  /// **'On Hold'**
  String get onHold;

  /// No description provided for @editTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit title'**
  String get editTitle;

  /// No description provided for @editLocation.
  ///
  /// In en, this message translates to:
  /// **'edit location'**
  String get editLocation;

  /// No description provided for @emailFormatNotValid.
  ///
  /// In en, this message translates to:
  /// **'Email format not valid'**
  String get emailFormatNotValid;

  /// No description provided for @passwordMustBeFilled.
  ///
  /// In en, this message translates to:
  /// **'Password must be filled'**
  String get passwordMustBeFilled;

  /// No description provided for @youAreSignInAs.
  ///
  /// In en, this message translates to:
  /// **'You are signed in as'**
  String get youAreSignInAs;

  /// No description provided for @noUserFoundForThatEmail.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email'**
  String get noUserFoundForThatEmail;

  /// No description provided for @wrongPasswordProvidedForThatUser.
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided for this user'**
  String get wrongPasswordProvidedForThatUser;

  /// No description provided for @chooseDepartment.
  ///
  /// In en, this message translates to:
  /// **'Choose Department'**
  String get chooseDepartment;

  /// No description provided for @inputTitle.
  ///
  /// In en, this message translates to:
  /// **'Input title'**
  String get inputTitle;

  /// No description provided for @noDepartementSelected.
  ///
  /// In en, this message translates to:
  /// **'No department selected'**
  String get noDepartementSelected;

  /// No description provided for @chooseSpecificLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose spesific location'**
  String get chooseSpecificLocation;

  /// No description provided for @titleIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Title is empty'**
  String get titleIsEmpty;

  /// No description provided for @nameOfItemShouldBeFilled.
  ///
  /// In en, this message translates to:
  /// **'Name of item should be filled'**
  String get nameOfItemShouldBeFilled;

  /// No description provided for @shouldAttachAnImage.
  ///
  /// In en, this message translates to:
  /// **'Should attach an image'**
  String get shouldAttachAnImage;

  /// No description provided for @upsSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Ups! Something wrong'**
  String get upsSomethingWrong;

  /// No description provided for @areYouSureWantToCloseThisRequest.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to close this request?'**
  String get areYouSureWantToCloseThisRequest;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'camera'**
  String get camera;

  /// No description provided for @fromGalery.
  ///
  /// In en, this message translates to:
  /// **'From galery'**
  String get fromGalery;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// No description provided for @minuteAgo.
  ///
  /// In en, this message translates to:
  /// **'min ago'**
  String get minuteAgo;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'mins ago'**
  String get minutesAgo;

  /// No description provided for @oneHourAgo.
  ///
  /// In en, this message translates to:
  /// **'hour ago'**
  String get oneHourAgo;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours ago'**
  String get hours;

  /// No description provided for @oneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'day ago'**
  String get oneDayAgo;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'days ago'**
  String get daysAgo;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @nameOfItem.
  ///
  /// In en, this message translates to:
  /// **'Name Of Item'**
  String get nameOfItem;

  /// No description provided for @typeLocation.
  ///
  /// In en, this message translates to:
  /// **'Type location'**
  String get typeLocation;

  /// No description provided for @logOutDialog.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to log out'**
  String get logOutDialog;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'a week ago'**
  String get week;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'weeks ago'**
  String get weeks;

  /// No description provided for @requestStatus.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get requestStatus;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'es', 'fr', 'hi', 'id', 'it', 'ms', 'ru', 'th', 'ur', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'hi': return AppLocalizationsHi();
    case 'id': return AppLocalizationsId();
    case 'it': return AppLocalizationsIt();
    case 'ms': return AppLocalizationsMs();
    case 'ru': return AppLocalizationsRu();
    case 'th': return AppLocalizationsTh();
    case 'ur': return AppLocalizationsUr();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

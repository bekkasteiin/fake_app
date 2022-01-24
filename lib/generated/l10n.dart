// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Private office`
  String get loginTitle {
    return Intl.message(
      'Private office',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Please enter login and password`
  String get plzTypeLogPas {
    return Intl.message(
      'Please enter login and password',
      name: 'plzTypeLogPas',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the processing of my personal data`
  String get loginAgreement {
    return Intl.message(
      'I agree to the processing of my personal data',
      name: 'loginAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the field`
  String get loginValidate {
    return Intl.message(
      'Fill in the field',
      name: 'loginValidate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter PIN for quick access to app`
  String get enterPinTitle {
    return Intl.message(
      'Please enter PIN for quick access to app',
      name: 'enterPinTitle',
      desc: '',
      args: [],
    );
  }

  /// `Temporary password has been sent to you, please check email`
  String get resetEmailWasSend {
    return Intl.message(
      'Temporary password has been sent to you, please check email',
      name: 'resetEmailWasSend',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get signIn {
    return Intl.message(
      'CONTINUE',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get leaf {
    return Intl.message(
      'Notification',
      name: 'leaf',
      desc: '',
      args: [],
    );
  }

  /// `Attention! Passengers count must be less than 4 `
  String get passCountLess4 {
    return Intl.message(
      'Attention! Passengers count must be less than 4 ',
      name: 'passCountLess4',
      desc: '',
      args: [],
    );
  }

  /// `Passengers count`
  String get passCount {
    return Intl.message(
      'Passengers count',
      name: 'passCount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get submitOrder {
    return Intl.message(
      'Confirm order',
      name: 'submitOrder',
      desc: '',
      args: [],
    );
  }

  /// `Choose a location for eating`
  String get chooseAPlaceOfFood {
    return Intl.message(
      'Choose a location for eating',
      name: 'chooseAPlaceOfFood',
      desc: '',
      args: [],
    );
  }

  /// `Choose a eating time`
  String get chooseAFeedingTime {
    return Intl.message(
      'Choose a eating time',
      name: 'chooseAFeedingTime',
      desc: '',
      args: [],
    );
  }

  /// `Choose dishes`
  String get chooseADish {
    return Intl.message(
      'Choose dishes',
      name: 'chooseADish',
      desc: '',
      args: [],
    );
  }

  /// `Function`
  String get funcLeaf {
    return Intl.message(
      'Function',
      name: 'funcLeaf',
      desc: '',
      args: [],
    );
  }

  /// `Settlement sheet`
  String get paymentPaper {
    return Intl.message(
      'Settlement sheet',
      name: 'paymentPaper',
      desc: '',
      args: [],
    );
  }

  /// `SELECT`
  String get select {
    return Intl.message(
      'SELECT',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get period {
    return Intl.message(
      'Period',
      name: 'period',
      desc: '',
      args: [],
    );
  }

  /// `FULL LIST`
  String get fullList {
    return Intl.message(
      'FULL LIST',
      name: 'fullList',
      desc: '',
      args: [],
    );
  }

  /// `Enter the current password`
  String get enterTheCurrentPassword {
    return Intl.message(
      'Enter the current password',
      name: 'enterTheCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Fine will equal 2x of asset cost if it is lost. Please take care of your assets`
  String get caseLossAssets {
    return Intl.message(
      'Fine will equal 2x of asset cost if it is lost. Please take care of your assets',
      name: 'caseLossAssets',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password`
  String get enterANewPassword {
    return Intl.message(
      'Enter a new password',
      name: 'enterANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat a new password`
  String get repeatNewPassword {
    return Intl.message(
      'Repeat a new password',
      name: 'repeatNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Kazakh`
  String get kz {
    return Intl.message(
      'Kazakh',
      name: 'kz',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get ru {
    return Intl.message(
      'Russian',
      name: 'ru',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Must be the same`
  String get mustBeSame {
    return Intl.message(
      'Must be the same',
      name: 'mustBeSame',
      desc: '',
      args: [],
    );
  }

  /// `Date of creation`
  String get createTs {
    return Intl.message(
      'Date of creation',
      name: 'createTs',
      desc: '',
      args: [],
    );
  }

  /// `Take the test`
  String get takeTheTest {
    return Intl.message(
      'Take the test',
      name: 'takeTheTest',
      desc: '',
      args: [],
    );
  }

  /// `Analyzes and reporting`
  String get analyzesAndReporting {
    return Intl.message(
      'Analyzes and reporting',
      name: 'analyzesAndReporting',
      desc: '',
      args: [],
    );
  }

  /// `Book Vehicle`
  String get carOrder {
    return Intl.message(
      'Book Vehicle',
      name: 'carOrder',
      desc: '',
      args: [],
    );
  }

  /// `Work Orders`
  String get tasks {
    return Intl.message(
      'Work Orders',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Choose a route`
  String get selectRoad {
    return Intl.message(
      'Choose a route',
      name: 'selectRoad',
      desc: '',
      args: [],
    );
  }

  /// `Daily Testing`
  String get testing {
    return Intl.message(
      'Daily Testing',
      name: 'testing',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `You must select an answer to continue.`
  String get mustSelectAnswer {
    return Intl.message(
      'You must select an answer to continue.',
      name: 'mustSelectAnswer',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message(
      'No data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Disclose`
  String get openUp {
    return Intl.message(
      'Disclose',
      name: 'openUp',
      desc: '',
      args: [],
    );
  }

  /// `Optional testing`
  String get test {
    return Intl.message(
      'Optional testing',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get Offrom {
    return Intl.message(
      'of',
      name: 'Offrom',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message(
      'Attention',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit the test? All your progress will be lost`
  String get testWillPop {
    return Intl.message(
      'Are you sure you want to exit the test? All your progress will be lost',
      name: 'testWillPop',
      desc: '',
      args: [],
    );
  }

  /// `Personal Area`
  String get personalCabinet {
    return Intl.message(
      'Personal Area',
      name: 'personalCabinet',
      desc: '',
      args: [],
    );
  }

  /// `We expect the best result from you.`
  String get badTestResult {
    return Intl.message(
      'We expect the best result from you.',
      name: 'badTestResult',
      desc: '',
      args: [],
    );
  }

  /// `Economy`
  String get ECONOMY {
    return Intl.message(
      'Economy',
      name: 'ECONOMY',
      desc: '',
      args: [],
    );
  }

  /// `Comfort`
  String get COMFORT {
    return Intl.message(
      'Comfort',
      name: 'COMFORT',
      desc: '',
      args: [],
    );
  }

  /// `Freight`
  String get FREIGHT {
    return Intl.message(
      'Freight',
      name: 'FREIGHT',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Permanent`
  String get permanent {
    return Intl.message(
      'Permanent',
      name: 'permanent',
      desc: '',
      args: [],
    );
  }

  /// `Temporary`
  String get temporary {
    return Intl.message(
      'Temporary',
      name: 'temporary',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get cost {
    return Intl.message(
      'Price',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Good! But we believe that you can do better!`
  String get goodTestResult {
    return Intl.message(
      'Good! But we believe that you can do better!',
      name: 'goodTestResult',
      desc: '',
      args: [],
    );
  }

  /// `Fine! Continue in the same spirit!`
  String get excellentTestResult {
    return Intl.message(
      'Fine! Continue in the same spirit!',
      name: 'excellentTestResult',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get singInSystem {
    return Intl.message(
      'Sign in',
      name: 'singInSystem',
      desc: '',
      args: [],
    );
  }

  /// `Main page`
  String get mainInfo {
    return Intl.message(
      'Main page',
      name: 'mainInfo',
      desc: '',
      args: [],
    );
  }

  /// `Feed on`
  String get food {
    return Intl.message(
      'Feed on',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Limit`
  String get admissions {
    return Intl.message(
      'Limit',
      name: 'admissions',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to create a PIN code for quick access to the app?`
  String get wantPin {
    return Intl.message(
      'Would you like to create a PIN code for quick access to the app?',
      name: 'wantPin',
      desc: '',
      args: [],
    );
  }

  /// `PIN code creation`
  String get pinCreate {
    return Intl.message(
      'PIN code creation',
      name: 'pinCreate',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN code`
  String get enterPin {
    return Intl.message(
      'Enter PIN code',
      name: 'enterPin',
      desc: '',
      args: [],
    );
  }

  /// `Repeat PIN Code`
  String get repeatePin {
    return Intl.message(
      'Repeat PIN Code',
      name: 'repeatePin',
      desc: '',
      args: [],
    );
  }

  /// `PIN codes do not match`
  String get doesntMatchPin {
    return Intl.message(
      'PIN codes do not match',
      name: 'doesntMatchPin',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect PIN code`
  String get incorrectPin {
    return Intl.message(
      'Incorrect PIN code',
      name: 'incorrectPin',
      desc: '',
      args: [],
    );
  }

  /// `AO "Каражыра"`
  String get logoTitle {
    return Intl.message(
      'AO "Каражыра"',
      name: 'logoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter username`
  String get enterLogin {
    return Intl.message(
      'Enter username',
      name: 'enterLogin',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect login or password`
  String get incorrectSignIn {
    return Intl.message(
      'Incorrect login or password',
      name: 'incorrectSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Purchase History`
  String get orderStory {
    return Intl.message(
      'Purchase History',
      name: 'orderStory',
      desc: '',
      args: [],
    );
  }

  /// `My addresses`
  String get savedAddreses {
    return Intl.message(
      'My addresses',
      name: 'savedAddreses',
      desc: '',
      args: [],
    );
  }

  /// `From Where`
  String get fromWhere {
    return Intl.message(
      'From Where',
      name: 'fromWhere',
      desc: '',
      args: [],
    );
  }

  /// `To Where`
  String get toWhere {
    return Intl.message(
      'To Where',
      name: 'toWhere',
      desc: '',
      args: [],
    );
  }

  /// `Введите адрес назначения`
  String get toWhereAddress {
    return Intl.message(
      'Введите адрес назначения',
      name: 'toWhereAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Fact`
  String get fact {
    return Intl.message(
      'Fact',
      name: 'fact',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulations {
    return Intl.message(
      'Congratulations',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Enter departure location`
  String get fromAddress {
    return Intl.message(
      'Enter departure location',
      name: 'fromAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter destination location`
  String get toAddress {
    return Intl.message(
      'Enter destination location',
      name: 'toAddress',
      desc: '',
      args: [],
    );
  }

  /// `Locations must be different`
  String get different_addresses {
    return Intl.message(
      'Locations must be different',
      name: 'different_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Timed out, please check your internet connection.`
  String get timeOut {
    return Intl.message(
      'Timed out, please check your internet connection.',
      name: 'timeOut',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get canceling {
    return Intl.message(
      'Cancel',
      name: 'canceling',
      desc: '',
      args: [],
    );
  }

  /// `Detailed`
  String get more {
    return Intl.message(
      'Detailed',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Enter reason`
  String get order_reason {
    return Intl.message(
      'Enter reason',
      name: 'order_reason',
      desc: '',
      args: [],
    );
  }

  /// `List of applications for transport`
  String get orders_list {
    return Intl.message(
      'List of applications for transport',
      name: 'orders_list',
      desc: '',
      args: [],
    );
  }

  /// `Error. Please contact your system administrator.`
  String get errorToAdmin {
    return Intl.message(
      'Error. Please contact your system administrator.',
      name: 'errorToAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `This is a required field`
  String get required {
    return Intl.message(
      'This is a required field',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get isTrue {
    return Intl.message(
      'Right',
      name: 'isTrue',
      desc: '',
      args: [],
    );
  }

  /// `Tools`
  String get tools {
    return Intl.message(
      'Tools',
      name: 'tools',
      desc: '',
      args: [],
    );
  }

  /// `Wrong`
  String get wrong {
    return Intl.message(
      'Wrong',
      name: 'wrong',
      desc: '',
      args: [],
    );
  }

  /// `Sorry. There are no questions about your position,`
  String get noQuestions {
    return Intl.message(
      'Sorry. There are no questions about your position,',
      name: 'noQuestions',
      desc: '',
      args: [],
    );
  }

  /// `BACK`
  String get back {
    return Intl.message(
      'BACK',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Your test is being processed, the results will be later. Thanks!`
  String get testFinishAlert {
    return Intl.message(
      'Your test is being processed, the results will be later. Thanks!',
      name: 'testFinishAlert',
      desc: '',
      args: [],
    );
  }

  /// `Results for`
  String get resultsFor {
    return Intl.message(
      'Results for',
      name: 'resultsFor',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `records`
  String get records {
    return Intl.message(
      'records',
      name: 'records',
      desc: '',
      args: [],
    );
  }

  /// `Results (transport)`
  String get resultTransport {
    return Intl.message(
      'Results (transport)',
      name: 'resultTransport',
      desc: '',
      args: [],
    );
  }

  /// `Results (transport)`
  String get resultManager {
    return Intl.message(
      'Results (transport)',
      name: 'resultManager',
      desc: '',
      args: [],
    );
  }

  /// `Results (excavation)`
  String get resultShift {
    return Intl.message(
      'Results (excavation)',
      name: 'resultShift',
      desc: '',
      args: [],
    );
  }

  /// `Data saved successfully`
  String get dataSavedSuccesful {
    return Intl.message(
      'Data saved successfully',
      name: 'dataSavedSuccesful',
      desc: '',
      args: [],
    );
  }

  /// `Saved Results`
  String get savedResults {
    return Intl.message(
      'Saved Results',
      name: 'savedResults',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, it looks like you're offline. try later`
  String get offlineResults {
    return Intl.message(
      'Sorry, it looks like you\'re offline. try later',
      name: 'offlineResults',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `2 hours left before ordering, you can’t cancel the order!`
  String get cantRejectCarOrder {
    return Intl.message(
      '2 hours left before ordering, you can’t cancel the order!',
      name: 'cantRejectCarOrder',
      desc: '',
      args: [],
    );
  }

  /// `Filling Error`
  String get errorOnFilling {
    return Intl.message(
      'Filling Error',
      name: 'errorOnFilling',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `List of Accounting Events`
  String get listOfAccountingEvents {
    return Intl.message(
      'List of Accounting Events',
      name: 'listOfAccountingEvents',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get AppealRequest {
    return Intl.message(
      'Request',
      name: 'AppealRequest',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get route {
    return Intl.message(
      'Route',
      name: 'route',
      desc: '',
      args: [],
    );
  }

  /// `Requested Trip Date`
  String get requestedTripDate {
    return Intl.message(
      'Requested Trip Date',
      name: 'requestedTripDate',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Trip Date`
  String get suggestedTravelDate {
    return Intl.message(
      'Suggested Trip Date',
      name: 'suggestedTravelDate',
      desc: '',
      args: [],
    );
  }

  /// `Driver Info`
  String get driverInfo {
    return Intl.message(
      'Driver Info',
      name: 'driverInfo',
      desc: '',
      args: [],
    );
  }

  /// `Driver`
  String get driver {
    return Intl.message(
      'Driver',
      name: 'driver',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get vehicle {
    return Intl.message(
      'Vehicle',
      name: 'vehicle',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Server Error`
  String get serverError {
    return Intl.message(
      'Server Error',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Refuse Order`
  String get refuseOrder {
    return Intl.message(
      'Refuse Order',
      name: 'refuseOrder',
      desc: '',
      args: [],
    );
  }

  /// `Passengers`
  String get passengers {
    return Intl.message(
      'Passengers',
      name: 'passengers',
      desc: '',
      args: [],
    );
  }

  /// `Choose address type`
  String get chooseAddressType {
    return Intl.message(
      'Choose address type',
      name: 'chooseAddressType',
      desc: '',
      args: [],
    );
  }

  /// `Name of address`
  String get nameOfAddress {
    return Intl.message(
      'Name of address',
      name: 'nameOfAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter item`
  String get enterItem {
    return Intl.message(
      'Enter item',
      name: 'enterItem',
      desc: '',
      args: [],
    );
  }

  /// `Missing home address. Please contact HR`
  String get missingHomeAddressPleaseContactHR {
    return Intl.message(
      'Missing home address. Please contact HR',
      name: 'missingHomeAddressPleaseContactHR',
      desc: '',
      args: [],
    );
  }

  /// `Organization address missing. Please contact HR`
  String get organizationAddressMissingPleaseContactHR {
    return Intl.message(
      'Organization address missing. Please contact HR',
      name: 'organizationAddressMissingPleaseContactHR',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get simple {
    return Intl.message(
      'Default',
      name: 'simple',
      desc: '',
      args: [],
    );
  }

  /// `PMO`
  String get obligations {
    return Intl.message(
      'PMO',
      name: 'obligations',
      desc: '',
      args: [],
    );
  }

  /// `Additional addresses`
  String get additionalAddresses {
    return Intl.message(
      'Additional addresses',
      name: 'additionalAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Enter address`
  String get enterAddress {
    return Intl.message(
      'Enter address',
      name: 'enterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Application for transport`
  String get applicationForTransport {
    return Intl.message(
      'Application for transport',
      name: 'applicationForTransport',
      desc: '',
      args: [],
    );
  }

  /// `Count`
  String get count {
    return Intl.message(
      'Count',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Eating`
  String get eating {
    return Intl.message(
      'Eating',
      name: 'eating',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Calorific Val.`
  String get calorificValue {
    return Intl.message(
      'Calorific Val.',
      name: 'calorificValue',
      desc: '',
      args: [],
    );
  }

  /// `Estimate`
  String get estimate {
    return Intl.message(
      'Estimate',
      name: 'estimate',
      desc: '',
      args: [],
    );
  }

  /// `Rate the quality of service`
  String get rateTheQualityOfService {
    return Intl.message(
      'Rate the quality of service',
      name: 'rateTheQualityOfService',
      desc: '',
      args: [],
    );
  }

  /// `Assessment`
  String get assessment {
    return Intl.message(
      'Assessment',
      name: 'assessment',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Complex`
  String get complex {
    return Intl.message(
      'Complex',
      name: 'complex',
      desc: '',
      args: [],
    );
  }

  /// `Dish`
  String get dish {
    return Intl.message(
      'Dish',
      name: 'dish',
      desc: '',
      args: [],
    );
  }

  /// `Not chosen`
  String get notChosen {
    return Intl.message(
      'Not chosen',
      name: 'notChosen',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get book {
    return Intl.message(
      'Order',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get successfully {
    return Intl.message(
      'Successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Order completed successfully`
  String get orderCompletedSuccessfully {
    return Intl.message(
      'Order completed successfully',
      name: 'orderCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get position {
    return Intl.message(
      'Position',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Eating history`
  String get eatingHistory {
    return Intl.message(
      'Eating history',
      name: 'eatingHistory',
      desc: '',
      args: [],
    );
  }

  /// `Purchase history`
  String get purchaseHistory {
    return Intl.message(
      'Purchase history',
      name: 'purchaseHistory',
      desc: '',
      args: [],
    );
  }

  /// `Food catalog`
  String get foodCatalog {
    return Intl.message(
      'Food catalog',
      name: 'foodCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Menu Order`
  String get menuOrder {
    return Intl.message(
      'Menu Order',
      name: 'menuOrder',
      desc: '',
      args: [],
    );
  }

  /// `Calendar of events`
  String get calendarOfEvents {
    return Intl.message(
      'Calendar of events',
      name: 'calendarOfEvents',
      desc: '',
      args: [],
    );
  }

  /// `Personal protect`
  String get ppe {
    return Intl.message(
      'Personal protect',
      name: 'ppe',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Issue`
  String get dateOfIssue {
    return Intl.message(
      'Date Of Issue',
      name: 'dateOfIssue',
      desc: '',
      args: [],
    );
  }

  /// `Date of scheduled replacement`
  String get dateOfScheduledReplacement {
    return Intl.message(
      'Date of scheduled replacement',
      name: 'dateOfScheduledReplacement',
      desc: '',
      args: [],
    );
  }

  /// `Date of inter-shift issuance`
  String get dateOfInterShiftIssuance {
    return Intl.message(
      'Date of inter-shift issuance',
      name: 'dateOfInterShiftIssuance',
      desc: '',
      args: [],
    );
  }

  /// `Off-season Date`
  String get offSeasonDate {
    return Intl.message(
      'Off-season Date',
      name: 'offSeasonDate',
      desc: '',
      args: [],
    );
  }

  /// `Season`
  String get season {
    return Intl.message(
      'Season',
      name: 'season',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Ростовка`
  String get rostov {
    return Intl.message(
      'Ростовка',
      name: 'rostov',
      desc: '',
      args: [],
    );
  }

  /// `List SIP and Overalls`
  String get ppeList {
    return Intl.message(
      'List SIP and Overalls',
      name: 'ppeList',
      desc: '',
      args: [],
    );
  }

  /// `wear`
  String get wear {
    return Intl.message(
      'wear',
      name: 'wear',
      desc: '',
      args: [],
    );
  }

  /// `Equipment`
  String get equipment {
    return Intl.message(
      'Equipment',
      name: 'equipment',
      desc: '',
      args: [],
    );
  }

  /// `State Number`
  String get stateNumber {
    return Intl.message(
      'State Number',
      name: 'stateNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Model`
  String get vehicleModel {
    return Intl.message(
      'Vehicle Model',
      name: 'vehicleModel',
      desc: '',
      args: [],
    );
  }

  /// `Basic data`
  String get basicData {
    return Intl.message(
      'Basic data',
      name: 'basicData',
      desc: '',
      args: [],
    );
  }

  /// `Repair object`
  String get repairObject {
    return Intl.message(
      'Repair object',
      name: 'repairObject',
      desc: '',
      args: [],
    );
  }

  /// `Type of repair`
  String get typeOfRepair {
    return Intl.message(
      'Type of repair',
      name: 'typeOfRepair',
      desc: '',
      args: [],
    );
  }

  /// `Planned completion date`
  String get plannedCompletionDate {
    return Intl.message(
      'Planned completion date',
      name: 'plannedCompletionDate',
      desc: '',
      args: [],
    );
  }

  /// `Material`
  String get material {
    return Intl.message(
      'Material',
      name: 'material',
      desc: '',
      args: [],
    );
  }

  /// `Defect`
  String get defect {
    return Intl.message(
      'Defect',
      name: 'defect',
      desc: '',
      args: [],
    );
  }

  /// `Workforce`
  String get workforce {
    return Intl.message(
      'Workforce',
      name: 'workforce',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get results {
    return Intl.message(
      'Results',
      name: 'results',
      desc: '',
      args: [],
    );
  }

  /// `Completion Date (fact)`
  String get completionDateFact {
    return Intl.message(
      'Completion Date (fact)',
      name: 'completionDateFact',
      desc: '',
      args: [],
    );
  }

  /// `% of implementation`
  String get implementationPercent {
    return Intl.message(
      '% of implementation',
      name: 'implementationPercent',
      desc: '',
      args: [],
    );
  }

  /// `Enter percentage`
  String get enterPercentage {
    return Intl.message(
      'Enter percentage',
      name: 'enterPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Enter the correct percentage`
  String get enterTheCorrectPercentage {
    return Intl.message(
      'Enter the correct percentage',
      name: 'enterTheCorrectPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Error try again later`
  String get errorTryAgainLater {
    return Intl.message(
      'Error try again later',
      name: 'errorTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Date And Time`
  String get dateAndTime {
    return Intl.message(
      'Date And Time',
      name: 'dateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Percent`
  String get percent {
    return Intl.message(
      'Percent',
      name: 'percent',
      desc: '',
      args: [],
    );
  }

  /// `Transport Assignment`
  String get transportAssignment {
    return Intl.message(
      'Transport Assignment',
      name: 'transportAssignment',
      desc: '',
      args: [],
    );
  }

  /// `Repair Task`
  String get repairTask {
    return Intl.message(
      'Repair Task',
      name: 'repairTask',
      desc: '',
      args: [],
    );
  }

  /// `Change Quest`
  String get changeQuest {
    return Intl.message(
      'Change Quest',
      name: 'changeQuest',
      desc: '',
      args: [],
    );
  }

  /// `Shift`
  String get shift {
    return Intl.message(
      'Shift',
      name: 'shift',
      desc: '',
      args: [],
    );
  }

  /// `Work Information`
  String get workInformation {
    return Intl.message(
      'Work Information',
      name: 'workInformation',
      desc: '',
      args: [],
    );
  }

  /// `Type of work`
  String get typeOfWork {
    return Intl.message(
      'Type of work',
      name: 'typeOfWork',
      desc: '',
      args: [],
    );
  }

  /// `Type of operations`
  String get typeOfOperations {
    return Intl.message(
      'Type of operations',
      name: 'typeOfOperations',
      desc: '',
      args: [],
    );
  }

  /// `Place of work`
  String get placeOfWork {
    return Intl.message(
      'Place of work',
      name: 'placeOfWork',
      desc: '',
      args: [],
    );
  }

  /// `Route Information`
  String get RouteInformation {
    return Intl.message(
      'Route Information',
      name: 'RouteInformation',
      desc: '',
      args: [],
    );
  }

  /// `Number of Flights`
  String get numberOfFlights {
    return Intl.message(
      'Number of Flights',
      name: 'numberOfFlights',
      desc: '',
      args: [],
    );
  }

  /// `Cargo weight`
  String get cargoWeight {
    return Intl.message(
      'Cargo weight',
      name: 'cargoWeight',
      desc: '',
      args: [],
    );
  }

  /// `Dangerous?`
  String get dangerous {
    return Intl.message(
      'Dangerous?',
      name: 'dangerous',
      desc: '',
      args: [],
    );
  }

  /// `Cargo mileage`
  String get cargoMileage {
    return Intl.message(
      'Cargo mileage',
      name: 'cargoMileage',
      desc: '',
      args: [],
    );
  }

  /// `Enter Mileage`
  String get enterMileage {
    return Intl.message(
      'Enter Mileage',
      name: 'enterMileage',
      desc: '',
      args: [],
    );
  }

  /// `Cargo turnover`
  String get goodsTurnover {
    return Intl.message(
      'Cargo turnover',
      name: 'goodsTurnover',
      desc: '',
      args: [],
    );
  }

  /// `Mileage with load (km)`
  String get mileageWithLoadKm {
    return Intl.message(
      'Mileage with load (km)',
      name: 'mileageWithLoadKm',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get production {
    return Intl.message(
      'Products',
      name: 'production',
      desc: '',
      args: [],
    );
  }

  /// `Planned volume`
  String get plannedVolume {
    return Intl.message(
      'Planned volume',
      name: 'plannedVolume',
      desc: '',
      args: [],
    );
  }

  /// `Actual volume`
  String get actualVolume {
    return Intl.message(
      'Actual volume',
      name: 'actualVolume',
      desc: '',
      args: [],
    );
  }

  /// `Unearned resources`
  String get unearnedResources {
    return Intl.message(
      'Unearned resources',
      name: 'unearnedResources',
      desc: '',
      args: [],
    );
  }

  /// `Involved`
  String get involved {
    return Intl.message(
      'Involved',
      name: 'involved',
      desc: '',
      args: [],
    );
  }

  /// `In the process`
  String get during {
    return Intl.message(
      'In the process',
      name: 'during',
      desc: '',
      args: [],
    );
  }

  /// `Enter volume`
  String get enterVolume {
    return Intl.message(
      'Enter volume',
      name: 'enterVolume',
      desc: '',
      args: [],
    );
  }

  /// `Completion percentage`
  String get completionPercentage {
    return Intl.message(
      'Completion percentage',
      name: 'completionPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volume {
    return Intl.message(
      'Volume',
      name: 'volume',
      desc: '',
      args: [],
    );
  }

  /// `End date (plan)`
  String get completionDatePlan {
    return Intl.message(
      'End date (plan)',
      name: 'completionDatePlan',
      desc: '',
      args: [],
    );
  }

  /// `Mining equipment`
  String get miningEquipment {
    return Intl.message(
      'Mining equipment',
      name: 'miningEquipment',
      desc: '',
      args: [],
    );
  }

  /// `flights`
  String get flights {
    return Intl.message(
      'flights',
      name: 'flights',
      desc: '',
      args: [],
    );
  }

  /// `Plam`
  String get plan {
    return Intl.message(
      'Plam',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `Emplyee`
  String get Employee {
    return Intl.message(
      'Emplyee',
      name: 'Employee',
      desc: '',
      args: [],
    );
  }

  /// `Choose Employee`
  String get chooseEmployee {
    return Intl.message(
      'Choose Employee',
      name: 'chooseEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Fact End Date`
  String get actualCompletionDate {
    return Intl.message(
      'Fact End Date',
      name: 'actualCompletionDate',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Medical Examination`
  String get medicalExamination {
    return Intl.message(
      'Medical Examination',
      name: 'medicalExamination',
      desc: '',
      args: [],
    );
  }

  /// `Accident Prevention`
  String get safetyTechnique {
    return Intl.message(
      'Accident Prevention',
      name: 'safetyTechnique',
      desc: '',
      args: [],
    );
  }

  /// `Passed`
  String get passed {
    return Intl.message(
      'Passed',
      name: 'passed',
      desc: '',
      args: [],
    );
  }

  /// `Not passed`
  String get notPassed {
    return Intl.message(
      'Not passed',
      name: 'notPassed',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get totalAmount {
    return Intl.message(
      'Total amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `issued`
  String get issued {
    return Intl.message(
      'issued',
      name: 'issued',
      desc: '',
      args: [],
    );
  }

  /// `List "Outfit of tasks "`
  String get listOutfitOfTasks {
    return Intl.message(
      'List "Outfit of tasks "',
      name: 'listOutfitOfTasks',
      desc: '',
      args: [],
    );
  }

  /// `Liability`
  String get commitmentsMade {
    return Intl.message(
      'Liability',
      name: 'commitmentsMade',
      desc: '',
      args: [],
    );
  }

  /// `Medical examinations`
  String get medicalExaminations {
    return Intl.message(
      'Medical examinations',
      name: 'medicalExaminations',
      desc: '',
      args: [],
    );
  }

  /// `Salary calculator`
  String get zpCalculator {
    return Intl.message(
      'Salary calculator',
      name: 'zpCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Safety precautions`
  String get accidentPrevention {
    return Intl.message(
      'Safety precautions',
      name: 'accidentPrevention',
      desc: '',
      args: [],
    );
  }

  /// `Average performance`
  String get averagePerformance {
    return Intl.message(
      'Average performance',
      name: 'averagePerformance',
      desc: '',
      args: [],
    );
  }

  /// `Performance by Category`
  String get performanceByCategory {
    return Intl.message(
      'Performance by Category',
      name: 'performanceByCategory',
      desc: '',
      args: [],
    );
  }

  /// `Discipline`
  String get discipline {
    return Intl.message(
      'Discipline',
      name: 'discipline',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Production Values`
  String get productionValues {
    return Intl.message(
      'Production Values',
      name: 'productionValues',
      desc: '',
      args: [],
    );
  }

  /// `Performance Dynamics`
  String get performanceDynamics {
    return Intl.message(
      'Performance Dynamics',
      name: 'performanceDynamics',
      desc: '',
      args: [],
    );
  }

  /// `Analysis and Reporting`
  String get analysisAndReporting {
    return Intl.message(
      'Analysis and Reporting',
      name: 'analysisAndReporting',
      desc: '',
      args: [],
    );
  }

  /// `Pay sheet`
  String get salary {
    return Intl.message(
      'Pay sheet',
      name: 'salary',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get main {
    return Intl.message(
      'Main',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Actual news`
  String get actualNews {
    return Intl.message(
      'Actual news',
      name: 'actualNews',
      desc: '',
      args: [],
    );
  }

  /// `Archived News`
  String get archivedNews {
    return Intl.message(
      'Archived News',
      name: 'archivedNews',
      desc: '',
      args: [],
    );
  }

  /// `Affirm`
  String get affirm {
    return Intl.message(
      'Affirm',
      name: 'affirm',
      desc: '',
      args: [],
    );
  }

  /// `from`
  String get from {
    return Intl.message(
      'from',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get others {
    return Intl.message(
      'Other',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get newsTest {
    return Intl.message(
      'Test',
      name: 'newsTest',
      desc: '',
      args: [],
    );
  }

  /// `seasonIssue`
  String get seasonIssue {
    return Intl.message(
      'seasonIssue',
      name: 'seasonIssue',
      desc: '',
      args: [],
    );
  }

  /// `Rate Car Order`
  String get rateTheQualityOfTravel {
    return Intl.message(
      'Rate Car Order',
      name: 'rateTheQualityOfTravel',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Assignment`
  String get assignment {
    return Intl.message(
      'Assignment',
      name: 'assignment',
      desc: '',
      args: [],
    );
  }

  /// `Anthropometry`
  String get anthropometry {
    return Intl.message(
      'Anthropometry',
      name: 'anthropometry',
      desc: '',
      args: [],
    );
  }

  /// `Placement`
  String get placement {
    return Intl.message(
      'Placement',
      name: 'placement',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Order`
  String get emergencyOrder {
    return Intl.message(
      'Emergency Order',
      name: 'emergencyOrder',
      desc: '',
      args: [],
    );
  }

  /// `Employer`
  String get employer {
    return Intl.message(
      'Employer',
      name: 'employer',
      desc: '',
      args: [],
    );
  }

  /// `Formal document`
  String get aDocumentBase {
    return Intl.message(
      'Formal document',
      name: 'aDocumentBase',
      desc: '',
      args: [],
    );
  }

  /// `Personnel Number`
  String get personnelNumber {
    return Intl.message(
      'Personnel Number',
      name: 'personnelNumber',
      desc: '',
      args: [],
    );
  }

  /// `Job name`
  String get post {
    return Intl.message(
      'Job name',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Head size`
  String get headSize {
    return Intl.message(
      'Head size',
      name: 'headSize',
      desc: '',
      args: [],
    );
  }

  /// `Clothing size`
  String get clothingSize {
    return Intl.message(
      'Clothing size',
      name: 'clothingSize',
      desc: '',
      args: [],
    );
  }

  /// `Shoes size`
  String get shoeSize {
    return Intl.message(
      'Shoes size',
      name: 'shoeSize',
      desc: '',
      args: [],
    );
  }

  /// `Hand size`
  String get handSize {
    return Intl.message(
      'Hand size',
      name: 'handSize',
      desc: '',
      args: [],
    );
  }

  /// `Growth`
  String get growth {
    return Intl.message(
      'Growth',
      name: 'growth',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Hotel`
  String get hotel {
    return Intl.message(
      'Hotel',
      name: 'hotel',
      desc: '',
      args: [],
    );
  }

  /// `Disposition`
  String get disposition {
    return Intl.message(
      'Disposition',
      name: 'disposition',
      desc: '',
      args: [],
    );
  }

  /// `Date from`
  String get dateFrom {
    return Intl.message(
      'Date from',
      name: 'dateFrom',
      desc: '',
      args: [],
    );
  }

  /// `Date to`
  String get dateBy {
    return Intl.message(
      'Date to',
      name: 'dateBy',
      desc: '',
      args: [],
    );
  }

  /// `Watch`
  String get watch {
    return Intl.message(
      'Watch',
      name: 'watch',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Data Sync Period`
  String get dataSyncPeriod {
    return Intl.message(
      'Data Sync Period',
      name: 'dataSyncPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Data Cache Clear Date`
  String get dataCacheClearDate {
    return Intl.message(
      'Data Cache Clear Date',
      name: 'dataCacheClearDate',
      desc: '',
      args: [],
    );
  }

  /// `Enter date`
  String get enterDate {
    return Intl.message(
      'Enter date',
      name: 'enterDate',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid date`
  String get enterAValidDate {
    return Intl.message(
      'Enter a valid date',
      name: 'enterAValidDate',
      desc: '',
      args: [],
    );
  }

  /// `Main Language`
  String get mainLanguage {
    return Intl.message(
      'Main Language',
      name: 'mainLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `The user did not provide permission for the camera!`
  String get cameraPermission {
    return Intl.message(
      'The user did not provide permission for the camera!',
      name: 'cameraPermission',
      desc: '',
      args: [],
    );
  }

  /// `History of PPE`
  String get productionAssignmentList {
    return Intl.message(
      'History of PPE',
      name: 'productionAssignmentList',
      desc: '',
      args: [],
    );
  }

  /// `Issue of PPE and CO`
  String get ISP {
    return Intl.message(
      'Issue of PPE and CO',
      name: 'ISP',
      desc: '',
      args: [],
    );
  }

  /// `Moving PPE and CO`
  String get MOVINGPPE {
    return Intl.message(
      'Moving PPE and CO',
      name: 'MOVINGPPE',
      desc: '',
      args: [],
    );
  }

  /// `Transfer of PPE and CO`
  String get TRANSFER {
    return Intl.message(
      'Transfer of PPE and CO',
      name: 'TRANSFER',
      desc: '',
      args: [],
    );
  }

  /// `Appeals`
  String get appeal {
    return Intl.message(
      'Appeals',
      name: 'appeal',
      desc: '',
      args: [],
    );
  }

  /// `Choose route time`
  String get selectDate {
    return Intl.message(
      'Choose route time',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Enter other parameters`
  String get enterOtherParam {
    return Intl.message(
      'Enter other parameters',
      name: 'enterOtherParam',
      desc: '',
      args: [],
    );
  }

  /// `Confirm and order`
  String get submitAndOrder {
    return Intl.message(
      'Confirm and order',
      name: 'submitAndOrder',
      desc: '',
      args: [],
    );
  }

  /// `Connection setup`
  String get initSettings {
    return Intl.message(
      'Connection setup',
      name: 'initSettings',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get resetPassword {
    return Intl.message(
      'Change password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enterEmail {
    return Intl.message(
      'Enter Email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter the UPI`
  String get enterUPI {
    return Intl.message(
      'Enter the UPI',
      name: 'enterUPI',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Complaint`
  String get complaint {
    return Intl.message(
      'Complaint',
      name: 'complaint',
      desc: '',
      args: [],
    );
  }

  /// `Idea`
  String get idea {
    return Intl.message(
      'Idea',
      name: 'idea',
      desc: '',
      args: [],
    );
  }

  /// `The text of the appeal`
  String get appealText {
    return Intl.message(
      'The text of the appeal',
      name: 'appealText',
      desc: '',
      args: [],
    );
  }

  /// `Type of request`
  String get appealType {
    return Intl.message(
      'Type of request',
      name: 'appealType',
      desc: '',
      args: [],
    );
  }

  /// `Subject of the request`
  String get appealTopic {
    return Intl.message(
      'Subject of the request',
      name: 'appealTopic',
      desc: '',
      args: [],
    );
  }

  /// `Decision`
  String get appealFinish {
    return Intl.message(
      'Decision',
      name: 'appealFinish',
      desc: '',
      args: [],
    );
  }

  /// `Issue`
  String get appealJornal {
    return Intl.message(
      'Issue',
      name: 'appealJornal',
      desc: '',
      args: [],
    );
  }

  /// `Order transport`
  String get CAR_ORDER {
    return Intl.message(
      'Order transport',
      name: 'CAR_ORDER',
      desc: '',
      args: [],
    );
  }

  /// `Allowance`
  String get ALLOWANCE {
    return Intl.message(
      'Allowance',
      name: 'ALLOWANCE',
      desc: '',
      args: [],
    );
  }

  /// `Work Orders`
  String get WORK_ORDER {
    return Intl.message(
      'Work Orders',
      name: 'WORK_ORDER',
      desc: '',
      args: [],
    );
  }

  /// `Testing`
  String get TESTING {
    return Intl.message(
      'Testing',
      name: 'TESTING',
      desc: '',
      args: [],
    );
  }

  /// `Eating`
  String get EATING {
    return Intl.message(
      'Eating',
      name: 'EATING',
      desc: '',
      args: [],
    );
  }

  /// `PPE`
  String get PPE {
    return Intl.message(
      'PPE',
      name: 'PPE',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get IS_NEW {
    return Intl.message(
      'New',
      name: 'IS_NEW',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get DRAFT {
    return Intl.message(
      'New',
      name: 'DRAFT',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get APPROVED {
    return Intl.message(
      'Approved',
      name: 'APPROVED',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get CLOSED {
    return Intl.message(
      'Closed',
      name: 'CLOSED',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get IN_PROGRESS {
    return Intl.message(
      'In progress',
      name: 'IN_PROGRESS',
      desc: '',
      args: [],
    );
  }

  /// `On Approval`
  String get ON_APPROVAL {
    return Intl.message(
      'On Approval',
      name: 'ON_APPROVAL',
      desc: '',
      args: [],
    );
  }

  /// `Un approved`
  String get UNAPPROVED {
    return Intl.message(
      'Un approved',
      name: 'UNAPPROVED',
      desc: '',
      args: [],
    );
  }

  /// `On distribution`
  String get ON_DISTRIBUTION {
    return Intl.message(
      'On distribution',
      name: 'ON_DISTRIBUTION',
      desc: '',
      args: [],
    );
  }

  /// `Expectation`
  String get EXPECTATION {
    return Intl.message(
      'Expectation',
      name: 'EXPECTATION',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get COMPLETED {
    return Intl.message(
      'Completed',
      name: 'COMPLETED',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get CANCELED {
    return Intl.message(
      'Canceled',
      name: 'CANCELED',
      desc: '',
      args: [],
    );
  }

  /// `On approve`
  String get ONAPPROVE {
    return Intl.message(
      'On approve',
      name: 'ONAPPROVE',
      desc: '',
      args: [],
    );
  }

  /// `Planned repair`
  String get PLAN {
    return Intl.message(
      'Planned repair',
      name: 'PLAN',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get EXIT {
    return Intl.message(
      'Exit',
      name: 'EXIT',
      desc: '',
      args: [],
    );
  }

  /// `Entrance`
  String get ENTRANCE {
    return Intl.message(
      'Entrance',
      name: 'ENTRANCE',
      desc: '',
      args: [],
    );
  }

  /// `Unplanned repair`
  String get UNPLAN {
    return Intl.message(
      'Unplanned repair',
      name: 'UNPLAN',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get UPGRADE {
    return Intl.message(
      'Upgrade',
      name: 'UPGRADE',
      desc: '',
      args: [],
    );
  }

  /// `Planned maintenance`
  String get SERVICE_PLAN {
    return Intl.message(
      'Planned maintenance',
      name: 'SERVICE_PLAN',
      desc: '',
      args: [],
    );
  }

  /// `Unplanned maintenance`
  String get SERVICE_UNPLAN {
    return Intl.message(
      'Unplanned maintenance',
      name: 'SERVICE_UNPLAN',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get REJECTED {
    return Intl.message(
      'Rejected',
      name: 'REJECTED',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get JANUARY {
    return Intl.message(
      'January',
      name: 'JANUARY',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get FEBRUARY {
    return Intl.message(
      'February',
      name: 'FEBRUARY',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get MARCH {
    return Intl.message(
      'March',
      name: 'MARCH',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get APRIL {
    return Intl.message(
      'April',
      name: 'APRIL',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get MAY {
    return Intl.message(
      'May',
      name: 'MAY',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get JUNE {
    return Intl.message(
      'June',
      name: 'JUNE',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get JULY {
    return Intl.message(
      'July',
      name: 'JULY',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get AUGUST {
    return Intl.message(
      'August',
      name: 'AUGUST',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get SEPTEMBER {
    return Intl.message(
      'September',
      name: 'SEPTEMBER',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get OCTOBER {
    return Intl.message(
      'October',
      name: 'OCTOBER',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get NOVEMBER {
    return Intl.message(
      'November',
      name: 'NOVEMBER',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get DECEMBER {
    return Intl.message(
      'December',
      name: 'DECEMBER',
      desc: '',
      args: [],
    );
  }

  /// `Choose a meal time`
  String get selectMealtime {
    return Intl.message(
      'Choose a meal time',
      name: 'selectMealtime',
      desc: '',
      args: [],
    );
  }

  /// `The ordered menu should not be empty`
  String get menuIsEmpty {
    return Intl.message(
      'The ordered menu should not be empty',
      name: 'menuIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Choose location`
  String get selectPlace {
    return Intl.message(
      'Choose location',
      name: 'selectPlace',
      desc: '',
      args: [],
    );
  }

  /// `Порция`
  String get portion {
    return Intl.message(
      'Порция',
      name: 'portion',
      desc: '',
      args: [],
    );
  }

  /// `Log off`
  String get logoff {
    return Intl.message(
      'Log off',
      name: 'logoff',
      desc: '',
      args: [],
    );
  }

  /// `Daily testing:`
  String get dailyTesting {
    return Intl.message(
      'Daily testing:',
      name: 'dailyTesting',
      desc: '',
      args: [],
    );
  }

  /// `Damage to the employer:`
  String get damageToEmployer {
    return Intl.message(
      'Damage to the employer:',
      name: 'damageToEmployer',
      desc: '',
      args: [],
    );
  }

  /// `Productivity:`
  String get productivityRating {
    return Intl.message(
      'Productivity:',
      name: 'productivityRating',
      desc: '',
      args: [],
    );
  }

  /// `Discipline of labor:`
  String get disciplineOfLabor {
    return Intl.message(
      'Discipline of labor:',
      name: 'disciplineOfLabor',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Rate Lunch`
  String get rateLunch {
    return Intl.message(
      'Rate Lunch',
      name: 'rateLunch',
      desc: '',
      args: [],
    );
  }

  /// `Total limit for 16 days`
  String get monthLimit {
    return Intl.message(
      'Total limit for 16 days',
      name: 'monthLimit',
      desc: '',
      args: [],
    );
  }

  /// `Spent`
  String get spent {
    return Intl.message(
      'Spent',
      name: 'spent',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get left {
    return Intl.message(
      'Balance',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `Daily limit`
  String get dailyLimit {
    return Intl.message(
      'Daily limit',
      name: 'dailyLimit',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get InTotal {
    return Intl.message(
      'Total',
      name: 'InTotal',
      desc: '',
      args: [],
    );
  }

  /// `Place and time of meals`
  String get placeAndTimeEating {
    return Intl.message(
      'Place and time of meals',
      name: 'placeAndTimeEating',
      desc: '',
      args: [],
    );
  }

  /// `My addresses`
  String get MyAddresses {
    return Intl.message(
      'My addresses',
      name: 'MyAddresses',
      desc: '',
      args: [],
    );
  }

  /// `No description provided`
  String get noDescriptionProvided {
    return Intl.message(
      'No description provided',
      name: 'noDescriptionProvided',
      desc: '',
      args: [],
    );
  }

  /// `You can do better!`
  String get youCanDoBetter {
    return Intl.message(
      'You can do better!',
      name: 'youCanDoBetter',
      desc: '',
      args: [],
    );
  }

  /// `Ok, but you can do better!`
  String get okButYouCanDoBetter {
    return Intl.message(
      'Ok, but you can do better!',
      name: 'okButYouCanDoBetter',
      desc: '',
      args: [],
    );
  }

  /// `Great, keep it up!`
  String get greatKeepItUp {
    return Intl.message(
      'Great, keep it up!',
      name: 'greatKeepItUp',
      desc: '',
      args: [],
    );
  }

  /// `Your rank`
  String get yourRank {
    return Intl.message(
      'Your rank',
      name: 'yourRank',
      desc: '',
      args: [],
    );
  }

  /// `Your rating`
  String get yourRating {
    return Intl.message(
      'Your rating',
      name: 'yourRating',
      desc: '',
      args: [],
    );
  }

  /// `Please wait...`
  String get inProgress {
    return Intl.message(
      'Please wait...',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Rating details`
  String get ratingDetailsCaption {
    return Intl.message(
      'Rating details',
      name: 'ratingDetailsCaption',
      desc: '',
      args: [],
    );
  }

  /// `LOCATION`
  String get foodLocation {
    return Intl.message(
      'LOCATION',
      name: 'foodLocation',
      desc: '',
      args: [],
    );
  }

  /// `DELIVERY`
  String get foodDelivery {
    return Intl.message(
      'DELIVERY',
      name: 'foodDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Please choice eating data`
  String get foodDataInfo {
    return Intl.message(
      'Please choice eating data',
      name: 'foodDataInfo',
      desc: '',
      args: [],
    );
  }

  /// `Please choice eating time`
  String get foodTimeInfo {
    return Intl.message(
      'Please choice eating time',
      name: 'foodTimeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Resulution`
  String get resolution {
    return Intl.message(
      'Resulution',
      name: 'resolution',
      desc: '',
      args: [],
    );
  }

  /// `Mobile app`
  String get MOBILE {
    return Intl.message(
      'Mobile app',
      name: 'MOBILE',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get clear {
    return Intl.message(
      'OK',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Result will be reade after processing`
  String get testResult {
    return Intl.message(
      'Result will be reade after processing',
      name: 'testResult',
      desc: '',
      args: [],
    );
  }

  /// `Your test has passed`
  String get testRegistered {
    return Intl.message(
      'Your test has passed',
      name: 'testRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get resultsLower {
    return Intl.message(
      'Results',
      name: 'resultsLower',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get productionValuesDetails {
    return Intl.message(
      'Details',
      name: 'productionValuesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please fill appropriated fields`
  String get fillInTheRequiredFields {
    return Intl.message(
      'Please fill appropriated fields',
      name: 'fillInTheRequiredFields',
      desc: '',
      args: [],
    );
  }

  /// `Password change`
  String get resetPasswordTitle {
    return Intl.message(
      'Password change',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Please choose another place and time`
  String get anotherPlaceDate {
    return Intl.message(
      'Please choose another place and time',
      name: 'anotherPlaceDate',
      desc: '',
      args: [],
    );
  }

  /// `APPROVE`
  String get approved {
    return Intl.message(
      'APPROVE',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `REJECT`
  String get reject {
    return Intl.message(
      'REJECT',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `The request has registered`
  String get AppealConfirm {
    return Intl.message(
      'The request has registered',
      name: 'AppealConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Please check the request status`
  String get AppealStatusInfo {
    return Intl.message(
      'Please check the request status',
      name: 'AppealStatusInfo',
      desc: '',
      args: [],
    );
  }

  /// `Driver phone`
  String get driverContact {
    return Intl.message(
      'Driver phone',
      name: 'driverContact',
      desc: '',
      args: [],
    );
  }

  /// `Доступно обновление`
  String get updateIsAvailable {
    return Intl.message(
      'Доступно обновление',
      name: 'updateIsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Требуется обновление`
  String get updateRequired {
    return Intl.message(
      'Требуется обновление',
      name: 'updateRequired',
      desc: '',
      args: [],
    );
  }

  /// `Необходимо обновление приложения Личный кабинет.`
  String get updateNeededToContinue {
    return Intl.message(
      'Необходимо обновление приложения Личный кабинет.',
      name: 'updateNeededToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Registration required`
  String get registrationRequired {
    return Intl.message(
      'Registration required',
      name: 'registrationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `You need to allow reading SIM on your device`
  String get readPhoneNumbers {
    return Intl.message(
      'You need to allow reading SIM on your device',
      name: 'readPhoneNumbers',
      desc: '',
      args: [],
    );
  }

  /// `No SIM found on your device`
  String get notSimCards {
    return Intl.message(
      'No SIM found on your device',
      name: 'notSimCards',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `BSA`
  String get bsa {
    return Intl.message(
      'BSA',
      name: 'bsa',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get sync {
    return Intl.message(
      'Sync',
      name: 'sync',
      desc: '',
      args: [],
    );
  }

  /// `List BSA`
  String get listBsa {
    return Intl.message(
      'List BSA',
      name: 'listBsa',
      desc: '',
      args: [],
    );
  }

  /// `BSA register`
  String get registerBsa {
    return Intl.message(
      'BSA register',
      name: 'registerBsa',
      desc: '',
      args: [],
    );
  }

  /// `Planned BSA`
  String get plannedBsa {
    return Intl.message(
      'Planned BSA',
      name: 'plannedBsa',
      desc: '',
      args: [],
    );
  }

  /// `Change BSA`
  String get changeBsa {
    return Intl.message(
      'Change BSA',
      name: 'changeBsa',
      desc: '',
      args: [],
    );
  }

  /// `New BSA`
  String get newBsa {
    return Intl.message(
      'New BSA',
      name: 'newBsa',
      desc: '',
      args: [],
    );
  }

  /// `planned`
  String get planned {
    return Intl.message(
      'planned',
      name: 'planned',
      desc: '',
      args: [],
    );
  }

  /// `Are you really want to delete the BSA?`
  String get deleteBsa {
    return Intl.message(
      'Are you really want to delete the BSA?',
      name: 'deleteBsa',
      desc: '',
      args: [],
    );
  }

  /// `After deletion, you cannot restore since the BSA is saved locally`
  String get confirmDeleteBsa {
    return Intl.message(
      'After deletion, you cannot restore since the BSA is saved locally',
      name: 'confirmDeleteBsa',
      desc: '',
      args: [],
    );
  }

  /// `Bsa registered`
  String get registeredBsa {
    return Intl.message(
      'Bsa registered',
      name: 'registeredBsa',
      desc: '',
      args: [],
    );
  }

  /// `BSA unregistered`
  String get unregisteredBsa {
    return Intl.message(
      'BSA unregistered',
      name: 'unregisteredBsa',
      desc: '',
      args: [],
    );
  }

  /// `Follow the status of the BSA`
  String get followBsaStatus {
    return Intl.message(
      'Follow the status of the BSA',
      name: 'followBsaStatus',
      desc: '',
      args: [],
    );
  }

  /// `BSA saved locally.\n When the Internet appears, you need to synchronize`
  String get savedLocallyBsa {
    return Intl.message(
      'BSA saved locally.\n When the Internet appears, you need to synchronize',
      name: 'savedLocallyBsa',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get generalInformation {
    return Intl.message(
      'General information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `LE`
  String get legalEntity {
    return Intl.message(
      'LE',
      name: 'legalEntity',
      desc: '',
      args: [],
    );
  }

  /// `Workplace\Object`
  String get workplace {
    return Intl.message(
      'Workplace\Object',
      name: 'workplace',
      desc: '',
      args: [],
    );
  }

  /// `Auditors`
  String get auditors {
    return Intl.message(
      'Auditors',
      name: 'auditors',
      desc: '',
      args: [],
    );
  }

  /// `Observation description`
  String get observationDescription {
    return Intl.message(
      'Observation description',
      name: 'observationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Observation category assessment`
  String get observationCategory {
    return Intl.message(
      'Observation category assessment',
      name: 'observationCategory',
      desc: '',
      args: [],
    );
  }

  /// `Situation type`
  String get situationType {
    return Intl.message(
      'Situation type',
      name: 'situationType',
      desc: '',
      args: [],
    );
  }

  /// `Severity of consequences`
  String get severityConsequences {
    return Intl.message(
      'Severity of consequences',
      name: 'severityConsequences',
      desc: '',
      args: [],
    );
  }

  /// `Danger type`
  String get dangerType {
    return Intl.message(
      'Danger type',
      name: 'dangerType',
      desc: '',
      args: [],
    );
  }

  /// `Work type`
  String get workType {
    return Intl.message(
      'Work type',
      name: 'workType',
      desc: '',
      args: [],
    );
  }

  /// `Audit duration,(min)`
  String get auditDuration {
    return Intl.message(
      'Audit duration,(min)',
      name: 'auditDuration',
      desc: '',
      args: [],
    );
  }

  /// `Observed,(people)`
  String get observed {
    return Intl.message(
      'Observed,(people)',
      name: 'observed',
      desc: '',
      args: [],
    );
  }

  /// `Corrective action`
  String get correctiveAction {
    return Intl.message(
      'Corrective action',
      name: 'correctiveAction',
      desc: '',
      args: [],
    );
  }

  /// `Employee proposal`
  String get employeesOffer {
    return Intl.message(
      'Employee proposal',
      name: 'employeesOffer',
      desc: '',
      args: [],
    );
  }

  /// `Photo fixation`
  String get photoFixation {
    return Intl.message(
      'Photo fixation',
      name: 'photoFixation',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Choose department`
  String get chooseDepartment {
    return Intl.message(
      'Choose department',
      name: 'chooseDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Choose auditors`
  String get chooseAuditors {
    return Intl.message(
      'Choose auditors',
      name: 'chooseAuditors',
      desc: '',
      args: [],
    );
  }

  /// `Choose situation`
  String get chooseSituation {
    return Intl.message(
      'Choose situation',
      name: 'chooseSituation',
      desc: '',
      args: [],
    );
  }

  /// `Available from`
  String get availableFrom {
    return Intl.message(
      'Available from',
      name: 'availableFrom',
      desc: '',
      args: [],
    );
  }

  /// `No saved`
  String get noSaved {
    return Intl.message(
      'No saved',
      name: 'noSaved',
      desc: '',
      args: [],
    );
  }

  /// `Not Registered`
  String get notRegistered {
    return Intl.message(
      'Not Registered',
      name: 'notRegistered',
      desc: '',
      args: [],
    );
  }

  /// `IIN`
  String get IIN {
    return Intl.message(
      'IIN',
      name: 'IIN',
      desc: '',
      args: [],
    );
  }

  /// `Registry`
  String get registry {
    return Intl.message(
      'Registry',
      name: 'registry',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `List of assessment`
  String get listAssessment {
    return Intl.message(
      'List of assessment',
      name: 'listAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Change assessment`
  String get changeAssessment {
    return Intl.message(
      'Change assessment',
      name: 'changeAssessment',
      desc: '',
      args: [],
    );
  }

  /// `New assessment`
  String get newAssessment {
    return Intl.message(
      'New assessment',
      name: 'newAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Are you really want to delete assessment?`
  String get deleteAssessment {
    return Intl.message(
      'Are you really want to delete assessment?',
      name: 'deleteAssessment',
      desc: '',
      args: [],
    );
  }

  /// `After deletion, you can not restore because the assessment is saved locally`
  String get confirmDeleteAssessment {
    return Intl.message(
      'After deletion, you can not restore because the assessment is saved locally',
      name: 'confirmDeleteAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Operation type`
  String get operationType {
    return Intl.message(
      'Operation type',
      name: 'operationType',
      desc: '',
      args: [],
    );
  }

  /// `Danger source category`
  String get dangerSourceCategory {
    return Intl.message(
      'Danger source category',
      name: 'dangerSourceCategory',
      desc: '',
      args: [],
    );
  }

  /// `Danger source`
  String get dangerSource {
    return Intl.message(
      'Danger source',
      name: 'dangerSource',
      desc: '',
      args: [],
    );
  }

  /// `Consequence of risk`
  String get consequenceRisk {
    return Intl.message(
      'Consequence of risk',
      name: 'consequenceRisk',
      desc: '',
      args: [],
    );
  }

  /// `Probability assessment`
  String get probabilityAssessment {
    return Intl.message(
      'Probability assessment',
      name: 'probabilityAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Risk management`
  String get riskManagement {
    return Intl.message(
      'Risk management',
      name: 'riskManagement',
      desc: '',
      args: [],
    );
  }

  /// `Choose Danger source`
  String get chooseDangerSource {
    return Intl.message(
      'Choose Danger source',
      name: 'chooseDangerSource',
      desc: '',
      args: [],
    );
  }

  /// `Choose Danger source category`
  String get chooseDangerSourceCategory {
    return Intl.message(
      'Choose Danger source category',
      name: 'chooseDangerSourceCategory',
      desc: '',
      args: [],
    );
  }

  /// `Choose consequence of risk`
  String get chooseConsequence {
    return Intl.message(
      'Choose consequence of risk',
      name: 'chooseConsequence',
      desc: '',
      args: [],
    );
  }

  /// `Choose operation type`
  String get chooseOperationType {
    return Intl.message(
      'Choose operation type',
      name: 'chooseOperationType',
      desc: '',
      args: [],
    );
  }

  /// `Assessment registration`
  String get assessmentRegistration {
    return Intl.message(
      'Assessment registration',
      name: 'assessmentRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Assessment registered`
  String get assessmentRegistered {
    return Intl.message(
      'Assessment registered',
      name: 'assessmentRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Assessment unregistered`
  String get assessmentUnregistered {
    return Intl.message(
      'Assessment unregistered',
      name: 'assessmentUnregistered',
      desc: '',
      args: [],
    );
  }

  /// `Keep track Assessment status`
  String get followAssessmentStatus {
    return Intl.message(
      'Keep track Assessment status',
      name: 'followAssessmentStatus',
      desc: '',
      args: [],
    );
  }

  /// `The assessment is stored locally.\n When the Internet appears, you need to synchronize`
  String get assessmentLocallySaved {
    return Intl.message(
      'The assessment is stored locally.\n When the Internet appears, you need to synchronize',
      name: 'assessmentLocallySaved',
      desc: '',
      args: [],
    );
  }

  /// `Risk register`
  String get riskRegister {
    return Intl.message(
      'Risk register',
      name: 'riskRegister',
      desc: '',
      args: [],
    );
  }

  /// `List of messages`
  String get listMessages {
    return Intl.message(
      'List of messages',
      name: 'listMessages',
      desc: '',
      args: [],
    );
  }

  /// `Message register`
  String get messageRegister {
    return Intl.message(
      'Message register',
      name: 'messageRegister',
      desc: '',
      args: [],
    );
  }

  /// `Change messages`
  String get changeMessages {
    return Intl.message(
      'Change messages',
      name: 'changeMessages',
      desc: '',
      args: [],
    );
  }

  /// `New message`
  String get newMessage {
    return Intl.message(
      'New message',
      name: 'newMessage',
      desc: '',
      args: [],
    );
  }

  /// `Message registration`
  String get messageRegistration {
    return Intl.message(
      'Message registration',
      name: 'messageRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Message registered`
  String get messageRegistered {
    return Intl.message(
      'Message registered',
      name: 'messageRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Message unregistered`
  String get messageUnregistered {
    return Intl.message(
      'Message unregistered',
      name: 'messageUnregistered',
      desc: '',
      args: [],
    );
  }

  /// `Keep track Message status`
  String get followMessageStatus {
    return Intl.message(
      'Keep track Message status',
      name: 'followMessageStatus',
      desc: '',
      args: [],
    );
  }

  /// `The assessment is stored locally. \nWhen the Internet appears, you need to synchronize`
  String get messageLocallySaved {
    return Intl.message(
      'The assessment is stored locally. \nWhen the Internet appears, you need to synchronize',
      name: 'messageLocallySaved',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the Message?`
  String get deleteMessage {
    return Intl.message(
      'Are you sure you want to delete the Message?',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `After deletion, you cannot restore it since the message is saved locally`
  String get confirmDeleteMessage {
    return Intl.message(
      'After deletion, you cannot restore it since the message is saved locally',
      name: 'confirmDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Dangerous condition`
  String get dangerousCondition {
    return Intl.message(
      'Dangerous condition',
      name: 'dangerousCondition',
      desc: '',
      args: [],
    );
  }

  /// `Full name of the offender(s)`
  String get offenders {
    return Intl.message(
      'Full name of the offender(s)',
      name: 'offenders',
      desc: '',
      args: [],
    );
  }

  /// `Dangerous action`
  String get dangerousAction {
    return Intl.message(
      'Dangerous action',
      name: 'dangerousAction',
      desc: '',
      args: [],
    );
  }

  /// `Violation type`
  String get violationType {
    return Intl.message(
      'Violation type',
      name: 'violationType',
      desc: '',
      args: [],
    );
  }

  /// `Revealed description`
  String get revealedDescription {
    return Intl.message(
      'Revealed description',
      name: 'revealedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Comment (required)`
  String get commentRequired {
    return Intl.message(
      'Comment (required)',
      name: 'commentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Anonymously`
  String get anonymously {
    return Intl.message(
      'Anonymously',
      name: 'anonymously',
      desc: '',
      args: [],
    );
  }

  /// `Intended actions`
  String get intendedActions {
    return Intl.message(
      'Intended actions',
      name: 'intendedActions',
      desc: '',
      args: [],
    );
  }

  /// `Additional information`
  String get additionalInfo {
    return Intl.message(
      'Additional information',
      name: 'additionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message(
      'Optional',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `My Events`
  String get myEvents {
    return Intl.message(
      'My Events',
      name: 'myEvents',
      desc: '',
      args: [],
    );
  }

  /// `List of events`
  String get listEvents {
    return Intl.message(
      'List of events',
      name: 'listEvents',
      desc: '',
      args: [],
    );
  }

  /// `Change events`
  String get changeEvents {
    return Intl.message(
      'Change events',
      name: 'changeEvents',
      desc: '',
      args: [],
    );
  }

  /// `New events`
  String get newEvents {
    return Intl.message(
      'New events',
      name: 'newEvents',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the Event?`
  String get deleteEvents {
    return Intl.message(
      'Are you sure you want to delete the Event?',
      name: 'deleteEvents',
      desc: '',
      args: [],
    );
  }

  /// `After deletion, you cannot restore since the event is saved locally`
  String get confirmDeleteEvents {
    return Intl.message(
      'After deletion, you cannot restore since the event is saved locally',
      name: 'confirmDeleteEvents',
      desc: '',
      args: [],
    );
  }

  /// `Changes to the event are saved`
  String get changesEventSaved {
    return Intl.message(
      'Changes to the event are saved',
      name: 'changesEventSaved',
      desc: '',
      args: [],
    );
  }

  /// `Event changes not registered`
  String get changesEventNotSaved {
    return Intl.message(
      'Event changes not registered',
      name: 'changesEventNotSaved',
      desc: '',
      args: [],
    );
  }

  /// `Follow the status of the Event`
  String get followEventStatus {
    return Intl.message(
      'Follow the status of the Event',
      name: 'followEventStatus',
      desc: '',
      args: [],
    );
  }

  /// `Events are saved locally.\n When the Internet appears, you need to synchronize`
  String get eventsSavedLocally {
    return Intl.message(
      'Events are saved locally.\n When the Internet appears, you need to synchronize',
      name: 'eventsSavedLocally',
      desc: '',
      args: [],
    );
  }

  /// `A document base`
  String get basisDoc {
    return Intl.message(
      'A document base',
      name: 'basisDoc',
      desc: '',
      args: [],
    );
  }

  /// `Planning period`
  String get planningPeriod {
    return Intl.message(
      'Planning period',
      name: 'planningPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Actual period`
  String get actualPeriod {
    return Intl.message(
      'Actual period',
      name: 'actualPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Controlling`
  String get controlling {
    return Intl.message(
      'Controlling',
      name: 'controlling',
      desc: '',
      args: [],
    );
  }

  /// `Observer`
  String get observer {
    return Intl.message(
      'Observer',
      name: 'observer',
      desc: '',
      args: [],
    );
  }

  /// `Event description`
  String get eventDescription {
    return Intl.message(
      'Event description',
      name: 'eventDescription',
      desc: '',
      args: [],
    );
  }

  /// `Arbitrary comment`
  String get arbitraryComment {
    return Intl.message(
      'Arbitrary comment',
      name: 'arbitraryComment',
      desc: '',
      args: [],
    );
  }

  /// `Completion percentage`
  String get completionPercent {
    return Intl.message(
      'Completion percentage',
      name: 'completionPercent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
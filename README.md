# Getting Started with Magento 2 Mobile App Builder

## Basic Information
**Magento 2 Mobile App Builder** can transform your Magento 2 website to a fully funtional Android app. It will provide the customers with lots of features, to relish their shopping experience in a more easy and mobile way in order to provide Ubiquity (Easier information access in real-time), Convenience (Devices that store data are always at hand), Accessibility (Choice to limit the accessibility to particular persons who can be contacted anywhere anytime), Personalization (Creating services that customize the end-user experience), and Localization (Matching services to the location of the customers), which is just some taps and swipes away. The working demo of the app can be found on [Play Store](https://play.google.com/store/apps/details?id=com.webkul.magento2.mobikul).


## Supported Version

## For android
:star:	`Target Sdk Version: 32`
:star:	`Minimum Sdk Version: 23`

## For iOS
Minimum Version 11.0


## Instructions To Configure The Application
1. First, Install the Mobikul API Module (If not installed yet) on your server.

2. After setting the Username and Password, You need to update that in app code also. Mobikul source code contains a file called ApplicationConstants which contains all the neccessary information to run the app. There you will find three variable which are used to connect the app with the server.

3. Now you need to set some constants in the app code.
    - Open the `app_constants.dart` class in your Android Studio.
    - **Path** - /lib/mobikul/constants/app_constants.dart
    - There you will find three contants that needs to changed.
        - **BASE_URL** - It is the Domain name or the IP of your server
           ```
           String BASE_URL = "https://example.com"
           ```
        - **API_USER_NAME** - Username created in admin panel.
           ```
           String API_USER_NAME = "your_username"
           ```
        - **API_PASSWORD** - Password created in admin panel.
           ```
           String API_PASSWORD = "your_password"
           ```

4. Now, You will be able to connect to the server with your app.

## Instructions To Configure The Application Images
#### 1. Splash screen-
- **Path** - /assets/images/splash_screen.png
- **Name** - splash_screen.png
- **Add the image Path Name to `app_constants.dart`**
- **Path** -  /lib/mobikul/constants/app_constants.dart

#### 2. Placeholder-
- **Path** - /assets/images/placeholder.png
- **Name** - placeholder.png
- **Add the image Path Name to `app_constants.dart`**
- **Path** -  /lib/mobikul/constants/app_constants.dart


#### 3. Launcher icon-

## For Android
- **Path** - /android/app/src/main/res/mipmap-mdpi/ic_launcher.png
- **Name** - ic_launcher
- **Add the image Path Name to `app_constants.dart`**
- **Path** -  /lib/mobikul/constants/app_constants.dart

## For iOS
Go to Assets.xcassets folder and change this.

#### 4. Status bar icon

## For Android
- **Path** - /mobikul/src/main/res/drawable
- **Name** - ic_app.xml
- **Add the image Path Name to `app_constants.dart`**
- **Path** -  /lib/mobikul/constants/app_constants.dart

## For iOS
Go to Assets.xcassets folder and change this.

## Push notification

## For Android
For push notification you need to change google-services.json file with yours.
- **Path** - /android/app/src/google-services.json
- **Path** -  /android/app/google-services.json
-
## For iOS
Change the topic from "mobikul_ios" to "" same as in Admin panel under Notification Configuration (iOS Topic heading)
Change GoogleService-Info.plist file
Set UP Push Notification check


## For Bundle ID & App Name :
## For Android
>Change `applicationId` in build.gradle file with the package-name in google-services file.

## For iOS
>Select Project & Targets
Change the Display name & BundleIdentifier
Localizable.strings file - Change "applicationname"


## Color Code
For changing the color theme of the application go to mobikul_theme.dart file and change the colors.
- **Path** - /lib/mobikul/configuration/mobikul_theme.dart

## App name
Change application name from /assets/languages/en.json
- appName

## For Add New Localization:
Goto /assets/languages and find string.xml file and translate it according to your localization.

### Add that string as a variable in the `app_string_constant.dart`
/lib/mobikul/constants/app_string_constant.dart

#### Sample
1. English
   ```
   "appName": "Magento 2 Mobile App",
   ```
2. Arabic
   ```
   "app_name": "Magento 2 Mobile App",
   ```

3. 'app_string_constant.dart'
   '''
   static const String appName = "appName";
   '''

## Magento 2 Mobile App-Admin-End Configuration:

Follow the below link to configure home page.

[Knowledge base](https://mobikul.com/knowledgebase/magento2-mobile-app-admin-end-configuration/)


    

# Capacitor

## Links

- (Capacitor)[https://capacitor.ionicframework.com/]
- (Android)[https://capacitor.ionicframework.com/docs/android]

## Shell

```
ionic capacitor add android
ng build
ionic capacitor copy android
ionic capacitor run android -l
[PROJECT]/android/app/build/outputs/apk/debug
```

## Android Studio
```
Build >> Rebuild Project
```

## BUGS

>[error] Capacitor could not find the web assets directory "/home/davidmeth/Projetos/TECH-LAB/IONIC-LAB/temp/www".
>    Please create it, and make sure it has an index.html file. You can change
>    the path of this directory in capacitor.config.json.
>    More info: https://capacitor.ionicframework.com/docs/basics/configuring-your-app
>[ERROR] An error occurred while running subprocess capacitor.

**JUST SMILE, ITS NOTHING RUN ng build AND BE HAPPY**

## INSTALL CORDOVA NATIVE
```
npm install @ionic-native/javascript-package-name
npm install cordova-plugin-name
ionic capacitor sync
```

## UPDATE CORDOVA NATIVE
```
npm install @ionic-native/javascript-package-name@latest
npm install cordova-plugin-name@latest
npx cap update
```

### Important: Configuration

> Capacitor does not support Cordova install variables, auto configuration, or hooks, due to our philosophy of letting you  control your native project source code (meaning things like hooks are unnecessary). If your plugin requires variables or settings to be set, you'll need to apply those configuration settings manually by mapping between the plugin's plugin.xml and required settings on iOS and Android.
**Consult the iOS and Android configuration guides for info on how to configure each platform.**


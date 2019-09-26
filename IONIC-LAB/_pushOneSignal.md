# PUSH NOTIFICATION
> https://www.youtube.com/watch?v=0j0Jz5ka5Co&t=66s 

## SHELL

```
ionic cordova plugin add onesignal-cordova-plugin
npm install @ionic-native/onesignal
``` 

# CAPACITOR 

## INSTALL
```
npm install @ionic-native/javascript-package-name
npm install cordova-plugin-name
ionic capacitor sync
```

## UPDATE
```
npm install @ionic-native/javascript-package-name@latest
npm install cordova-plugin-name@latest
npx cap update
```
> Important: Configuration
> Capacitor does not support Cordova install variables, auto configuration, or hooks, due to our philosophy of letting you  control your native project source code (meaning things like hooks are unnecessary). If your plugin requires variables or settings to be set, you'll need to apply those configuration settings manually by mapping between the plugin's plugin.xml and required settings on iOS and Android.
**Consult the iOS and Android configuration guides for info on how to configure each platform.**
# Shell

- **ionic cordova platform add ios** cordova ios native plugin
- **ionic cordova platform add android** cordova android native plugin
- **ionic serve --devapp** run app on phone
- **npm install @ionic-native/camera** add js dependecy
- **ionic cordova plugin add cordova-plugin-camera** add native android/ios code

# Files



# Code

- **<ion-title>Photo Gallery</ion-title>** title frame  
- **<script src="cordova.js"></script>** /src/index.html


## ADD CAMERA

**src/app/tab2/tab2.page.html**

```
<ion-content>
<img>

<ion-fab vertical="bottom" horizontal="center" slot="fixed">
    <ion-fab-button>
      <ion-icon name="camera"></ion-icon>
    </ion-fab-button>
</ion-fab>
</ion-content>
```
**src/app/app.module.ts**
``` 
import { Camera } from '@ionic-native/camera/ngx'; 

providers: [
    StatusBar,
    SplashScreen,
    Camera,
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ],
```
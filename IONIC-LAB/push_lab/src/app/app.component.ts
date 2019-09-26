import { Component } from '@angular/core';

import { Platform, AlertController } from '@ionic/angular';
import { SplashScreen } from '@ionic-native/splash-screen/ngx';
import { StatusBar } from '@ionic-native/status-bar/ngx';
import { OneSignal } from '@ionic-native/onesignal/ngx';


@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss']
})
export class AppComponent {
  constructor(
    private platform: Platform,
    private splashScreen: SplashScreen,
    private statusBar: StatusBar,
    private signal: OneSignal,
    private alertCTRL: AlertController
  ) {
    this.initializeApp();
  }

  initializeApp() {
    this.platform.ready().then(() => {
      this.statusBar.styleDefault();
      this.splashScreen.hide();
    });
  }

  async showAlert( title, msg, task) {
    const alert = await this.alertCTRL.create({
      header: title,
      subHeader: msg,
      buttons: [
        {text: `Action: ${task}`, handler: () => {}}
      ]
    });
    alert.present();
  }

  setuPush() {
    this.signal.startInit(/*ONE SIGNAL CODE*/, /*GOOGLE CODE*/);

    this.signal.inFocusDisplaying(this.signal.OSInFocusDisplayOption.Notification);

    this.signal.handleNotificationReceived().subscribe(data => {
      const msg = data.payload.body;
      const title = data.payload.title;
      const addtional = data.payload.additionalData;
      this.showAlert(title, msg, addtional.task);
    });

    this.signal.handleNotificationOpened().subscribe(data =>  {
      const additionalData = data.notification.payload.additionalData;
      this.showAlert('Notificações','Você leu isso', additionalData.task);
    });


    this.signal.endInit();
  }
}

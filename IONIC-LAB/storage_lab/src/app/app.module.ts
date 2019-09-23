import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';

import { IonicModule, IonicRouteStrategy } from '@ionic/angular';
import { SplashScreen } from '@ionic-native/splash-screen/ngx';
import { StatusBar } from '@ionic-native/status-bar/ngx';

import { SQLite,  SQLiteDatabaseConfig , SQLiteObject } from '@ionic-native/sqlite';
import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';



class SQLiteMock {
  public create(config: SQLiteDatabaseConfig): Promise<SQLiteObject> {

      return new Promise((resolve,reject)=>{
          resolve(new SQLiteObject(new Object()));
      });
  }
}

@NgModule({
  declarations: [AppComponent],
  entryComponents: [],
  imports: [BrowserModule, IonicModule.forRoot(), AppRoutingModule],
  providers: [
   {provide: SQLite, useClass: SQLiteMock},
   StatusBar,
    SplashScreen,
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy }
  ],
  bootstrap: [AppComponent]
})
export class AppModule {}

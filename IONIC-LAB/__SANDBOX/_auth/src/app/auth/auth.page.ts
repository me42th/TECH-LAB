import { Component, OnInit } from "@angular/core";
import { AuthService } from "./auth.service";
import { LoadingController } from "@ionic/angular";

@Component({
  selector: "app-auth",
  templateUrl: "./auth.page.html",
  styleUrls: ["./auth.page.scss"]
})
export class AuthPage implements OnInit {
  load = false;

  constructor(
    private authSRV: AuthService,
    private loadCTRL: LoadingController
  ) {}

  ngOnInit() {}

  authClick() {
    this.load = true;
    this.loadCTRL
      .create({ 
        keyboardClose: true, 
        message: "Logging in..." }
        ).then( loadEL => {
          loadEL.present();
          setTimeout(() => {
            this.load = false;
            loadEL.dismiss();
            this.authSRV.login();
          }, 1000);
        });

    
  }
}

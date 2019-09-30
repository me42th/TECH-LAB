import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormControl, Validators, FormGroup } from '@angular/forms';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { LoadingController } from '@ionic/angular';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.page.html',
  styleUrls: ['./auth.page.scss'],
})
export class AuthPage implements OnInit, OnDestroy {

  constructor(
    private authSRV: AuthService,
    private router: Router,
    private loadCTRL: LoadingController
  ) { }

  private subs: Subscription[] = [null];

  emailF: FormControl = new FormControl(
    '', {
      updateOn : 'change',
      validators : [Validators.required, Validators.email]
    }
  );

  password = new FormControl(
    '', {
      updateOn: 'change',
      validators : [Validators.required, Validators.minLength(5)]
    }
  );

  form: FormGroup;
  
  ngOnInit() {

   this.form = new FormGroup({
        emailF: this.emailF,
        password: this.password
      });
  }

  ngOnDestroy() {
    this.subs.forEach(sub => sub.unsubscribe);
  }

  async login() {
    const load = this.loadCTRL.create()
    .then(
      loadEl => {
        loadEl.present();
        this.subs.push(
          this.authSRV.signup(this.emailF.value).subscribe(
             valor => {
            if (typeof valor !== 'undefined') {
              this.router.navigateByUrl('/profile');
              loadEl.dismiss();
            }
          },
          erro => alert('erro')
         )
        );
      });
}
}

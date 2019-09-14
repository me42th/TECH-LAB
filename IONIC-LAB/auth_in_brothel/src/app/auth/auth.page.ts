import { Component, OnInit } from '@angular/core';
import { FormControl, Validators, FormGroup } from '@angular/forms';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.page.html',
  styleUrls: ['./auth.page.scss'],
})
export class AuthPage implements OnInit {

  constructor(
    private authSRV: AuthService,
    private router: Router
  ) { }

  private subscription: Subscription;

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
    this.subscription = this.authSRV.observable.subscribe(
      valor => {
        if (typeof valor !== 'undefined'){
          this.router.navigateByUrl('/profile');
        }
      });
    this.form = new FormGroup({
        emailF: this.emailF,
        password: this.password
      });
  }

  login() {
    this.authSRV.signup(this.emailF.value);
    ;
  }
}

import { Component, OnInit } from '@angular/core';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-auth',
  templateUrl: './auth.page.html',
  styleUrls: ['./auth.page.scss'],
})
export class AuthPage implements OnInit {

  constructor( private authSRV: AuthService, private router: Router) { }

  ngOnInit() {
  }

  isLogin = true;

  onLogin(){
    this.authSRV.login();
    this.router.navigateByUrl('/places/tabs/discover');
  }

  onSubmit(form: NgForm) {
    if(!form.valid){
      return;
    }
    const email = form.value.email;
    const password = form.value.password;
    console.log(email+' '+password);
    if(this.isLogin)
      console.log('login');
    else
      console.log('signup');
  }

  onSwitchAuthMode(){
    this.isLogin = !this.isLogin;
  }

}

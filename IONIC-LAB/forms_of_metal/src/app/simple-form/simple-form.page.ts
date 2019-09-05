import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-simple-form',
  templateUrl: './simple-form.page.html',
  styleUrls: ['./simple-form.page.scss'],
})
export class SimpleFormPage implements OnInit {

  isLogin: boolean = true;

  constructor() { }

  ngOnInit() {
  }

  onSubmit(form: NgForm) {
    console.log(form);
  }

  onSwitch(){
    this.isLogin = !this.isLogin;
  }

  onLogin(){
    alert('hello');
  }
}

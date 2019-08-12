import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private _login = false;
  
  constructor(
    private router: Router
  ) { }

  get canView() {
    return this._login;
  }

  login() {
    this._login = true;
    this.router.navigateByUrl('home');
  }
  logout() {
    this._login = false;
    this.router.navigateByUrl('auth');
  }
}

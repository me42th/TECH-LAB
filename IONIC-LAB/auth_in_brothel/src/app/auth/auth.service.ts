import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { BehaviorSubject } from 'rxjs';
import { map } from 'rxjs/operators';


export interface User {
  name: string;
  cidade: string;
  email: string;
  cell: string;
  phone: string;
  photo: string;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  url =  'https://randomuser.me/api/?nat=br';
  // tslint:disable-next-line: variable-name
  private _logged: true | false = false;
  // tslint:disable-next-line: variable-name
  private _user: User;

  // tslint:disable-next-line: variable-name
  private _boss: BehaviorSubject<User> = new BehaviorSubject(this._user);

  constructor(
    private http: HttpClient,
    
    ) { }

  get login() {
    return this._logged;
  }

  get user() {
    return this._user;
  }

  get observable() {
    return this._boss.asObservable();
  }
  signup(email: string) {
    this.http.get(this.url)
    .pipe(
      map( valor => {
        console.log(valor.results[0]);
        let mapUser: User = {
            name: valor.results[0].name.first.toUpperCase(),
            cidade: valor.results[0].location.city.toUpperCase(),
            email,
            cell:  valor.results[0].cell,
            phone: valor.results[0].phone,
            photo: valor.results[0].picture.medium
        };
         return mapUser;
      })
    )
    .subscribe(
      valor => {
        this._user = valor;
        this._boss.next(valor);
      }
    );
  }
}

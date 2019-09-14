import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class BaratinoService {

  private isOk: boolean = false;

  constructor() { }

  get ok() {
    return this.isOk;
  }

}

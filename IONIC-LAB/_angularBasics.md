# Shell

- npm install -g @angular/cli 
- ng new helloAngular
- ng serve

# Files

- **src\main.ts** boot file
- **src\app\app.module.ts** system config app 
- **src\app\NAME\NAME.page.html** view app
- **src\index.html** where the magic happens
- **src\XXX\XXX.component.css** this file has power only in your master

# Code

## PUSHING DATA AROUND WITH SUBJECTS

### XXX.COMPONENT.TS
```
import { Component, OnInit, OnDestroy } from '@angular/core';
[...]
import { Subscription } from 'rxjs';
[...]
export class XXXComponent implements OnInit, OnDestroy{
  xxxList: string[];
  private prsSubs: Subscription;
  ngOnInit(){
  [...]
    this.prsSubs = this.prsService.xxxChanged.subscribe(xxx => {
      this.xxxList = xxx;
    });
  }
  [...]
  ngOnDestroy(){
    this.prsSubs.unsubscribe();
  }
  [...]
```
### XXX.SERVICE.TS
```
[...]
import { Subject } from 'rxjs';
[...]
export class XXXService {
  xxxChanged = new Subject<string[]>();
  xxx = ["123", "111", "aaa"];

  addXXX(prs: string) {
    this.xxx.push(prs);
    this.xxxChanged.next(this.xxx);
  }

  rmvXXX(prs: string){
    this.xxx = this.xxx.filter(xxx => { return xxx !== prs});
    this.xxxChanged.next(this.xxx);
  }
}

```
## REMOVE ITEMS UPON A CLICK

### XXX.SERVICE.TS
```
rmvXXX(xxx: string){
  this.XXX = this.XXX.filter(xx => { return xx !== xxx}); //rmv every item be equals xx
  console.log(this.XXX);
}
```
### XXX.COMPONENT.TS
```
[...]
onClick(xxx: string){
  this.xxxService.rmvXXX(xxx);
}
[...]
```
### XXX.COMPONENT.HTML
```
<ul>
  <li *ngFor="let xxx of xxxList" (click)="onClick(xxx)"> {{ xxx }} </li>
</ul>
```

## NAVIGATING BETWEEN COMPONENTS

### APP.COMPONENT.HTML
```
<a routerLink="/" >XXX List</a> | <a [routerLink]="'/input'">Input XXX</a> // with [] = "''"
<hr>
<router-outlet></router-outlet>
```
## LIFE HOOK CICLE
```
import { Component, OnInit } from '@angular/core';
import { XXXService } from './xxx.service';
[...]
export class XXXComponent implements OnInit{
  xxxList: string[];
  constructor(private prsService: XXXService){ // dependency injection with autovar
  }
  ngOnInit(){ // run at object init
    this.xxxList = this.prsService.xxx; // var create in constructor with autovar
  }
}
```
## BASIC OF SERVICES

- **ADD NEW FILE /src/app/XXX/XXX.services.ts**

### XXX.SERVICES.TS
```
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class xxxService {
  xxx = ['abc', '123', 'III'];
  addXXX($var: string) {
    this.xxx.push($var);
  }
}

```
### XXX.COMPONENT.TS
```
import { xxxService } from './xxx.service';
[...]
export class xxxComponent {
  xxxList: string[];
  constructor(prsService: xxxService){
    this.xxxList = prsService.xxx;
  }
}
```

## ROUTING

- **ADD NEW FILE /src/app/app-routing.module.ts**

### APP-ROUTING.MODULE.TS

```
import { NgModule } from "@angular/core";
import { Routes, RouterModule } from "@angular/router"; 

import { XXXComponent } from "./XXX/XXX.component";
import { XXXInputComponent } from "./XXX/XXX-input.component";

const routes: Routes = [
  {path: '', component: XXXComponent},  
  {path: 'input', component: XXXInputComponent}
];

@NgModule({
imports: [RouterModule.forRoot(routes)],
exports:[RouterModule]
})

export class AppRoutingModule {}
```
### APP.MODULE.TS
```
import { AppRoutingModule } from './app-routing.module';
[...]
@NgModule({
[...]
  imports: [
    BrowserModule, FormsModule, AppRoutingModule
  ],
```
### APP.COMPONENT.HTML
```
<router-outlet></router-outlet>
```
## PASS DATA WITH CUSTOM EVENTS

### XXX.COMPONET.TS
```
import { Component, Output, EventEmitter } from '@angular/core';
[...]
export class XXXComponent {
  @Output() xxxEmitter = new EventEmitter<string>();
  xxxInput;
  onClick(){
    console.log(this.xxxInput);
    this.xxxEmitter.emit(this.xxxInput);
    this.xxxInput = '';
  }
```
### XXX.COMPONENT.HTML
```
<label for="name">Label</label>
<input type="text" id="name" [(ngModel)]="personInputComponent">
<input type="submit" (click)="onClick()" value="OK">
```
### APP.COMPONENT.TS
```
export class AppComponent {
  xxx = ['Maria', 'Antonio', 'João'];

  changeXXX($var){
    this.xxx.push($var);
  }
}
```
### APP.COMPONENT.HTML
```
<app-input-xxx (xxxEmitter)="changeXXX($event)"> </app-input-person>
```

## TWO WAY BINDING

### XXX.COMPONENT.TS
```
export class XXXComponent {
  dataFromVar = '';
  onClick(){
    console.log(this.dataFromVar);
  }
}
```
### XXX.COMPONENT.HTML
```
<label for="name">Label</label>
<input type="text" id="name" [(ngModel)]="dataFromVar">  
<input type="submit" (click)="onClick()" value="OK">  
```
### APP.MODULE.TS
```
import { FormsModule } from '@angular/forms';   
[...]
@NgModule({
[...]
  imports: [
    BrowserModule, FormsModule
  ],
[...]
```

## EVENTS BINDING

### XXX.COMPONENT.TS

```
export class XXXComponent {
  onClick(inputEl){ // here we go
    console.log(inputEl);  // :D
  }
      

```

### XXX.COMPONENT.HTML
```
<label for="name">Label</label>
<input type="text" id="name" #inputEl> // local reference
<input type="submit" (click)="onClick(inputEl.value)" [value]="1 + 1"> // send to component/ print 2 
```
## ANGULAR DIRECTIVES

```
<ul>
  <li *ngFor="let person of personsList">{{ person }}</li> //eachfor && string interpolation
</ul>
```

## PROPERTY BINDING

### XXX.COMPONENT.TS

```
import { Component, Input } from '@angular/core';
[...]
export class XXX{
    @Input () dataXXX: string[];
}
```

### APP.COMPONENT.HTML

```
<app-XXX [dataXXX] = "appVar"></app-XXX>
```

## XXX.MODULE.TS

```
import { XXXComponent } from './XXX/XXX.component'; //take the XXX file

@NgModule({
  declarations: [
    AppComponent, XXXComponent //declare the XXX Component, need be equals class name
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
```

## COMPONENT

```
@Component{(  
  selector: 'app-root',   //tag, be carefull with the default names like h1 or something like that  
  templateUrl: './app.component.html', //view
  styleUrls: ['./app.component.css'] // custom css to this file
})
```

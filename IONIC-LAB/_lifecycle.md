# IONIC+ANGULAR LIFECYCLE

## ANGULAR COMPONENTS

 * **ngOnInit**
 > LOAD ON MEMORY
 * **ngOnDestroy**
 > NEVER CALLED OR SOMETHING LIKE THAT

 ## IONIC PAGES

 * **ionViewWillEnter**
 > BEFORE LOAD PAGE 
 > AFTER NG_ON_INIT WILL_LEAVE 
 * **ionViewDidEnter**
 > BEFORE WILL_LEAVE
 > AFTER LOAD PAGE
 * **ionViewWillLeave**
 > BEFORE LOAD PAGE, WILL_ENTER
 > AFTER WILL_ENTER
 * **ionViewDidLeave**
 > BEFORE THE NEW LOAD

 ## CODE

``` 
 import { Component, OnInit, OnDestroy } from '@angular/core'; 
 [...]
 export class XXXPage implements OnInit, OnDestroy {
 [...]
  ngOnInit() {
    console.log('NG_ON_INIT');
  }

  ionViewWillEnter(){
    console.log('WILL_ENTER');
  }

  ionViewDidEnter(){
    console.log('DID_ENTER');
  }
  
  ionViewWillLeave(){
    console.log('WILL_LEAVE');
  }

  ionViewDidLeave(){
    console.log('DID_LEAVE');
  }

  ngOnDestroy(){
    console.log('NG_ON_DESTROY');
  }
 ``` 
# INPUT

```
<ion-button>
<ion-input>
<ion-textarea>
<ion-menu>
<ion-select>
<ion-datetime>
<ion-fab>
<ion-toggle>
```
#### ION-BUTTON

```
<ion-button fill="outline" color="danger"><ion-icon name="trash" slot="start"></ion-icon>Clear</ion-button>
<ion-button> <ion-icon name="add" slot="start"></ion-icon>Add Expense</ion-button>
```
#### ION-BUTTON WITH EVENT
```
 <ion-buttons slot="primary">
      <ion-button (click)="delRecipe()"><ion-icon name="trash" slot="icon-only"></ion-icon></ion-button>
    </ion-buttons>
```

# OUTPUT
```
<ion-img>
<ion-badge>
<ion-loading>
<ion-label>
<ion-title>
<ion-thumbnail>
<ion-toolbar>
<ion-alert>
<ion-toast>
<ion-modal>
```

#### ION-IMG
``` 
<ion-avatar>
   <ion-img [src]="XXX.imageURL"></ion-img>
</ion-avatar>
``` 

# LAYOUT
```
<ion-grid>
<ion-row>
<ion-card>
<ion-infinite-scroll>
<ion-tabs>
<ion-list>
```

#### ION-TABS
```
<ion-tabs>
  <ion-tab-bar slot="bottom">
    <ion-tab-button tab="xxx">
      <ion-label>
        XXX
      </ion-label>
      <ion-icon name="search"></ion-icon>
    </ion-tab-button>
    <ion-tab-button tab="yyy" >
      <ion-label>
        YYY
      </ion-label>
      <ion-icon name="card"></ion-icon>
    </ion-tab-button>
  </ion-tab-bar>
</ion-tabs>
``` 

#### ION-VIRTUAL-SCROLL
``` 
<ion-virtual-scroll [items]="array">
  <ion-item *virtualItem="let element"></ion-item>
</ion-virtual-scroll> 
```

#### ION-ITEM-SLIDING
```
<ion-list>
  <ion-item-sliding  *ngFor="let element of array">
    <ion-item>
      [...]
    </ion-item>
    <ion-item-options side="start">
      <ion-item-option (click)="onFucking()">
        <ion-icon slot="top" name="trash"></ion-icon>ABC
      </ion-item-option>
      <ion-item-option color="danger" >
        <ion-icon slot="icon-only" name="contact"></ion-icon>
      </ion-item-option>
    </ion-item-options>
    <ion-item-options side="end">
      <ion-item-option (click)="onEdit()">
        <ion-icon name="create"></ion-icon>Unread
      </ion-item-option>
    </ion-item-options>  
  </ion-item-sliding>
</ion-list>  
```

#### ION-LIST
```
<ion-list>
    <ion-item *ngFor="let item of itens">
        <ion-avatar slot="start">
            <ion-img [src]="item.imgURL"></ion-img>
        </ion-avatar>
        <ion-label> {{ item.title }} </ion-label>
    </ion-item>
    <ion-item lines="none">
      <ion-icon name="exit" slot="start"></ion-icon>
      <ion-label>Logout</ion-label>
    </ion-item>
</ion-list>
```
#### ION-ALERT
```
import { AlertController } from '@ionic/angular';
[...]
 constructor(
    private alertControler: AlertController
    ) { }
[...]
  delXXX(){
    this.alertControler.create({
      header: 'Are you sure?',
      message: 'Do you really want to delete the XXX?',
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Delete',
          handler: () => {
            this.XXXService.delXXX(this.loaddedXXX.id);
            this.router.navigate(['/XXX']);
         
          }
        }
      ]
    }).then(
      alertEl => {
        alertEl.present();
      });
  }    
```
#### ION-GRID
```
<ion-grid>
    <ion-row>
        <ion-col size-md="6" offset-md="3">        
        </ion-col>
    </ion-row>
</ion-grid>
```
#### NAVIGATION 
```
[...]
<ion-back-button defaultHref="/XXX" ></ion-back-button>
[...]      
<ion-item *ngFor="let item of itens" [routerLink]="['./',item.id]">
[...]
``` 
#### CUSTOM CSS && HTML
```
    <div margin-vertical text-right>
        <ion-button>Clear</ion-button>
    </div>
```
#### VANILA JS
* cjdyeag_DONT_DELETE
* * app.js
* * index.html

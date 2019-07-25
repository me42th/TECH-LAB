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

#### ION-LIST
```
<ion-list>
    <ion-item *ngFor="let item of itens">
        <ion-avatar slot="start">
            <ion-img [src]="item.imgURL"></ion-img>
        </ion-avatar>
        <ion-label> {{ item.title }} </ion-label>
    </ion-item>
</ion-list>

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

# NAVIGATION

## HTML FILE WITHOUT ID

```
<ion-fucking-thing routerLink="/places/tabs/offers/new">
```

## HTML WITH DINAMIC PARAMETERS
```
// detail make the arrow to right
<ion-item *ngFor="let place of places.slice(1)" detail [routerLink]="['/','places','tabs','discover',place.id]">
```
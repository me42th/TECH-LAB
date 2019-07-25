# Shell

- **ng generate component recipes**
- **ng g c recipes**
- **ionic generate**
- **ionic generate page XXX/SomeXXXFunc**

# Files

#### SRC/APP/XXX/XXX.MODEL.TS

> MODEL

#### SRC/THEME/VARIABLES.SCSS

> PROPRIEDADES DO LAYOUT

#### ANGULAR.JSON

> PROPRIEDADES DO ANGULAR

#### IONIC.CONFIG.JSON

> PROPRIEDADES DO PROJETO

#### PACKAGE.JSON

> ANGULAR E IONIC IMPORTS

# CODE

#### BASIC ROUTING

```
const routes: Routes = [
  // directly  
  { path: '', redirectTo: 'XXX', pathMatch: 'full' },
  // with suburl  
  { 
    path: 'XXX', 
    children: [
      {path: '', loadChildren: './XXX/XXX.module#XXXPageModule'},
      {path: ':XXXid', loadChildren: './XXX/detail/detail.module#DetailPageModule' }
    ]
     
  },
];
```
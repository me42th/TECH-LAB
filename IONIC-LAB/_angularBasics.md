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

## ANGULAR DIRECTIVES

```
<ul>
  <li *ngFor="let person of personsList">{{ person }}</li> //eachfor && string interpolation
</ul>
```

## PROPERTY BINDING

### XXX.MODULE.TS

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

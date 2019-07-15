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


## NGMODULE

```
@Component{(  
  selector: 'app-root',   //tag
  templateUrl: './app.component.html', //view
  styleUrls: ['./app.component.css'] // custom css to this file
})
```

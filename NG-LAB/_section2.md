# THE BASICS
> **REPOSITORIO COMPONENT-STUFF**

<details>
  <summary>SHELL</summary>
    <p>ng generate component [NAME]</p>
    <p>ng g c [NAME]</p>
</details>  

## NGSTYLE
> SETA VALORES DINAMICOS AO ELEMENTO

```
@Component({
  selector: '.app-server',
  //templateUrl: './server.component.html'
  template: `
  <p
  [ngStyle]="{
    backgroundColor: color()
  }"
  >Server with ID {{id}} IS {{serverStatus}}
  </p>`,
})
```

## NGCLASS
> ADD OU REMOVE UMA CLASSE DADO UMA CONDIÇÃO


```
@Component({
  selector: '.app-server',
  //templateUrl: './server.component.html'
  template: `
  <p
  [ngClass]="{
    online: serverStatus === 'online'
  }"
  >Server with ID {{id}} IS {{serverStatus}}
  </p>`,
  styles: [`
  .online{
    color: white
  }
  `]
})
```
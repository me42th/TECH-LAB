# Styling & Theming

## Color Generator

{[COLOR GENERATOR](https://ionicframework.com/docs/theming/color-generator)}
{[VAR CSS](https://ionicframework.com/docs/theming/themes)}
## Files

### ~/global.css
> Tema Global

### theme/variables.scss
> Variáveis Css
```
.ios {
  --ion-toolbar-background: #59ff38; 
}

.md {
  --ion-toolbar-background: #ff7938;
}
```

## FONT AWESOME

> I haven’t used Bootstrap, but I have included FontAwesome in my mobile project. I think there’s an issue with the       
>current CLI though, so I haven’t verified if this works in RC4/5. When I did this I worked in RC3
>It require two things
```
- npm install FontAwesome/Bootstrap
```
> Custom copy script in the config section of the package.json file
```
“config”: {
“ionic_copy”: “./config/copy.config.js” //within your project directory
},
```
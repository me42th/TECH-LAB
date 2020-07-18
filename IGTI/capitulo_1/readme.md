# Capitulo 1 | [VOLTAR](../readme.md)


## CSS

### DECLARAÇÃO
```
<head>
    <style>
        h1{
            color: red;
        }
		.azul{
			color: blue;
		}
		#verde{
			color: green;
		}
    </style>
    <link rel="stylesheet" href="./css/style.css">
</head>

<p style="color: blue;"> 
    Blue
</p>
```

### FIRA CODE
https://github.com/tonsky/FiraCode

### EXTENSIONS
- WINTER IS COMING
- VSCODE ICONS
- DEBUGGER FOR CHROME
- PRETTIER - CODE FORMATTER
- COLOR HIGHLIGHT

### VSCODE TIPS
```
>settings /* CONFIGURAÇÕES */

!+TAB /* HTML VIA EMMET */

DIV.NOME_CLASSE /* <DIV CLASS='NOME_CLASSE'> */

CLICK+F2 /* RENOMEIA TODAS OCORRENCIAS */
```

### LIVE SERVER
```
npm install -g live-server
```

>>  rem: medidade relativa de tamanho

### CSS RESET
```
/* http://meyerweb.com/eric/tools/css/reset/ 
   v2.0 | 20110126
   License: none (public domain)
*/

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
	display: block;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}
```
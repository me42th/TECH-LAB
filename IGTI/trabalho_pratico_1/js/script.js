var inputRed = document.querySelector('#inputRed');
var inputGreen = document.querySelector('#inputGreen');
var inputBlue = document.querySelector('#inputBlue');

var rangeRed = document.querySelector('#rangeRed');
var rangeBlue = document.querySelector('#rangeBlue');
var rangeGreen = document.querySelector('#rangeGreen');

var square = document.querySelector('#square');

var red , green, blue;
window.addEventListener(
    'load', 
    () => {

        red = rangeRed.value;
        green = rangeGreen.value;
        blue = rangeBlue.value;
   
        colorSquare();

        inputRed.value = red;
        inputGreen.value = green;
        inputBlue.value = blue;
        
        rangeRed.addEventListener(
            'change',
            (event) => {
                red = event.target.value;
                inputRed.value = red;
                colorSquare();
            }
        );
        rangeGreen.addEventListener(
            'change', 
            (event) => {
                green = event.target.value;
                inputGreen.value = green;
                colorSquare ();
            }
        );
        rangeBlue.addEventListener(
            'change', 
            (event) => {
                blue = event.target.value;
                inputBlue.value = blue;
                colorSquare();
            }
        );
    }
);

function colorSquare(){  
    let hexaRed = Number(red).toString(16);
    hexaRed = hexaRed.length == 2 ? hexaRed 
            : hexaRed.length == 1 ? '0'+hexaRed
            : '00';  
    let hexaGreen = Number(green).toString(16);
    hexaGreen = hexaGreen.length == 2 ? hexaGreen
            : hexaGreen.length == 1 ? '0'+hexaGreen
            : '00';
    let hexaBlue = Number(blue).toString(16);
    hexaBlue= hexaBlue.length == 2 ? hexaBlue
            : hexaBlue.length == 1 ? '0'+hexaBlue
            : '00'; 
    let hexaColor = '#'+hexaRed+hexaGreen+hexaBlue;
    console.clear();  
    console.log(hexaColor);
    square.style.backgroundColor = hexaColor;
}



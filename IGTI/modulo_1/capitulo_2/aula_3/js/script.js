var input = document.querySelector('#input1');
var textarea = document.querySelector('#textarea');
input.addEventListener('mousemove', (event) => {
    console.clear();
       
    var ref_red = event.clientX / 188; 
    var ref_blue = event.clientY / 222; 
    

    console.log(ref_red);

    var red = Math.ceil(255*ref_red).toString(16);
    var green = '00';
    var blue = Math.ceil(255*ref_blue).toString(16);;
    var cor = { red,green,blue};
    console.table(cor);
    

    textarea.style.backgroundColor = '#'+red+green+blue;
    

    console.log(event);
});
console.log(11);
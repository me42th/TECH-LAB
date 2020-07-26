const dbNames = [];
var form = null;
var input = null;
var div = null;

var pos = 0;

window.addEventListener(
    'load',
    () => {
        form = document.querySelector('form');
        input = document.querySelector('#inputName');
        div = document.querySelector('#names');

        form.addEventListener(
            'submit',
            (event) => {
                event.preventDefault();
                dbNames.push(input.value);
                input.value = '';
                render();
            }
        );

        input.addEventListener(
            'keyup',
            (event) => {
            }
        );
        
        input.focus();
    }
);

function render(){
    div.innerHTML = '';
    var ul = document.createElement('ul');
    dbNames.forEach(
        (element) => {
            let li = document.createElement('li');
            li.textContent = element;
            ul.appendChild(li);
        }
    );
    div.appendChild(ul);
}
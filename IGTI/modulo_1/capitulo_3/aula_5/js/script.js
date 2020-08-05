var arrayOfItens = [];
var input; 
var form;
var list;
var ul;
var h2;

var item = {value: '',id: null};

window.addEventListener(
    'load',
    () => {
        form = document.querySelector('form');
        input = document.querySelector('#inputName');
        list = document.querySelector('#listName');
        h2 = document.createElement('h2');

        form.addEventListener(
            'submit', 
            (event) => event.preventDefault()            
        )
        input.addEventListener(
            'keyup',
            (event) => {
                if(event.key === 'Enter'){                    
                    updateList();
                }
            }
        );
        input.focus();
    }
);

function updateList(){
    if(input.value.trim() === ''){
        input.value = '';
        return;    
    }
    item.value = input.value;
    if(item.id === null){
        item.id = arrayOfItens.length;
        arrayOfItens.push(item);
    } else {
        arrayOfItens[item.id] = item;
    } 
    renderList();
    input.value = '';
    item = {value: '', id: null}
}
function renderList(){
    
    if(ul == null){
        ul = document.createElement('ul');
        list.appendChild(h2);
        list.appendChild(ul);
    }else{
        ul.innerHTML = '';
    }

    h2.textContent = arrayOfItens.length == 0
    ?''
    :'Nomes Cadastrados';

    arrayOfItens.forEach(
        (theItem) => {
            var li = document.createElement('li');
            var button = document.createElement('button');
            var span = document.createElement('span');
            button.textContent = 'X';
            button.classList.add('deleteButton');
            span.textContent = theItem.value; 
            span.classList.add('clickable');
            li.appendChild(button);
            li.appendChild(span);
            span.addEventListener(
                'click',
                () => {
                    item = theItem;
                    input.value = item.value;
                    input.focus();
                }
            );
            button.addEventListener(
                'click',
                () => {
                    var indice = arrayOfItens.indexOf(theItem);
                    console.log(theItem);
                    arrayOfItens = arrayOfItens.filter(
                        innerItem => innerItem.id !== theItem.id 
                    );
                    input.value = '';
                    item = {value: '',id: null};
                    renderList();
                }
            );
            ul.appendChild(li);
        }
    );
}
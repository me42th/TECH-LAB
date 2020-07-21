const dbNames = [];
var pos = 0;
window.addEventListener(
    'load',
    () => {
        const form = document.querySelector('form');
        const input = document.querySelector('#inputName');
        
        form.addEventListener(
            'submit',
            (event) => {
                event.preventDefault();
                dbNames.push(input.value);
                input.value = '';
                alert(dbNames);
            }
        );
        
        input.focus();
    }
);
var global_names = [];

window.addEventListener(
    'load',
    () => {
        var form = document.querySelector('form');
        var input = document.querySelector('#inputName');

        input.focus();
        form.addEventListener(
            'submit', 
            (event) => event.preventDefault() 
        )

        input.addEventListener(
            'keyup',
            () => alert('asd')
        );
        alert('123');
    }
);
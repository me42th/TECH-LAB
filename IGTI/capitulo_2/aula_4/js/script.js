window.addEventListener('load',
    () => {
        const span = document.querySelector('#nameLength');
        const input = document.querySelector('#nameInput');
        const form = document.querySelector('form');
        form.addEventListener(
            'submit',
            (event) => event.preventDefault()
        );
        input.addEventListener(
            'keyup', 
            () => span.textContent = input.value.length
        );
    });
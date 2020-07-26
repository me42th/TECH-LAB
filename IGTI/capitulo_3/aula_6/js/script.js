

window.addEventListener(
    'load',
    () => {
        let valueTimer = 0;

        const divTimer = document.querySelector('#timer');
        const buttonStop = document.querySelector('#stop');
        const interval = setInterval(
            () => {
                divTimer.textContent = ++valueTimer;                
                    setTimeout(
                        () => divTimer.textContent = valueTimer+'.5',
                        500
                    );                
            },1000); 


        buttonStop.addEventListener(
            'click',
            () => {
                this.clearInterval(interval);
            }
        );

    }
);
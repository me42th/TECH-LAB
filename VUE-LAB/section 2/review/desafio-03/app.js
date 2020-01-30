new Vue({
    el: '#desafio',
    data: {
        valor: 0
    },
    watch: {
        resultado(antigo, novo){
            if(antigo == 'Buguei')
                setTimeout(
                    () => this.valor = 0,
                    600
                );
        }
    },
    computed: {
        resultado(){
            const v = this.valor;
            return v == 0 ? 'Zero' :
                   v == 1 ? 'Um'   :
                   v == 2 ? 'Dois' :
                   v == 3 ? 'Tres' :
                   v == 4 ? 'Quatro' :
                   v == 5 ? 'Cinco' :
                   'Buguei';
        }
    }
});
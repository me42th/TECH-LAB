new Vue({
    el: '#desafio',
    data: {
        valor: ''
    },
    methods: {
        exibirAlerta(){
            alert('ABC');
        },
        storeValue(event){
            this.valor = event.target.value; 
        }
    }
})
new Vue({
    el: '#desafio',
    data: {
        nome: 'David',
        idade: '29',
        url: 'https://picsum.photos/200/300'
    },
    methods: {
        ranfom(){
            return Math.random();
        },
        nomeAlt(event){
            this.nome = event.target.value;
        }
    }
});


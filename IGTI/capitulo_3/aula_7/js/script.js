const programador = (nick) => fetch(`https://api.github.com/users/${nick}`)
.then(
    res => res
        .json()
        .then(data => console.log(data))
        .catch(data => console.error(data))
    )
.catch(
    data => console.error(data)
);

const dev = async (nick) => {
    let dados = await fetch(`https://api.github.com/users/${nick}`); 
    dados = await dados.json();
    console.log(dados);
}

const divPromise = (a,b) => new Promise(
    (resolve,reject) => {
        if(b == 0){
            reject('Não é possível dividir por 0');
        }
        resolve(a/b);
    }
) 

const execPromise = () => {
    divPromise(1,0).then(data => console.log(data)).catch(console.log('Zero'));
    divPromise(1,1).then(data => console.log(data)).catch(console.log('Zero'));
}

const execAwait = async () => {
    const div2 = await divPromise(1,1);
    console.log(div2);
    const div = await divPromise(1,0);
}

window.addEventListener(
    'load',
    () => {
        execAwait();
    }
);
var users;
var flagLoad = false;
var input;
var span;
var ulLeft;
var homemSpan;
var mulherSpan;
var sumSpan;
var avgSpan;


window.addEventListener(
    "load", 
    () =>  {
        input = document.querySelector('#searchInput');
        span = document.querySelector('#spanQuantidade');
        homemSpan = document.querySelector('#homem');
        mulherSpan = document.querySelector('#mulher');
        avgSpan = document.querySelector('#avg');
        sumSpan = document.querySelector('#sum');

        ulLeft = document.querySelector('#ulLeft');
        ulLeft.innerHTML = '';
        run();
    });

const searchUser = name => users.results
.filter(
    user => `${user.name.first} ${user.name.last}`.toUpperCase().includes(name.toUpperCase())
).map(
    user => {
        return {
            name: `${user.name.first} ${user.name.last}`,
            gender: user.gender,
            picture: user.picture.thumbnail,
            age: user.dob.age
        };
    }         
)

const run = () =>
{
    bootloader(100);
    var interval = setInterval( () => {
        if(flagLoad){
            this.clearInterval(interval);
            
            input.addEventListener(
                'keyup',
                (event) => { 
                    let searchName = event.target.value;
                    ulLeft.innerHTML = '';
                    if(searchName.trim() == ''){
                        span.textContent = ''; 
                        ulLeft.innerHTML = '';
                        sumSpan.textContent = '';
                        avgSpan.textContent = '';
                        homemSpan.textContent = '';
                        mulherSpan.textContent = '';

                    } else {
                        let userList = searchUser(searchName);
                        userList.forEach(
                            user => {
                                let li = document.createElement('li');
                                let img = document.createElement('img');
                                let spanUsuario = document.createElement('span');
                                spanUsuario.textContent = `${user.name}, ${user.age} anos`;
                                img.src = user.picture;
                                li.appendChild(img);
                                li.appendChild(spanUsuario);
                                ulLeft.appendChild(li);
                            }
                        );
                        let totalIdade = userList.reduce(
                            (acc,curr) => acc+curr.age, 0
                        );

                        let mediaIdade = totalIdade / userList.length;
                        
                        let totalMulher = userList
                            .filter( user => user.gender == 'female')
                            .reduce( acc => ++acc,0);

                        let totalHomem = userList
                            .filter( user => user.gender == 'male')
                            .reduce( acc => ++acc,0);    
                        
                        homemSpan.textContent = totalHomem;
                        mulherSpan.textContent = totalMulher;
                        sumSpan.textContent = totalIdade;
                        avgSpan.textContent = mediaIdade;
                        span.textContent = userList.length;
                        
                   

                    }

                }
            );
        } 
    },200);
} 

const bootloader = (quantidade) =>
fetch(
  `https://randomuser.me/api/?seed=javascript&results=${quantidade}&nat=BR&noinfo`
).then(
    (res) => res.json().then(
        data => {
            flagLoad = true; 
            users = data;
        }
    ).catch(
        value => console.error('Algo de errado não está certo A'+value)
    )
)
.catch(
    value => console.error('Algo de errado não está certo B'+value)
);
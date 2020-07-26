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

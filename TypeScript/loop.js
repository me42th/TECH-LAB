var i = 1;
while (i <= 20) {
    console.log(i++);
}
do {
    console.log(--i);
} while (i > 1);
for (var i = 1;; console.log(i++)) {
    if (i % 2 !== 0) {
        continue;
    }
    console.log('par');
    if (i > 20) {
        break;
    }
}

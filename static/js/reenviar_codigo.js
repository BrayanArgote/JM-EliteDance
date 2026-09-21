// Solo maneja el contador regresivo, nada más
let segundos = 296; // 4:56
const temporizador = document.getElementById('temporizador');

const intervalo = setInterval(() => {
    segundos--;
    if (segundos <= 0) {
        temporizador.textContent = 'Código expirado';
        clearInterval(intervalo);
        return;
    }
    const min = Math.floor(segundos / 60);
    const seg = (segundos % 60).toString().padStart(2, '0');
    temporizador.textContent = `Expira en ${min}:${seg}`;
}, 1000);
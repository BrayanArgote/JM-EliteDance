// Solo valida que las dos contraseñas coincidan y luego redirige al inicio de sesión
const form = document.getElementById('formNuevaPass');
const inputPass1 = document.getElementById('inputPass1');
const inputPass2 = document.getElementById('inputPass2');
const passwordError = document.getElementById('passwordError');

// Medidor de fuerza + requisitos en tiempo real
const strengthSegs = document.querySelectorAll('#strengthBar .strength-seg');
const reqLength = document.getElementById('reqLength');
const reqNumber = document.getElementById('reqNumber');
const reqLetter = document.getElementById('reqLetter');
const reqEmail = document.getElementById('reqEmail');

function evaluarPassword() {
    const valor = inputPass1.value;
    const cumpleLargo = valor.length >= 8 && valor.length <= 64;
    const cumpleNumero = /[0-9]/.test(valor);
    const cumpleLetra = /[a-zA-Z]/.test(valor);
    const noPareceCorreo = !valor.includes('@'); // no tenemos el correo real guardado aquí

    [
        [reqLength, cumpleLargo],
        [reqNumber, cumpleNumero],
        [reqLetter, cumpleLetra],
        [reqEmail, noPareceCorreo]
    ].forEach(([el, cumple]) => {
        el.classList.toggle('req-ok', cumple && valor.length > 0);
    });

    const totalCumplidos = [cumpleLargo, cumpleNumero, cumpleLetra, noPareceCorreo].filter(Boolean).length;
    const segmentosActivos = valor.length === 0 ? 0 : Math.ceil((totalCumplidos / 4) * 5);

    strengthSegs.forEach((seg, i) => {
        seg.classList.toggle('strength-seg--on', i < segmentosActivos);
    });
}

inputPass1.addEventListener('input', evaluarPassword);

form.addEventListener('submit', (e) => {
    e.preventDefault();
    passwordError.textContent = '';

    if (inputPass1.value === '' || inputPass2.value === '') {
        passwordError.textContent = 'Completa ambos campos de contraseña.';
        return;
    }

    if (inputPass1.value !== inputPass2.value) {
        passwordError.textContent = 'Las contraseñas no coinciden.';
        return;
    }

    window.location.href = UrlIniciarSesion;
});
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/inicio')
def inicio():
    return render_template('inicio.html')

@app.route('/inicio-sesion')
def inicio_sesion():
    return render_template('inicio_sesion.html')

@app.route('/registro')
def registro():
    return render_template('registro.html')

@app.route('/recuperar-contrasenia')
def recuperar_contrasenia():
    return render_template('recuperar_contrasenia.html')

@app.route('/reenviar-codigo', methods=['GET', 'POST'])
def reenviar_codigo():
    if request.method == 'POST':
        # logica para reenviar el código
        pass
    return render_template('reenviar_codigo.html')

@app.route('/confirmacion-codigo')
def confirmacion_codigo():
    return render_template('confirmacion_codigo.html')

if __name__ == '__main__':
    app.run(debug=True) 

  # app.run(host='0.0.0.0', port=5000, debug=True)  # abrir desde otro equipo
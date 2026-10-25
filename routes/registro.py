from flask import Blueprint, render_template, request, redirect, url_for
from basedatos.conexion import db
from mysql.connector import IntegrityError

registro_bp = Blueprint("registro", __name__)

@registro_bp.route('/registro', methods=['GET', 'POST'])
def registro():
    
    if request.method == 'POST':
        nombre_completo = request.form['nombre_completo'].strip()
        correo = request.form['correo'].strip().lower()
        contrasenia_hash = request.form['contrasenia']

        cursor = db.cursor()

        sql = """
            INSERT INTO usuarios (nombre_completo, correo, contrasenia_hash)
            VALUES (%s, %s, %s)
        """

        try:
            cursor.execute(sql, (nombre_completo, correo, contrasenia_hash))
            db.commit()
            cursor.close()
            return redirect(url_for('iniciar_sesion.iniciar_sesion'))


        except IntegrityError:
            db.rollback()
            cursor.close()
            return render_template('registro.html', error_correo="Este correo ya está registrado.")
        
    return render_template('registro.html')
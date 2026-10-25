from flask import Blueprint, render_template, request, redirect, url_for
from basedatos.conexion import db

iniciar_sesion_bp = Blueprint("iniciar_sesion", __name__)

@iniciar_sesion_bp.route("/iniciar_sesion", methods=["GET", "POST"])
def iniciar_sesion():

    if request.method == "GET":
        return render_template("iniciar_sesion.html")

    correo = request.form.get("correo", "").strip().lower()
    contrasenia = request.form.get("contrasenia", "").strip()

    if not correo or not contrasenia:
        return redirect(url_for("iniciar_sesion.iniciar_sesion"))

    cursor = db.cursor()

    sql = """
        SELECT id, nombre_completo, correo
        FROM usuarios
        WHERE correo = %s AND contrasenia_hash = %s
    """

    cursor.execute(sql, (correo, contrasenia))

    usuario = cursor.fetchone()
    cursor.close()

    if usuario is None:
        return render_template("iniciar_sesion.html", error="Correo o contraseña incorrectos.")

    # return redirect(url_for(""))

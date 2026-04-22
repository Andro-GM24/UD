import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from scipy.integrate import odeint

# 1. Definimos la función de la EDO (dx/dt)
def modelo_mezcla(x, t, re, rs, ce, v0):
    vol = v0 + (re - rs) * t
    if vol <= 0: return 0 # Evitar división por cero si se vacía
    dxdt = (ce * re) - (rs / vol) * x
    return dxdt

# 2. Configuración de la grafica
fig, ax = plt.subplots(figsize=(10, 7))
plt.subplots_adjust(bottom=0.35)

tiempo = np.linspace(0, 500, 1000)
x0 = 0 # Cantidad inicial de sal

# 3. Sliders
ax_re = plt.axes([0.2, 0.25, 0.6, 0.03])
ax_rs = plt.axes([0.2, 0.20, 0.6, 0.03])
ax_ce = plt.axes([0.2, 0.15, 0.6, 0.03])
ax_v0 = plt.axes([0.2, 0.10, 0.6, 0.03])

s_re = Slider(ax_re, 'R. Entrada (gal/min)', 0.0, 10.0, valinit=3.0)
s_rs = Slider(ax_rs, 'R. Salida (gal/min)', 0.0, 10.0, valinit=3.0)
s_ce = Slider(ax_ce, 'Conc. Entrada (lb/gal)', 0.0, 5.0, valinit=2.0)
s_v0 = Slider(ax_v0, 'Vol. Inicial (gal)', 10.0, 1000.0, valinit=300.0)

# 4. Función para actualizar la gráfica
line, = ax.plot(tiempo, np.zeros_like(tiempo), lw=2, color='teal')
ax.set_ylim(0, 1000)
ax.grid(True, linestyle='--', alpha=0.7)

def update(val):
    re = s_re.val
    rs = s_rs.val
    ce = s_ce.val
    v0 = s_v0.val
    
    # Resolvemos numéricamente , más eficiente que obtener la función resultado
    y_num = odeint(modelo_mezcla, x0, tiempo, args=(re, rs, ce, v0))
    
    line.set_ydata(y_num)
    ax.set_ylim(0, max(np.max(y_num) * 1.2, 10))
    ax.set_title(f"Sal en el tanque en el punto maximo: {np.max(y_num):.2f} lb (Estado actual)")
    fig.canvas.draw_idle()

# Llamada inicial y conexión
update(None)
s_re.on_changed(update)
s_rs.on_changed(update)
s_ce.on_changed(update)
s_v0.on_changed(update)

plt.show()
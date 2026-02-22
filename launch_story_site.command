#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

# Asegura rutas locales para assets
ln -sfn ../graficos graficos
ln -sfn ../visualizaciones_avanzadas visualizaciones_avanzadas
ln -sfn ../estrategia_y_causal estrategia_y_causal

# Detecta Python
if command -v python3 >/dev/null 2>&1; then
  PY_CMD="python3"
elif command -v python >/dev/null 2>&1; then
  PY_CMD="python"
else
  echo "No se encontró Python (python3/python)."
  read -n 1 -s -r -p "Presiona cualquier tecla para cerrar..."
  exit 1
fi

# Busca puerto libre (8080-8090)
PORT=""
for p in {8080..8090}; do
  if ! lsof -nP -iTCP:"$p" -sTCP:LISTEN >/dev/null 2>&1; then
    PORT="$p"
    break
  fi
done

if [ -z "$PORT" ]; then
  echo "No hay puertos libres entre 8080 y 8090."
  read -n 1 -s -r -p "Presiona cualquier tecla para cerrar..."
  exit 1
fi

STAMP=$(date +%s)
URL="http://127.0.0.1:${PORT}/index.html?v=${STAMP}"

echo "Carpeta servida: $(pwd)"
echo "Python: ${PY_CMD}"
echo "Puerto: ${PORT}"
echo "URL (sin caché): ${URL}"

# Inicia servidor local con headers no-cache
${PY_CMD} ./serve_no_cache.py --host 127.0.0.1 --port "${PORT}" >/tmp/story_site_server.log 2>&1 &
SERVER_PID=$!

cleanup() {
  kill "$SERVER_PID" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

sleep 1
open "$URL" || true

echo "Servidor activo. Mantén esta ventana abierta. Para detener: Ctrl + C"
wait "$SERVER_PID"

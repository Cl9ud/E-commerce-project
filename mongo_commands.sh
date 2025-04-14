# ==============================
# MongoDB: Importación y consultas
# ==============================

# Importar datos desde catalog.json al servidor MongoDB
mongoimport --host 172.21.175.157 \
  -u root -p 'v3j4rGHSM4GQZAhSz7VKEUrF' \
  --authenticationDatabase admin \
  --db catalog \
  --collection electronics \
  --file /home/project/catalog.json

# ==============================
# Conexión a MongoDB con mongosh
# ==============================

mongosh --host 172.21.175.157 \
  -u root -p 'v3j4rGHSM4GQZAhSz7VKEUrF' \
  --authenticationDatabase admin

# ==============================
# Comandos dentro de mongosh:
# ==============================

# Seleccionar base de datos
use catalog

# Ver bases de datos disponibles
show dbs

# Ver colecciones de la base actual
show collections

# Crear índice sobre el campo "type"
db.electronics.createIndex({ type: 1 })

# Contar documentos tipo "laptop"
db.electronics.countDocuments({ type: "laptop" })

# Contar smartphones con tamaño de pantalla 6 pulgadas
db.electronics.countDocuments({
  type: "smart phone",
  "screen size": 6
})

# Calcular promedio del tamaño de pantalla de smartphones
db.electronics.aggregate([
  { $match: { type: "smart phone" } },
  {
    $group: {
      _id: null,
      averageScreenSize: { $avg: "$screen size" }
    }
  }
])

# ==============================
# Exportar resultados a CSV
# ==============================

mongoexport --host 172.21.175.157 \
  -u root -p 'v3j4rGHSM4GQZAhSz7VKEUrF' \
  --authenticationDatabase admin \
  --db catalog \
  --collection electronics \
  --type=csv \
  --fields _id,type,model \
  --out /home/project/electronics.csv

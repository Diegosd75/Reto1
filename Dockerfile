# Usar una imagen base de Python
FROM python:3.9-slim

# Establecer directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema para un usuario sin privilegios
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*


# Crear un grupo y usuario sin privilegios
RUN groupadd -r miusuario && useradd -r -g miusuario -d /app -s /bin/false miusuario

# Copiar el archivo de requerimientos primero, para aprovechar la caché de capas de Docker
COPY requirements.txt .

# Instalar las dependencias necesarias
RUN pip install --no-cache-dir -r requirements.txt

# Crear un no-root usuario
RUN useradd -m admin

# Copiar el código fuente del microservicio en el contenedor
COPY . .

# Run the application as non-root user
USER admin

# Expose the port the app runs on
EXPOSE 5000

# Run the application on container startup
CMD ["python", "./event-processor.py"]
# Fichier : Dockerfile

# Étape 1 : Utiliser une image de base (Python léger)
FROM python:3.9-slim

# Étape 2 : Installer Flask
RUN pip install flask

# Étape 3 : Copier le fichier app.py dans l'image
COPY app.py /app.py

# Étape 4 : Spécifier la commande pour lancer l'application
CMD ["python3", "/app.py"]

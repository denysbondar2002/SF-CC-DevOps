FROM python:3.7-alpine
LABEL maintainer="denisbondar2002@gmail.com"
WORKDIR /app
COPY requirements.txt .
RUN pip install  --no-cache-dir -r requirements.txt
COPY FlaskCRUD /app
EXPOSE 8080
CMD ["python3", "/app/app.py"]

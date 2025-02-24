#Grab the latest alpine image
FROM python:3.13.0a2-alpine

# Créez et activez un environnement virtuel pour éviter les conflits
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku
# EXPOSE 5000 		

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT wsgi
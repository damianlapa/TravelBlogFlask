# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.10-slim

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
# NOTE: najpierw kopiujesz plik z zaleznościami
# nie bedzie wykonywać tego kroku za każdym razem,
# tylko jak zależności się zmienią
COPY requirements.txt ./

# Install production dependencies.
# NOTE: Flask masz w requirements.txt
RUN pip install gunicorn
RUN pip install --no-cache-dir -r requirements.txt

COPY ./src/ ./src
# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :${PORT} --workers 1 --threads 8 --timeout 90 src:app

FROM alpine:latest as cytrynki

RUN apk --update add --no-cache sqlite bash curl py3-flask py3-gunicorn py3-pip && mkdir -p /home/cytrynki
RUN pip install flask_httpauth 
COPY flask_www/ /home/cytrynki/flask_www/
COPY database.sh /

EXPOSE 5000/tcp
WORKDIR /home/cytrynki/flask_www/
HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:5000/ || exit 1
CMD ["/usr/bin/gunicorn", "-b", "0.0.0.0:5000", "-w", "5", "server:app" ]

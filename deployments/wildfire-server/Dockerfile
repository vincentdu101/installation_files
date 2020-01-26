FROM python:3.6

RUN apt update -y

RUN apt install git -y
RUN apt install wget -y
RUN apt install vim -y
RUN apt install python3-pip -y
RUN apt install gunicorn -y
RUN apt install python3-flask -y
RUN apt install git-lfs -y
RUN git lfs install

RUN git clone https://github.com/vincentdu101/Wildfire-Analyzer-Predictor-System.git ./wildfire-server

WORKDIR wildfire-server/server

RUN git lfs pull

ENV APP_CONFIG="production"
ENV FLASK_APP="app.py"
ENV FLASK_RUN_PORT="8000"

RUN pip3 install virtualenv
RUN apt install virtualenv -y
RUN virtualenv -p python3 ./env
RUN . ./env/bin/activate
RUN pip install cython
RUN pip --no-cache-dir install -r ubuntu-requirements.txt

WORKDIR models
RUN wget https://s3-us-west-2.amazonaws.com/wildfire-analyzer-system/wildfires.sqlite
RUN chmod 644 wildfires.sqlite

WORKDIR ../
RUN pwd
EXPOSE 8000

CMD ["flask", "run", "--host", "0.0.0.0"]
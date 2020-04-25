FROM python:3.7-slim

RUN mkdir /configuration
COPY configuration/firebase_sdk_details.json /configuration/firebase_sdk_details.json
ENV GOOGLE_APPLICATION_CREDENTIALS /configuration/firebase_sdk_details.json

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY expenses_pb2_grpc.py .
COPY expenses_pb2.py .
COPY server.py .

EXPOSE 50051
CMD python server.py

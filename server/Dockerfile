FROM python:3.7-slim

COPY expenses_pb2_grpc.py .
COPY expenses_pb2.py .
COPY server.py .
COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 50051
CMD python server.py

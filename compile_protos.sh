python -m grpc_tools.protoc -I protos/ --python_out=server/ --grpc_python_out=server/ protos/expenses.proto

protoc --dart_out=grpc:ui\lib\proto-compiled -Iprotos protos\expenses.proto
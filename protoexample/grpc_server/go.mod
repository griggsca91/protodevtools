module github.com/griggsca91/protodevtools/protoexample/grpc_server

go 1.23.1

require (
	connectrpc.com/connect v1.16.2
	connectrpc.com/cors v0.1.0
	github.com/griggsca91/protodevtools/protoexample/gen/go v0.0.0-00010101000000-000000000000
	github.com/rs/cors v1.11.1
	golang.org/x/net v0.29.0
)

require (
	golang.org/x/text v0.18.0 // indirect
	google.golang.org/protobuf v1.34.2 // indirect
)

replace github.com/griggsca91/protodevtools/protoexample/gen/go => ../gen/go

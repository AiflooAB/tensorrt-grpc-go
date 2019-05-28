# TensorRT Inference Server Go gRPC client

## How to use

Download package using any package manager, ex:

`
dep ensure -add "github.com/AiflooAB/tensorrt-grpc-go/pkg/nvidia_inferenceserver"
`

or

`
go get -u "github.com/AiflooAB/tensorrt-grpc-go/pkg/nvidia_inferenceserver"
`

and add a package reference: 

`
import nv "github.com/AiflooAB/tensorrt-grpc-go/pkg/nvidia_inferenceserver"
`

## Codegen

To re-generate client, check TAG variable (current v1.2.0) in Makefile and run `make`
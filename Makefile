# Go parameters
APPLICATION=eventnative
#GOBUILD_CMD=GOOS=linux GOARCH=amd64 go build
export PATH := $(shell go env GOPATH)/bin:$(PATH)

all: clean assemble

assemble: backend js
	mkdir -p ./build/dist/web
	cp ./web/build/* ./build/dist/web/
	cp eventnative ./build/dist/

backend:
	echo "Using path $(PATH)"
	go mod tidy
	go get -u github.com/mailru/easyjson/...
	go generate
	go -o eventnative

js:
	npm i --prefix ./web && npm run build --prefix ./web

test_backend:
	go test ./...

clean:
	go clean
	rm -f $(APPLICATION)
	rm -rf ./web/build
	rm -rf ./build
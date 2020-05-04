package main

import (
	log "github.com/iworksdev/gologutil"
	"io/ioutil"
	"net/http"
)

func main() {
	http.HandleFunc("/",echo)
	log.Info("Server Running...","","")
	if err:=http.ListenAndServe(":7878",nil);err!=nil {
		log.Fatal("Server Error!","","")
	}
}

func echo(w http.ResponseWriter,r *http.Request) {
	body,_:=ioutil.ReadAll(r.Body)
	log.Info("Request","echo",string(body))
	w.Write(body)
}

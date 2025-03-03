package main

import (
	"fmt"
	"net"
	"os"
)

func handleConnection(conn net.Conn) {
	defer conn.Close()
	fmt.Println("Cliente conectado:", conn.RemoteAddr())

	// Enviar un mensaje al cliente
	message := "Hello, TCP Client!\n"
	conn.Write([]byte(message))
}

func main() {
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		fmt.Println("Error iniciando el servidor:", err)
		os.Exit(1)
	}
	defer listener.Close()
	fmt.Println("Servidor TCP escuchando en el puerto 8080...")

	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error aceptando conexión:", err)
			continue
		}
		go handleConnection(conn) // Manejar múltiples clientes concurrentemente
	}
}

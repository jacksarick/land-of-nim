import asyncnet, asyncdispatch

var clients {.threadvar.}: seq[AsyncSocket]

proc processClient(client: AsyncSocket) {.async.} =
  await client.send("Welcome user " & $find(clients, client) & "\c\L")

  while true:
    let line = await client.recvLine()
    if line.len == 0: break
    for c in clients:
      if c != client:
        await c.send($find(clients, client) & ": " & line & "\c\L")

proc serve() {.async.} =
  clients = @[]
  var server = newAsyncSocket()
  server.setSockOpt(OptReuseAddr, true)
  server.bindAddr(Port(12345))
  server.listen()
  
  while true:
    let client = await server.accept()
    clients.add client
    
    asyncCheck processClient(client)

asyncCheck serve()
runForever()
import asyncnet, asyncdispatch

var
  clients {.threadvar.}: seq[AsyncSocket]

proc processClient(client: AsyncSocket) {.async.} =
  if client in clients:
    await client.send("connected\c\L")

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
    if clients.len < 2:
      clients.add client
  
    asyncCheck processClient(client)

asyncCheck serve()
runForever()
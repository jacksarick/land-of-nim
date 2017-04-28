import asyncnet, asyncdispatch

type
  Stack = seq[string]

var
  clients {.threadvar.}: seq[AsyncSocket]
  instructions: Stack = @[]

proc processClient(client: AsyncSocket) {.async.} =
  await client.send("connected\c\L")

  while true:
    let line = await client.recvLine()
    if line.len == 0: break
       

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
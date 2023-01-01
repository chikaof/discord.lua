local socket = require "socket"

local discord = {}

-- Am i using the correct port? lol
discord.server = "discord.com"
discord.port = 443

discord.client = socket.tcp()


function discord:login(token)
  discord.token = token

  self.client:connect(self.server, self.port)

  self.client:send("POST /api/v8/gateway/bot HTTP/1.1\r\n")
  self.client:send("Content-Type: application/json\r\n")
  self.client:send("Content-Length: " .. tostring(#self.token) .. "\r\n")
  self.client:send("Authorization: Bot " .. tostring(self.token))

  local response = self.client:receive("*a")
  print(response .. "payload")
end

function discord:send_message(channel_id, message)
  local payload = [[{ "content": "]] .. message .. [[" }]]

  self.client:send("POST /api/v8/channels/" .. channel_id .. "/messages HTTP/1.1\r\n")
  self.client:send("Content-Type: application/json\r\n")
  self.client:send("Content-Length: " .. tostring(#payload) .. "\r\n")
  self.client:send("\r\n")
  self.client:send(payload) -- a la wea la auth :)

  local response = self.client:receive("*a")
  print(response)
end

function discord:logout()
  self.client.token = ""
  self.client:close()
end

return discord
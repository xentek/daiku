preload_app!
#on_restart do
  #Redis.current.client.reconnect
#end

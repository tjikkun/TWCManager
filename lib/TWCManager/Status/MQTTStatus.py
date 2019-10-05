# MQTT Status Output
# Publishes the provided key and value pair to the provided topic prefix

class MQTTStatus:

  import paho.mqtt.client as mqtt
  
  debugLevel    = 0
  status        = False
  serverIP      = None
  topicPrefix   = None
  
  def __init__(self, debugLevel, status, serverIP, topicPrefix):
    self.debugLevel  = debugLevel
    self.status      = status
    self.serverIP    = serverIP
    self.topicPrefix = topicPrefix
      
  def debugLog(self, minlevel, message):
    if (self.debugLevel >= minlevel):
      print("debugLog: (" + str(minlevel) + ") " + message)
      
  def setStatus(self, twcid, key, value):
    if (self.status):
      try:
        client = self.mqtt.Client("P1")
        client.connect(self.serverIP)
      except ConnectionRefusedError as e:
        self.debugLog(4, "Error connecting to MQTT Broker to publish topic values")
        self.debugLog(10, str(e))
        return False
      except OSError as e:
        self.debugLog(4, "Error connecting to MQTT Broker to publish topic values")
        self.debugLog(10, str(e))
        return False

      try:
        client.publish(self.topicPrefix+ "/" + str(twcid.decode("utf-8")) + "/" + key, payload=value)
      except e:
        self.debugLog(4, "Error publishing MQTT Topic Status")
        self.debugLog(10, str(e))
        return False

      client.disconnect()

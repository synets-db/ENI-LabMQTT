import paho.mqtt.client as mqtt
import time
import random

BROKER = "mqtt_broker"  # Nom du service Mosquitto dans Docker
PORT = 1883
TOPIC = "sensor/temperature"

# Simulateur de mesures (par exemple, température)
def simulate_temperature():
    return round(random.uniform(20.0, 30.0), 2)

def on_connect(client, userdata, flags, rc):
    print(f"Connected with result code {rc}")
    
# Configurer le client MQTT
client = mqtt.Client()
client.on_connect = on_connect
client.connect(BROKER, PORT, 60)

# Boucle pour publier des messages toutes les 5 secondes
while True:
    temperature = simulate_temperature()
    client.publish(TOPIC, f"Temperature: {temperature} °C")
    print(f"Published: Temperature: {temperature} °C")
    time.sleep(5)

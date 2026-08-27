#Filename: mqtt-client.py
#Author: Akshith Aluguri
#Description: Python script to run Raspberrypi as Client
#Reference: https://github.com/eclipse/paho.mqtt.python
#           https://github.com/cu-ecen-aeld/buildroot-assignments-base/blob/9648e6530170935479d6e8cd86a845a177529c0f/base_external/rootfs_overlay/bin/MQTT/Client-Publisher.py

#Importing Modules
import paho
import sys
import paho.mqtt.client as mqtt

Port = 1883
Keepalive = 60

try:
    # Client Constructor
    # Function Defination: https://github.com/eclipse/paho.mqtt.python#client-1
    client = mqtt.Client()

    # IP address of the remote broker accepting
    # from command line argument.
    String = sys.argv[-1]
    IP_Address = "10.0.0.82"

    # Connect to a remote broker.
    # Function defination: https://github.com/eclipse/paho.mqtt.python/blob/1eec03edf39128e461e6729694cf5d7c1959e5e4/src/paho/mqtt/client.py#L908
    try:
        client.connect(IP_Address, Port, Keepalive)

        # Publish a message on a topic.
        # This causes a message to be sent to the broker and subsequently from
        # the broker to any clients subscribing to matching topics.
        # Function defination: https://github.com/eclipse/paho.mqtt.python/blob/1eec03edf39128e461e6729694cf5d7c1959e5e4/src/paho/mqtt/client.py#L1199
        client.publish("topic/test", String)

    # Error Checking for script.
    except Exception as e:
        print(e)

except Exception as e:
    print(e)

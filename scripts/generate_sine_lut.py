import math

a = []

for i in range(256):
    angle = (2 * math.pi * i) / 256
    amplitude = round(32767 * math.sin(angle))
    a.append(amplitude)

with open("sine_lut.mem", "w") as file:
    for value in a:
        value_16bit = value & 0xFFFF
        file.write(f"{value_16bit:04X}\n")

print("sine_lut.mem generated successfully")
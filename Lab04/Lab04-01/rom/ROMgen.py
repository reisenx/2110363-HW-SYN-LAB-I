filename = "rom.mem"
file = open(filename, "w")
nums = []
for i in range(64):
    binary = (('0'*8) + (bin(i)[2:]))[-6:]
    nums.append(binary)
file.write(', '.join(nums))
file.close()
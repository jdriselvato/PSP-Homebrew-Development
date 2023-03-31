import struct
import os

# Open the EBOOT.PBP file and navigate to the PARAM.SFO file
with open('EBOOT.PBP', 'r+b') as f:
    f.seek(0x28)

    # Read the location and length of the PARAM.SFO file
    offset, size = struct.unpack('>II', f.read(8))

    # Navigate to the title field in the PARAM.SFO file
    f.seek(offset + 0x8A)

    # Write the new title to the title field
    new_title = b'New Boot Title'
    f.write(new_title)

# Print confirmation message
print('Boot title changed successfully!')

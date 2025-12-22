import binascii

def decrypt_chunk():
    # Hex string provided by user
    hex_chunk = "baf35b2f7e03757d6f0f29533327c637726d"
    
    # Key from the provided code
    key_bytes = [
        252, 181, 97, 105, 56, 57, 51, 59, 85, 73, 111, 105, 117, 97, 252, 113, 
        52, 109, 119, 48, 106, 117, 119, 108, 100, 105, 117, 64, 128, 114, 97, 102, 
        246, 115, 42, 220, 83, 77, 105, 101, 106, 119, 105, 102, 56, 101, 112, 119, 
        110, 102, 83, 107, 246, 111, 115, 59, 181, 44, 97
    ]

    # Convert hex to bytes
    chunk_bytes = bytearray(binascii.unhexlify(hex_chunk))
    
    decoded_bytes = bytearray()
    key_len = len(key_bytes)
    
    # Decrypt assuming it starts at index 0
    for i in range(len(chunk_bytes)):
        b = chunk_bytes[i]
        b2 = key_bytes[i % key_len]
        decoded_byte = b ^ b2
        decoded_bytes.append(decoded_byte)
        
    print(f"Hex Decoded: {binascii.hexlify(decoded_bytes).decode('utf-8')}")
    
    decoded_string = ""
    for b in decoded_bytes:
        if 32 <= b <= 126:
            decoded_string += chr(b)
        else:
            decoded_string += "."
            
    print(f"ASCII Dump: {decoded_string}")
    print(f"Raw string: {decoded_bytes.decode('utf-8', errors='ignore')}")

if __name__ == "__main__":
    decrypt_chunk()

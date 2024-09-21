import JSBI from "jsbi";



export class BufferReader {
    constructor(buffer) {
      this.buffer = buffer;
      this.offset = 0;
    }
  
    readVarInt() {
      const result = decodeVarint(this.buffer, this.offset);
      this.offset += result.length;
  
      return result.value;
    }
  
    readBuffer(length) {
      this.checkByte(length);
      const result = this.buffer.slice(this.offset, this.offset + length);
      this.offset += length;
  
      return result;
    }
  
    // gRPC has some additional header - remove it
    trySkipGrpcHeader() {
      const backupOffset = this.offset;
  
      if (this.buffer[this.offset] === 0 && this.leftBytes() >= 5) {
        this.offset++;
        const length = this.buffer.readInt32BE(this.offset);
        this.offset += 4;
  
        if (length > this.leftBytes()) {
          // Something is wrong, revert
          this.offset = backupOffset;
        }
      }
    }
  
    leftBytes() {
      return this.buffer.length - this.offset;
    }
  
    checkByte(length) {
      const bytesAvailable = this.leftBytes();
      if (length > bytesAvailable) {
        throw new Error(
          "Not enough bytes left. Requested: " +
          length +
          " left: " +
          bytesAvailable
        );
      }
    }
  
    checkpoint() {
      this.savedOffset = this.offset;
    }
  
    resetToCheckpoint() {
      this.offset = this.savedOffset;
    }
  }
  

  export function decodeVarint(buffer, offset) {
    let res = JSBI.BigInt(0);
    let shift = 0;
    let byte = 0;
  
    do {
      if (offset >= buffer.length) {
        throw new RangeError("Index out of bound decoding varint");
      }
  
      byte = buffer[offset++];
  
      const multiplier = JSBI.exponentiate(JSBI.BigInt(2), JSBI.BigInt(shift));
      const thisByteValue = JSBI.multiply(JSBI.BigInt(byte & 0x7f), multiplier);
      shift += 7;
      res = JSBI.add(res, thisByteValue);
    } while (byte >= 0x80);
  
    return {
      value: res,
      length: shift / 7
    };
  }
  
  
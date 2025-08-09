const express = require("express");
const app = express();
const cors = require("cors");
const secp = require("ethereum-cryptography/secp256k1");
const { toHex } = require("ethereum-cryptography/utils");
const { keccak256 } = require("ethereum-cryptography/keccak");
const { utf8ToBytes } = require("ethereum-cryptography/utils");
const port = 3042;

app.use(cors());
app.use(express.json());

// Generate 3 private/public key pairs
const privateKey1 = secp.utils.randomPrivateKey();
const publicKey1 = secp.getPublicKey(privateKey1);

const privateKey2 = secp.utils.randomPrivateKey();
const publicKey2 = secp.getPublicKey(privateKey2);

const privateKey3 = secp.utils.randomPrivateKey();
const publicKey3 = secp.getPublicKey(privateKey3);

// Replace fake addresses with real public keys
const balances = {
  [toHex(publicKey1)]: 100,
  [toHex(publicKey2)]: 50,
  [toHex(publicKey3)]: 75,
};

// Log the keys for testing purposes
console.log('Account 1 - Private Key:', toHex(privateKey1));
console.log('Account 1 - Public Key:', toHex(publicKey1));
console.log('Account 2 - Private Key:', toHex(privateKey2));
console.log('Account 2 - Public Key:', toHex(publicKey2));
console.log('Account 3 - Private Key:', toHex(privateKey3));
console.log('Account 3 - Public Key:', toHex(publicKey3));

app.get("/balance/:address", (req, res) => {
  const { address } = req.params;
  const balance = balances[address] || 0;
  res.send({ balance });
});

app.post("/send", (req, res) => {
  const { message, signature, recovery } = req.body;

  try {
    // Parse the message
    const { recipient, amount, nonce } = JSON.parse(message);
    
    // Hash the message
    const messageHash = keccak256(utf8ToBytes(message));
    
    // Recover the public key from the signature
    const recoveredPublicKey = secp.Signature.fromCompact(signature)
      .addRecoveryBit(recovery)
      .recoverPublicKey(messageHash);
    
    const sender = toHex(recoveredPublicKey);
    
    // Verify sender has sufficient balance
    setInitialBalance(sender);
    setInitialBalance(recipient);

    if (balances[sender] < amount) {
      res.status(400).send({ message: "Not enough funds!" });
    } else {
      balances[sender] -= amount;
      balances[recipient] += amount;
      res.send({ balance: balances[sender] });
    }
  } catch (error) {
    res.status(400).send({ message: "Invalid signature!" });
  }
});

app.listen(port, () => {
  console.log(`Listening on port ${port}!`);
});

function setInitialBalance(address) {
  if (!balances[address]) {
    balances[address] = 0;
  }
}
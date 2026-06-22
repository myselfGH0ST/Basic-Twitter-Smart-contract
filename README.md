# 🐦 Decentralized Twitter (dTwitter)
- A decentralized Twitter-like social media platform built on Ethereum using Solidity and smart contract architecture.
- Users can create profiles, post tweets ("Stweets"), and interact with other users through likes — all fully on-chain without any centralized control.
- This project demonstrates multi-contract design, interface-based communication, and real-world Web3 social application architecture.


## 🚀 Features

✅ User Profile Creation  
✅ Tweet Creation (280 character limit)  
✅ Like / Unlike Tweets  
✅ On-chain Data Storage  
✅ Access Control using Modifiers  
✅ Multi-contract Interaction (Interface)  
✅ Event Logging for Frontend Integration


## 🧠 Architecture

```text
User
  ↓
Profile Contract
  ↓ (validation)
Twitter Contract
  ↓
Mapping Storage (Tweets)
  ↓
Events → Frontend
```


## ⚠️ Limitations

- ❌ No prevention of duplicate likes by same user  
- ❌ Tweets stored fully on-chain (gas heavy)  
- ❌ No follow/follower system  
- ❌ No comment/reply system


## 🚀 Future Improvements

- 🔹 Follow / Followers system  
- 🔹 Comment / Reply functionality  
- 🔹 IPFS storage for tweet content  
- 🔹 NFT-based tweets  
- 🔹 Frontend integration (React + ethers)  
- 🔹 Gas optimizati


## 🔄 Workflow

```text
User creates profile
        ↓
User posts tweet
        ↓
Tweet stored in mapping
        ↓
Other users like/unlike
        ↓
Events emitted
        ↓
Frontend updates
```


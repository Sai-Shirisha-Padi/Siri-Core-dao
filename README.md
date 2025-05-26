# Decentralized Voting Smart Contract
A simple Ethereum-based voting system where an admin can register voters, create proposals, and initiate a voting session. Registered voters can vote on proposals in a transparent and immutable way.

📂 Features
🛡 Admin Controlled: Only the admin can register voters, create proposals, and start/end voting.
🗳 One Vote Per Voter: Each registered voter can vote only once per session.
📢 Real-Time Vote Tallying: Votes are instantly recorded and counted.
📜 Proposal Management: Admin can add multiple proposals for voters to choose from.
📈 Winning Proposal Retrieval: Automatically fetches the winning proposal when voting ends.

🧱 Smart Contract Details
* Contract Name: DecentralizedVoting
* Language: Solidity ^0.8.0
* Standard: Ethereum-compatible EVM
* License: MIT

🚀 How to Use
🧪 Deploy Locally (Remix or Hardhat)
1. Install MetaMask and connect to a testnet.
2. Compile and Deploy the contract (e.g., using Remix).

After deploying:

1. Call registerVoter() with each voter's wallet address.
2. Use createProposal() to add proposals.
3. Start the vote with startVoting().
4. Each registered voter calls vote(proposalId).
5. End voting with endVoting().

⚠️ Security Notes
* This contract does not support anonymous voting.
* Voting is public and traceable on-chain.
* No time-based session handling; admin manually controls voting periods.

✅ To Do / Improvements
* Token-based voting support (ERC-20).
* Timelocks for proposals.
* Role-based access using OpenZeppelin's AccessControl.
* Chainlink VRF integration for random proposal ordering.


  # Contract Details:
  0x373bbab85119b7223f6e65d0478f152387842937ce388c2cb5c0d98096494ed3

  ![image](https://github.com/user-attachments/assets/a1e3e19c-30b9-4576-8eff-f3457328f9cf)

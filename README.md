- Verified Scroll Sepolia Contract: [0x698170b76f32eab533352ec5eac670a116f43a77](https://sepolia.scrollscan.com/address/0x698170b76f32eab533352ec5eac670a116f43a77#code)

# Introduction

Ethin, Easy Thin. A Blockchain-Based Smart Weight Management App

Ethin is a weight management app deployed on Ethereum and its Layer 2 solutions. It is designed to help users easily track their weight, manage their health, and stay motivated through a rewards system. Users can log their weight daily and earn points by checking in or completing tasks, and they can participate in global rankings.

# Challenges I Ran Into

During the limited time available, I faced the challenge of integrating various functionalities while also learning new concepts, including:

- **ENS Subname**: Although I started exploring this, I had to abandon it due to time constraints.
- **Scroll L1SLOAD**: This seemed like a great solution for multi-chain support, but again, time was insufficient to implement it.
- **Scroll Chain and Contract Verification**: I spent time learning how to work with the Scroll chain and how to verify contracts on it.
- **ENS Resolving**: The official tutorial was in React, but my tech stack was Vue. So, I built a small custom solution using Viem to resolve names.
- **Autonomous World Framework (MUD)**: This was mentioned in the Scroll challenge, and it looked very interesting. I tried to learn it, but there wasn’t enough time to implement it.

# Technologies I Used

- **Vue.js 3**
- **Quasar** - UI Framework
- **Circom** - Compiling circuits
- **Snarkjs** - Generating vkey and exporting Solidity contracts
- **Solidity** - Writing smart contracts
- **TypeChain** - Generating types from contracts
- **Circomlib** - Reusable library for circuit writing, specifically using the MiMC circuit
- **Circomlibjs** - Reusable library to calculate MiMC in JavaScript code
- **Ethers.js** - Interacting with the Scroll chain

# How We Built It

During the design phase, we carefully reviewed all the sponsors' tech stacks and brainstormed ideas. After finalizing the design, we split the tasks, working separately on coding and presentation.

During implementation:

- We first decided on the overall framework and created a work breakdown structure, which we used ChatGPT to help bootstrap the initial code.
- We structured the project using a monorepo approach, integrating UI, circuits, and contracts. ChatGPT was also utilized to generate bootstrap code for our UI and contracts.
- Then, we focused on implementing the specific functionalities, ensuring the code was correct.
- A significant part of the work was making sure these different components worked together seamlessly.

# What We Learned

We learned a lot, as mentioned in the challenges section. Additionally, we mistakenly thought the submission deadline was at 11:59AM on the last day because the guidelines page indicated so. It wasn't until the organizers sent an email at 6 AM that we realized the deadline was approaching than early. This misunderstanding disrupted our time planning, and unfortunately, we couldn't complete some features we thought we would. In hindsight, we should have confirmed the final deadline with the organizers earlier.

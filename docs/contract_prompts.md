我需要用简单的 solidity 编写一个基本的合约。代码中无论注释还是输出都使用英文。

**代码需求：**

1. 请尽量使用标准的实现

**功能（函数）需求：**

- get_tasks()
  - get tasks from L1 through L1SLOAD pre-compile
- verify_task(pubkey, proof)
  - constructor accept a verifier contract as parameter
  - and use that verifier here to verify the proof
- create_account(pubkey, height_commitment)
  - store height_commitment to a map with key pubkey
- submit_daily(pubkey, commitment)
  - store the (weight\_)commitment to a map with key pubkey and date number(in day)
  - each day only accept one submission
- get_daily_data(pubkey): (commitment, timestamp)[]
  - get the daily (weight\_)commitment from map by the key pubkey

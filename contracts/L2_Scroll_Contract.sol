// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for the verifier contract
interface IVerifier {
  function verifyProof(
    uint[2] calldata _pA,
    uint[2][2] calldata _pB,
    uint[2] calldata _pC,
    uint[12] calldata _pubSignals
  ) external view returns (bool);
}

contract L2Contract {
  struct Task {
    string name;
    string rule;
    uint deadline;
  }

  mapping(uint => Task) private tasks;
  uint private taskCounter;

  address public verifierContract;
  mapping(uint => uint) public heightCommitments;
  mapping(uint => mapping(uint => uint)) public dailyCommitments;
  mapping(uint => uint[]) public submissionTimestamps;

  constructor(address _verifierContract) {
    verifierContract = _verifierContract;
  }

  function publish_task(
    string memory name,
    string memory rule,
    uint deadline
  ) public {
    tasks[taskCounter] = Task(name, rule, deadline);
    taskCounter++;
  }

  function get_tasks() public view returns (Task[] memory) {
    Task[] memory taskList = new Task[](taskCounter);
    for (uint i = 0; i < taskCounter; i++) {
      taskList[i] = tasks[i];
    }
    return taskList;
  }

  // function get_tasks() public view returns (uint[] memory) {
  //   uint[] memory tasks;

  //   // address L1_SLOAD_ADDRESS = 0x101;
  //   //  (bool success, bytes memory ret) =L1_SLOAD_ADDRESS.staticcall(
  //   // abi.encodePacked( llAddress, keyl, key2));
  //   // if (!success) {
  //   // revert( "LISLOAD failed" );
  //   // }
  //   // return abi.decode( ret, (uint256, uint256));

  //   return tasks;
  // }

  function verify_task(
    uint pubkey,
    uint[2] calldata _pA,
    uint[2][2] calldata _pB,
    uint[2] calldata _pC
  ) public view returns (bool) {
    IVerifier verifier = IVerifier(verifierContract);
    uint dayNumber = block.timestamp / 1 days;
    uint[12] memory commitments;
    commitments[0] = pubkey;
    commitments[1] = heightCommitments[pubkey];
    for (uint i = 0; i < 10; i++) {
      commitments[i + 2] = dailyCommitments[pubkey][dayNumber];
    }
    return verifier.verifyProof(_pA, _pB, _pC, commitments);
  }

  function create_account(uint pubkey, uint height_commitment) public {
    require(heightCommitments[pubkey] == 0, 'Account already exists');
    heightCommitments[pubkey] = height_commitment;
  }

  function submit_daily(uint pubkey, uint commitment) public {
    uint dayNumber = block.timestamp / 1 days;
    require(
      dailyCommitments[pubkey][dayNumber] == 0,
      'Submission for today already exists'
    );
    dailyCommitments[pubkey][dayNumber] = commitment;
    submissionTimestamps[pubkey].push(dayNumber);
  }

  function get_daily_data(
    uint pubkey
  ) public view returns (uint[] memory commitments, uint[] memory dates) {
    uint length = submissionTimestamps[pubkey].length;
    commitments = new uint[](length);
    dates = new uint[](length);

    for (uint i = 0; i < length; i++) {
      uint dayNumber = submissionTimestamps[pubkey][i];
      commitments[i] = dailyCommitments[pubkey][dayNumber];
      dates[i] = dayNumber;
    }
  }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for the verifier contract
interface IVerifier {
  function verifyProof(
    bytes memory proof,
    bytes32[] memory publics
  ) external view returns (bool);
}

contract L2Contract {
  struct Task {
    string name;
    string rule;
    uint256 deadline;
  }

  mapping(uint256 => Task) private tasks;
  uint256 private taskCounter;

  address public verifierContract;
  mapping(bytes32 => bytes32) public heightCommitments;
  mapping(bytes32 => mapping(uint256 => bytes32)) public dailyCommitments;
  mapping(bytes32 => uint256[]) public submissionTimestamps;

  constructor(address _verifierContract) {
    verifierContract = _verifierContract;
  }

  function publish_task(
    string memory name,
    string memory rule,
    uint256 deadline
  ) public {
    tasks[taskCounter] = Task(name, rule, deadline);
    taskCounter++;
  }

  function get_tasks() public view returns (Task[] memory) {
    Task[] memory taskList = new Task[](taskCounter);
    for (uint256 i = 0; i < taskCounter; i++) {
      taskList[i] = tasks[i];
    }
    return taskList;
  }

  // function get_tasks() public view returns (bytes32[] memory) {
  //   bytes32[] memory tasks;

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
    bytes32 pubkey,
    bytes memory proof
  ) public view returns (bool) {
    IVerifier verifier = IVerifier(verifierContract);
    uint256 dayNumber = block.timestamp / 1 days;
    bytes32[] memory commitments = new bytes32[](30);
    for (uint256 i = 0; i < 30; i++) {
      commitments[i] = dailyCommitments[pubkey][dayNumber];
    }
    return verifier.verifyProof(proof, commitments);
  }

  function create_account(bytes32 pubkey, bytes32 height_commitment) public {
    require(heightCommitments[pubkey] == 0, 'Account already exists');
    heightCommitments[pubkey] = height_commitment;
  }

  function submit_daily(bytes32 pubkey, bytes32 commitment) public {
    uint256 dayNumber = block.timestamp / 1 days;
    require(
      dailyCommitments[pubkey][dayNumber] == 0,
      'Submission for today already exists'
    );
    dailyCommitments[pubkey][dayNumber] = commitment;
    submissionTimestamps[pubkey].push(dayNumber);
  }

  function get_daily_data(
    bytes32 pubkey
  ) public view returns (bytes32[] memory commitments, uint256[] memory dates) {
    uint256 length = submissionTimestamps[pubkey].length;
    commitments = new bytes32[](length);
    dates = new uint256[](length);

    for (uint256 i = 0; i < length; i++) {
      uint256 dayNumber = submissionTimestamps[pubkey][i];
      commitments[i] = dailyCommitments[pubkey][dayNumber];
      dates[i] = dayNumber;
    }
  }
}

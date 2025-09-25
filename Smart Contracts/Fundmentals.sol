// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleContract {

    // Declare the event
    event MessageUpdated(string _oldMessage, string _newMessage);

    // This state variable stores the address of the contract owner.
    address public owner;
    string public message;

    // The constructor sets the owner and initial message when the contract is deployed.
    constructor(string memory initialMessage) {
        owner = msg.sender;
        message = initialMessage;
    }

    // A view function to get the current message.
    function getMessage() public view returns (string memory) {
        return message;
    }

    // A setter function to update the message, with access control and an event.
    function updateMessage(string memory _newMessage) public {
        // Step 1: The gatekeeper. Only the owner can call this function.
        require(msg.sender == owner, "You are not the owner!");

        // Step 2: Save the old message to a temporary variable before we change it.
        string memory oldMessage = message;

        // Step 3: Update the state variable with the new message.
        message = _newMessage;

        // Step 4: Emit the event to the blockchain log.
        emit MessageUpdated(oldMessage, _newMessage);
    }

    mapping(address => uint256) public balances;

    struct User {
    address account;
    uint256 balance;
}

mapping(address=> User) public users

function addUser() public {
    // Check if the user already exists in the mapping.
    require(users[msg.sender].account == address(0), "User already exists.");

    // Create a new User struct and fill its fields.
    users[msg.sender] = User({
        account: msg.sender,
        balance: 1000
    });
}

function getBalance(address _user) public view returns (uint256) {
    return balances[_user];
}

function setBalance(address _user) public returns (uint256) {
    balnces[_user] = 1000
}

function transfer(address _recipient, uint256 _amount) public {
        // The sender must have enough funds.
        require(balances[msg.sender] >= _amount, "Insufficient balance.");

        // The sender's balance is decremented.
        balances[msg.sender] -= _amount;

        // The recipient's balance is incremented.
        balances[_recipient] += _amount;
    }
}
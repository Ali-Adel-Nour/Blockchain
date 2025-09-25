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
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 public myfavoriteNumber; // default 0

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listofPeoples;

    mapping(string => uint256) public nameToFavoriteNumber;

    function addPerson(string memory name, uint256 _favoriteNumber) public {
        listofPeoples.push(Person({favoriteNumber: _favoriteNumber, name: name}));
        nameToFavoriteNumber[name] = _favoriteNumber;
    }

    function store(uint256 _favoriteNumber) public virtual { // Marked as virtual
        myfavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return myfavoriteNumber;
    }
}
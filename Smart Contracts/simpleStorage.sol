pragma solidity 0.8.19;

contract SimpleStroage  {

    uint256 public favoriteNumber; //default 0

    function store (uint256 _favoriteNumber) public {
      favoriteNumber = _favoriteNumber;
    }

//there is two types view-> this for return the state without editing it
// pure adding the state like the store
   function retreive () public view returns (uint256) {
        return favoriteNumber;
    }

}
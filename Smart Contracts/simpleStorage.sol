pragma solidity 0.8.19;

contract SimpleStroage  {

    uint256 public myfavoriteNumber; //default 0

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

 Person [] public listofPeoples; 

 function addPerson(string memory name, uint256 _favoriteNumber) public {

   listofPeoples.push(Person({favoriteNumber: _favoriteNumber, name: name}));

 }

   // Person public pat  = Person(2, "Pat"); // good 

  //  Person public pat  = Person({favoriteNumber:7, name: "Pat"}); // Best Practice

    function store (uint256 _favoriteNumber) public {
      myfavoriteNumber = _favoriteNumber;
    }

//there is two types view-> this for return the state without editing it
// pure adding the state like the store
   function retreive () public view returns (uint256) {
        return myfavoriteNumber;
    }

}
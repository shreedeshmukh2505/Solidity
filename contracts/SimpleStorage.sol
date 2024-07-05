// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/*  Notes:
    Types of variables boolean, int, uint,strings, address;
    Visibility of variable is set to internal by default 
    For favNumber we have set it to public 
    Once it is set to public a getter function for that variable is automatically created, which returns the value of the variable which we have created.

    view,pure function doesn't spend gas when called alone.
    If a gas spending function(eg. store function) is calling a pure or view function then only it will cost gas.

2.Struct and Array:

    We have created struct People and stored two variables in it and then we have tried to create a variable person and stored those 2 variables's values in that person variable(This is not correct understanding just remember it).
    But if we want to store multiple persons then this method becomes inefficient
    Eg. People public person0 = People({favNumber: 25, name: "Anurag"});
        People public person1 = People({favNumber: 6, name: "Akanksha"});
        People public person2 = People({favNumber: 01, name: "Pratik"});
    This is inefficient method instead we use an Array
    uint256[] public favNumberList(This is a array of uint256 datatype)

3.Basic Solidity Memory, Storage, Calldata:

    There are 3 types of variable(Well actually 6) calldata,memory,storage
    Calldata is a temporary variable that can't be modified
    Memory is a temporary variable that can be modified 
    Storage is permanent variable that can be modified

4.Basics of Mapping:
    A mapping is a data Structure where a key is mapped to a single value
    Consider it like a Dictionary.

                            **LESSON 3**
The ability of contracts to seamlessly interact with each other is called as Composability.

For inheritance we use "is" keyword (like we use extends in java).
For a function to be overriden the parent funtion must be a virtual funtion otherwise it cannot be overriden.
Also we need to specify which function we are overriding by adding override keyword in child class/contract.
*/

contract SimpleStorage {
    uint256 favNumber; //By default the value of favNumber is set to 0
    address myAddress = 0xf7Bce9956d430DA3C503d512062eEFE1B99BCbFF;
    //People public person = People({favNumber: 25, name: "Anurag"});
    struct People {
        uint256 favNumber;
        string name;
    }
    People[] public person;//People refers to Struct and person refers to Array

    mapping (string => uint256) public nameToFavouriteNumber;

    function store(uint256 _favNum) public virtual {
        favNumber = _favNum;
    }

    function retrieve() public view returns (uint256) {
        return favNumber;
    }

    function addPerson(string memory _name,uint256 _favNumber) public {
        People memory newPerson=People(_favNumber,_name);
        person.push(newPerson);
        nameToFavouriteNumber[_name]=_favNumber;

    }
    //Smart contract address -> 0xd9145CCE52D386f254917e481eB44e9943F39138
}

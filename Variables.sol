pragma solidity ^0.7.0;

contract WorkingWithVariables {
    uint256 public myUint; //256 bits form 0 to 65556?
    bool public myBool;
    uint8 public myUint8; //only goes from 0 to 255 (8 bits)
    address public myAddress;
    string public myString = 'Hello world';
    
    function setMyUint(uint _myValue) public {
        myUint = _myValue;
    }
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    function incrementUint8() public {
        myUint8++;
    }
    
    function decremenetUint8() public {
        myUint8--;
    }
    
    //function decremenetUint256() public {
    //    myUint--;
    //}
    
    function setAddress(address _address) public {
        myAddress = _address ;
    }
    
    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }
    
    function setMyString(string memory _input) public {
        myString = _input;
    }
    
    function getMyString() public view returns(string memory) {
        return myString;
    }
}

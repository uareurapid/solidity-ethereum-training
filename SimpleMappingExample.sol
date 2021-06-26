pragma solidity ^0.7.0;

contract SimpleMappingExample {
    
    mapping( uint => bool ) public myMapping;
    
    mapping(address => bool) public myAddressMapping;
    
    
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
    function setKeyValue(uint _key, bool _value) public {
        myMapping[_key] = _value;
    }
    
    function getBoolForKey(uint _key) public view returns(bool) {
        return myMapping[_key];
    }
}
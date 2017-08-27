pragma solidity ^0.4.13;

contract SafeMath {
  //internals

  function safeMul(uint a, uint b) internal returns (uint) {
    uint c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function safeSub(uint a, uint b) internal returns (uint) {
    assert(b <= a);
    return a - b;
  }

  function safeAdd(uint a, uint b) internal returns (uint) {
    uint c = a + b;
    assert(c>=a && c>=b);
    return c;
  }

  function assert(bool assertion) internal {
    if (!assertion) throw;
  }
}

contract WeGotta {
    string public name; 
    string public symbol; 
    uint8 public decimals;
    uint256 public totalSupply;
    
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    function WeGotta(uint256 initialSupply) {
      name = "WeGotta"
      symbol = "WGT"
      decimals = 8; 
      balanceOf[msg.sender] = initialSupply;  /*set to be anywhere between 15 to 50 million as of right now it gives the creator all initial tokens */
      
  } 
   /* Send coins */
      function transfer(address _to, uint256 _value) {
          
          /*Check if sender has balance and for overflow */
          require(balanceOf[msg.sender] >= _value && balanceOf[-to] + _value >= balanceOf[_to]);
          
          /* Add and subtract new balances */
          balanceOf[msg.sender] -= _value;
          balanceOf[_to] += _value;
          
      }
     
}

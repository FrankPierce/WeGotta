pragma solidity ^0.4.13;

contract tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }

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

contract WeGotta{
    string public name; 
    string public symbol; 
    uint8 public decimals;
    uint256 public totalSupply;
    address public owner;
    
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    /* This notifies clients about the amount burnt */
    event Burn(address indexed from, uint256 value);
   
   /* Initializes contract with initial supply tokens to the creator of the contract */
    function WeGottaToken is StandardToken, SafeMath {
      name = "WeGotta";
      symbol = "WGT";
      decimals = 8;
      balanceOf[msg.sender] = 50000000; /*Set initial supply to 50 million*/
      totalSupply = 50000000;
   } 
   
   /* Internal transfer, only can be called by this contract */
    function _transfer(address _from, address _to, uint _value) internal {
      require (_to != 0x0);                               // Prevent transfer to 0x0 address. Use burn() instead
      require (balanceOf[_from] > _value);                // Check if the sender has enough
      require (balanceOf[_to] + _value > balanceOf[_to]); // Check for overflows
      require(!frozenAccount[_from]);                     // Check if sender is frozen
      require(!frozenAccount[_to]);                       // Check if recipient is frozen
      balanceOf[_from] -= _value;                         // Subtract from the sender
      balanceOf[_to] += _value;                           // Add the same to the recipient
      Transfer(_from, _to, _value);
   }  
   
   function transfer(address _to, uint256 _value) {
      _transfer(msg.sender, _to, _value)
   }
   
   /* Allow another contract or person to spend some tokens in your behalf */
   function approve(address _spender, uint256 _value)
      returns (bool success) {
      allowance[msg.sender][_spender] = _value;
      return true;
   }
   
   /* A contract or  person attempts to get the tokens of somebody else.
    *  This is only allowed if the token holder approved. */
   function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
      require (_value < allowance[_from][msg.sender]);       // Check allowance
      allowance[_from][msg.sender] -= _value;
      _transfer(_from, _to, _value);
      return true;
   }
   
   function burn(uint256 _value) returns (bool success) {
      require (balanceOf[msg.sender] > _value);             //  Check if the sender has enough
      balanceOf[msg.sender] -= _value;                      // Subtract from the sender
      totalSupply -= _value;                                // Updates totalSupply
      Burn(msg.sender, _value);
      return true;
  }
}

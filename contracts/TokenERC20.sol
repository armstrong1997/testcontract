pragma solidity ^0.4.4;

contract TokenERC20 {
  // Public variables of the token
  string public name;
  string public symbol;
  uint8 public decimals = 8;
  // 18 decimals is the strongly suggested default, avoid changing it
  uint256 public totalSupply;

  // This creates an array with all balanceOf
  mapping(address => uint256) public balanceOf;
  mapping(address => mapping(address => uint256)) public allowed;
 
  /**
   * Constrctor function
   *
   * Initializes contract with initial supply tokens to the creator of the contract
   */

  function TokenERC20() public {
    totalSupply = 100000000 * 10 ** uint256(decimals); // Update total supply with the decimal amount
    name = "rimule"; // Set the name for display purposes
    symbol = "Rim"; // Set the symbol for display purposes
  }

     function transfer(address _to, uint256 _value) returns (bool success) {
        if (balanceOf[msg.sender] >= _value) {
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[_from] >= _value && allowed[_from][msg.sender] >= _value) {
            balanceOf[_to] += _value;
            balanceOf[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    //function approveAndCall()

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balanceOf[_owner];
    }

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}

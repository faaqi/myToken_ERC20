// SPDX-License-Identifier: TLB
pragma solidity >=0.7.0 <0.9.0;

contract MyToken {
    
    uint256 public totalSupply = 1000000 * 10 ** 18;
    string public name = "MyToken";
    string public symbol = "MTK";
    uint public decimals = 18;
    
    mapping(address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowances;
    
    event Transfer(address indexed from,address indexed to,uint val);
    event Approval(address indexed owner,address indexed spender,uint val);
    
    constructor() {
        balances[msg.sender] = totalSupply;
    }
    
    function balanceOf (address val) public view returns (uint) {
        return balances[val];
    }
    
    function transfer(address to,uint val) external returns (bool){
        require (balances[msg.sender] >= val, "Balance too low");
        balances[to]+=val;
        balances[msg.sender]-=val;
        emit Transfer(msg.sender,to,val);
        return true;
    }
    
    function approve (address spender,uint val) public returns (bool){
        allowances[msg.sender][spender] = val;
        emit Approval(msg.sender,spender,val);
        return true;
    }
    
    function transferFrom (address from,address to,uint val) public returns (bool) {
        require (balances[from] >= val,"Balance too low");
        require (allowances[from][msg.sender] >= val, "allowance too low");
        balances[from] -= val;
        balances[to] += val;
        allowances[from][msg.sender] -=val;
        emit Transfer(from,to,val);
        return true;
    }
}
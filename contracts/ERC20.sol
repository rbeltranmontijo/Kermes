// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "./SafeMath.sol";


//Interface de token ERC20
interface IERC20{
    //Devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns (uint256);

    //Devuelve la cantidad de rokens para una dirección indicada por parámetro
    function balanceOf(address account) external view returns (uint256);

    //Devuelve un valor booleano resultado de la operación indicada
    function transfer(address recipient, uint256 amount) external returns (bool);

    function transferToSmartContract(address cliente, address recipient, uint256 amount) external returns (bool);

}

//Implementación de las funciones del token ERC20
contract ERC20Basic is IERC20{

    string public constant name = "ERC20Robin";
    string public constant symbol = "ERC-RBN";
    uint8 public constant decimals = 18;

    event TransferEvent(address indexed from, address indexed to, uint256 tokens);

    using SafeMath for uint256;

    mapping (address => uint) balances;
    uint256 totalSupply_;

    constructor (uint256 initialSupply)  {
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }


    function totalSupply() public override view returns (uint256){
        return totalSupply_;
    }

    function increaseTotalSupply(uint newTokensAmount) public {
        totalSupply_ += newTokensAmount;
        balances[msg.sender] += newTokensAmount;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner];
    }

    function transfer(address recipient, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[recipient] = balances[recipient].add(numTokens);
        emit TransferEvent(msg.sender, recipient, numTokens);
        return true;
    }
    function transferToSmartContract(address _cliente, address recipient, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[_cliente]);
        balances[_cliente] = balances[_cliente].sub(numTokens);
        balances[recipient] = balances[recipient].add(numTokens);
        emit TransferEvent(_cliente, recipient, numTokens);
        return true;
    }
}
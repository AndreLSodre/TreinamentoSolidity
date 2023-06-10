// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Venda {

    string public nomeVendedor;
    uint256 public bonusFator;

    constructor(string memory vendedor, uint256 fator) {
        nomeVendedor = vendedor;
        bonusFator = fator;
    }

   function calcularBonus( uint256 valorVenda) 
        public view returns ( uint256 retornoValor) 
    {
        retornoValor = (valorVenda*bonusFator);
        return retornoValor;
    }

}

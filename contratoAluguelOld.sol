// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 0x8BDAB64e4b9EF5e6592CBa6d1Cb0c5DA05be6727

contract ContratoAluguel {

    string public locator;
    string public locatario;
    uint256[] public valorAluguel;

    constructor(string memory _locator, string memory _locatario,uint valorInicial) {
        locator = _locator;
        locatario = _locatario;
        for(uint i = 0 ; i < 36; i ++){
            addToArray(valorInicial);
        }
    }

    function addToArray(uint256 newItem) private {
        valorAluguel.push(newItem);
    }

    function reajustarParcelas(uint256  mes) public returns (bool) {
        for (mes; mes < valorAluguel.length; mes ++) {
            addToParcelaArray(mes);
        }
        return true;
    }

    function addToParcelaArray(uint256 mes) private {
        uint val = valorAluguel[mes];
        valorAluguel[mes] = (val+100);
    }

    function retornaParcelaMes(uint256 mes) public view returns (uint) {
        uint256 valor = valorAluguel[mes];
        return valor; 
    }

    function retornaNomeLocatorOuLocatario (uint256 tipo) public view returns (string memory nome) {
        if (tipo==1) {
            nome = locator;
            return nome;
        } else if (tipo == 2) {
            nome = locatario;
            return nome;
        } else {
            nome = "tipo invalido";
            return nome;
        }
        
    }

}

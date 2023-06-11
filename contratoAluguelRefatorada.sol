// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 0x106e27f1c168E8A354E51d85B3149d34c5FA2418

contract ContratoAluguel {

    mapping(uint => Contrato) public contratos;
    uint256 public totalDeContrato;

    struct Contrato {
        uint numeroContrato;
        string locator;
        string locatario;
        uint256[] valorAluguel;
    }

    modifier somenteContrato( string memory _locator, string memory _locatario, uint256 _valorParcela) {
        require(bytes(_locator).length > 0, "Insira o nome do Locador");
        require(bytes(_locatario).length > 0, "Insira o nome do Locatario");
        require(_valorParcela > 0, "Insira um valor valido na parcela");
        _;
    }

    modifier validarMes(uint _mes) {
        require(_mes > 0, "valor da parcela deve ser entre 1 e 36");
        require(_mes < 37, "valor da parcela deve ser entre 1 e 36");
        _;
    }

    modifier validarNumContrato(uint _numeroContrato) {
        require(_numeroContrato > 0, "numero do contrato invalido");
        require(_numeroContrato <= totalDeContrato, "numero do contrato invalido");
        _;
    }

    constructor(string memory _locator, string memory _locatario, uint256 _valorParcela) 
        somenteContrato(_locator, _locatario, _valorParcela) {
        uint256[] memory parcelas = addParcelas(
            _valorParcela
        );
        totalDeContrato++;
        Contrato memory novoContrato = Contrato(totalDeContrato,_locator, _locatario, parcelas);
        contratos[totalDeContrato] = novoContrato;
    }

    function incluirContrato(string memory _locator, string memory _locatario, uint256 _valorParcela) 
        public somenteContrato(_locator, _locatario, _valorParcela)
        returns (bool) {
        uint256[] memory parcelas = addParcelas(
            _valorParcela
        );
        totalDeContrato++;
        Contrato memory novoContrato = Contrato(totalDeContrato, _locator, _locatario, parcelas);
        contratos[totalDeContrato] = novoContrato;

        return true;
    }

    function addParcelas(uint256 valor)
        private pure returns (uint256[] memory parcelas)
    {
        uint numParcela = 36;
        uint256[] memory _valorAluguel = new uint256[](numParcela);
        for (uint256 i = 0; i < numParcela; i++) {
            _valorAluguel[i] = valor;
        }
        return _valorAluguel;
    }

    function reajustarParcelas(uint256 mes, uint _numeroContrato) public validarMes(mes) validarNumContrato(_numeroContrato) returns (bool) {
        uint count = contratos[_numeroContrato].valorAluguel.length;
        for (mes; mes < count; mes++) {
            uint valor = contratos[_numeroContrato].valorAluguel[mes];
            contratos[_numeroContrato].valorAluguel[mes] = (valor + 100);
        }
        return true;
    }

    function retornaParcelaMes(uint256 mes, uint _numeroContrato) public validarMes(mes) validarNumContrato(_numeroContrato) view returns (uint256) {
        uint256 valor = contratos[_numeroContrato].valorAluguel[mes];
        return valor;
    }

    function retornaNomeLocatorOuLocatario(uint256 tipo, string memory nome, uint _numeroContrato)
        public
        validarNumContrato(_numeroContrato)
        returns (string memory)
    {
        require(bytes(nome).length > 0, "Insira o nome do Locatario");
        require(tipo !=1 && tipo !=2 , "tipo invalido digiti 1 para Locator e 2 para Locatario");
        if (tipo == 1) {
            contratos[_numeroContrato].locator = nome;
            return contratos[_numeroContrato].locator;
        } else if (tipo == 2) {
            contratos[_numeroContrato].locatario = nome;
            return contratos[_numeroContrato].locatario;
        } else {
            return "numero do contrato invalido";
        }
    }

    function nomeLocatorLocatario(uint _numeroContrato)
        public
        validarNumContrato(_numeroContrato)
        view
        returns (string memory, string memory)
    {
        return (contratos[_numeroContrato].locator, contratos[_numeroContrato].locatario);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Colegio {
    // Declaramos variables 
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => mapping (uint => uint)) private notas_materia;
    string[] private _nom_materias;
    uint[] private _bimestres;
    address[] private _docentes_autorizados;

    //Creamos constructor
    constructor(string memory nombre_, string memory apellido_, string memory curso_) {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

    //Creamos Deposit
    event Deposit(address indexed _from, string _materia, uint _nota);

    //Funcion para poder confirmar este evento
    function deposit(string memory _materia, uint _nota) public payable {      
        emit Deposit(msg.sender, _materia, _nota);
    }

    //Devuelve el apellido del alumno
    function apellido() public view returns (string memory) {
        return _apellido;
    }

    // Append-eamos el nombre completo, y lo devuelve
    function AppendString(string memory a, string memory b, string memory c) public pure returns (string memory) {
        return string(abi.encodePacked(a,b,c));
    }

    //Agrega la address del docente al array de docentes autorizados
    function agregarDocente(address _address_docente) public {
        require(docenteAuth(_address_docente) == false, "El docente ya esta autorizado");
        _docentes_autorizados.push(_address_docente);
    }
    
    //True si la address esta en el array de autorizados, si no, devuelve false
    function docenteAuth(address _address_docente) public view returns (bool){
        uint _cantItems = _docentes_autorizados.length;
        bool isin = false;

        for (uint i = 0; i < _cantItems; i++){
            if (_docentes_autorizados[i] == _address_docente){
                isin = true;
            }
        }

        return isin;
    }

    //Devuelve el nombre completo del alumno
    function nombre_completo() public view returns (string memory) {
        return AppendString(_nombre, " ", _apellido);
    }

    //Devuelve el curso del alumno
    function curso() public view returns (string memory) {
        return _curso;
    }

    //Le permite AL DOCENTE poner la nota a una materia
    function set_nota_materia(uint _nota, string memory _materia, uint _bimestre) public {
        
        require(_docente == msg.sender || docenteAuth(msg.sender) == true, "No estas autorizado a cambiar tu propia nota.");
        require(_nota <= 100 && _nota >= 1, "No es una nota valida");
        require(_bimestre < 5, "No es un numero valido para bimestre");
        require(_bimestre > 0, "No es un numero valido para bimestre");
        notas_materia[_materia][_bimestre] = _nota;
        _nom_materias.push(_materia);
        _bimestres.push(_bimestre);

        deposit(_materia, _nota);
    }

    //Devuelve la nota dependiendo de la materia
    function nota_materia(string memory _materia, uint _bimestre) public view returns (uint) {
        
        
        uint _nota = notas_materia[_materia][_bimestre];   
        return _nota;
        
    }
    
    //Se fija si la nota de una cierta materia es mayor o igual a 60, devuelve true o false
    function aprobo(string memory _materia, uint _bimestre) public view returns (bool) {
        
        if (notas_materia[_materia] >= 60){
            return true;
        } else {
            return false;
        }
       
    }

    //Ejecuta un FOR una cantidad de veces igual a la cantidad de registros en el mapping/array, asi que lo recorre todo. 
    //Agarra la nota correspondiente y la suma a _notaParaPromedio y despues lo divide por la cantidad de registros en el mapping/array.
    function promedio() public view returns (uint) {

        uint _cantItems = _nom_materias.length;
        uint _notaParaPromedio;
        uint _notaFinal;


        
        for (uint i = 0; i < _cantItems; i++){
            _notaParaPromedio += notas_materia[_nom_materias[i]][_bimestres[i]];
        }

        _notaFinal = _notaParaPromedio / _cantItems;
        return _notaFinal;
        
    }
}

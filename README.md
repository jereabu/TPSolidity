# TP Solidity
Jeremias A
Andres Chouela
Opcionales:

a. Se podria cambiar el mapping de las notas y 
hacer un mapping de otro mapping, donde una clave sea el nombre de la materia 
y el valor sea otro mapping con clave numero de bimestre y valor la nota. 
Tambien en el momento de agregar todo, verificar que el numero del bimestre sea mayor/igual a 1 y menor/igual a 4.

b. Creamos un array de docentes autorizados y una funcion de agregarDocente().
En esta funcion se verifica que el que este agregando un docente este autorizado y se agregue.
Cuando se necesite hacer algo donde un docente tiene que estar autorizado, checkee si la adress del msg.sender 
pertenezca al array de docentes con la funcion docenteAuth().

c. Creamos un evento "Deposit", despues una funcion de deposit() que pida la materia y la nota. 
Cuando un docente determina una nota en la funcion set_nota_materia(), 
se hace un emit a deposit() con la address del docente que hace el emit. 

Link al etherscan:
https://rinkeby.etherscan.io/address/0xe7e2C172a8aA70feC87fe3c49B86Fa2457f0145E
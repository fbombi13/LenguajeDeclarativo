%Materias
materia(seminario).
materia(informatica).
materia(bbdd).
materia(iot).
materia(machinelearning).
materia(geomatica).
materia(matematicas).
materia(tesis).

%Estudiantes
estudiante(fulano).
estudiante(maria).
estudiante(pepe).
estudiante(archumildo).

%Inscrito
inscrito(fulano,seminario).
inscrito(fulano,informatica).
inscrito(fulano,bbdd).
inscrito(fulano,tesis).
inscrito(maria,seminario).
inscrito(maria,tesis).
inscrito(pepe,seminario).
inscrito(pepe,informatica).
inscrito(pepe,bbdd).
inscrito(archumildo,seminario).

%Notas
notas(fulano,seminario,[1,1,4,1,5]).
notas(fulano,informatica,[3,2,4,1,5]).
notas(fulano,bbdd,[3,4,4,1,2,1,0]).
notas(fulano,tesis,[5,4,4,1,5,3,5]).
notas(maria,seminario,[3,4,4,1,5,1]).
notas(maria,tesis,[4,4,4,1,5,1]).
notas(pepe,seminario,[3,4,4,1,5,1]).
notas(pepe,informatica,[3,4,4,1,5,1]).
notas(pepe,bbdd,[3,4,4,1,2,5]).
notas(archumildo,seminario,[2,4,4,1,5]).

%Pasa o no pasa la materia
paso(X,Y):-
    X < 3 -> Y = perdido; 
	X = 3 -> Y = paso;
    X > 3 -> Y = paso.

%Cantidad de materias
cantidadlista([],0).
cantidadlista([_|Y],R):- cantidadlista(Y, R1), R is R1 + 1.

%Suma de notas
suma([],0).
suma([X|Y],R):- suma(Y, R1), R is R1 + X.

promedioMateria(X,W):-notas(X,_,Z),suma(Z,R),cantidadlista(Z,C), W is R/C.

perdioMateria(X):-promedioMateria(X,P),paso(P,W),W = perdido.
pasoMateria(X):-notas(X,_,Z),paso(Z,W),W = paso.

listaperdidas(L):-findall(X,perdioMateria(X),L).
listapasadas(L):-findall(X,pasoMateria(X),L).

cantidadinscritas(X,Rest):-findall(X,inscrito(X,_),Res),ocurrencia(Res,X,Rest).

progreso(X,Prog):-findall(X,inscrito(X,Res),Res), 
    ocurrencia(Res,X,CantidadE), 
    findall(Materia,materia(Materia),CantidadMateria),
    cantidadlista(CantidadMateria,T), Prog is (CantidadE/T)*100.
    
ocurrencia([] , _,0). 
ocurrencia([H|T] ,H,NewCount):-  ocurrencia(T,H,OldCount), 
 NewCount is OldCount +1.
ocurrencia([H|T] , H2,Count):-
 dif(H,H2), ocurrencia(T,H2,Count).
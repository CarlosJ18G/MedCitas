Å	
ZC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Services\FakeEmailService.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "
Services" *
{		 
public

 

class

 
FakeEmailService

 !
:

" #
IEmailService

$ 1
{ 
public 
Task )
EnviarCorreoVerificacionAsync 1
(1 2
string2 8
destinatario9 E
,E F
stringG M
tokenVerificacionN _
)_ `
{ 	
Console 
. 
	WriteLine 
( 
$"  
$str  <
{< =
destinatario= I
}I J
"J K
)K L
;L M
Console 
. 
	WriteLine 
( 
$"  
$str  W
{W X
tokenVerificacionX i
}i j
"j k
)k l
;l m
return 
Task 
. 
CompletedTask %
;% &
} 	
} 
} – 
hC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Repositories\InMemoryPacienteRepository.cs
	namespace		 	
MedCitas		
 
.		 
Infrastructure		 !
.		! "
Repositories		" .
{

 
public 

class &
InMemoryPacienteRepository +
:, -
IPacienteRepository. A
{ 
private 
readonly 
List 
< 
Paciente &
>& '

_pacientes( 2
=3 4
new5 8
(8 9
)9 :
;: ;
public 
Task 
< 
Paciente 
? 
> $
ObtenerPorDocumentoAsync 7
(7 8
string8 >
numeroDocumento? N
)N O
{ 	
var 
p 
= 

_pacientes 
. 
FirstOrDefault -
(- .
x. /
=>0 2
x3 4
.4 5
NumeroDocumento5 D
==E G
numeroDocumentoH W
)W X
;X Y
return 
Task 
. 

FromResult "
<" #
Paciente# +
?+ ,
>, -
(- .
p. /
)/ 0
;0 1
} 	
public 
Task 
< 
Paciente 
? 
> !
ObtenerPorCorreoAsync 4
(4 5
string5 ;
correoElectronico< M
)M N
{ 	
var 
p 
= 

_pacientes 
. 
FirstOrDefault -
(- .
x. /
=>0 2
string 
. 
Equals 
( 
x 
.  
CorreoElectronico  1
,1 2
correoElectronico3 D
,D E
StringComparisonF V
.V W
OrdinalIgnoreCaseW h
)h i
)i j
;j k
return 
Task 
. 

FromResult "
<" #
Paciente# +
?+ ,
>, -
(- .
p. /
)/ 0
;0 1
} 	
public 
Task 
RegistrarAsync "
(" #
Paciente# +
paciente, 4
)4 5
{ 	
if 
( 
paciente 
. 
Id 
== 
Guid #
.# $
Empty$ )
)) *
paciente 
. 
Id 
= 
Guid "
." #
NewGuid# *
(* +
)+ ,
;, -

_pacientes!! 
.!! 
Add!! 
(!! 
paciente!! #
)!!# $
;!!$ %
return"" 
Task"" 
."" 
CompletedTask"" %
;""% &
}## 	
public%% 
Task%% 
<%% 
bool%% 
>%% 
ActivarCuentaAsync%% ,
(%%, -
string%%- 3
tokenVerificacion%%4 E
)%%E F
{&& 	
var'' 
paciente'' 
='' 

_pacientes'' %
.''% &
FirstOrDefault''& 4
(''4 5
x''5 6
=>''7 9
x'': ;
.''; <
TokenVerificacion''< M
==''N P
tokenVerificacion''Q b
)''b c
;''c d
if(( 
((( 
paciente(( 
==(( 
null((  
)((  !
return((" (
Task(() -
.((- .

FromResult((. 8
(((8 9
false((9 >
)((> ?
;((? @
paciente** 
.** 
EstaVerificado** #
=**$ %
true**& *
;*** +
paciente++ 
.++ 
TokenVerificacion++ &
=++' (
null++) -
;++- .
return,, 
Task,, 
.,, 

FromResult,, "
(,," #
true,,# '
),,' (
;,,( )
}-- 	
}.. 
}// 
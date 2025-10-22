÷I
TC:\Users\Usuario\Desktop\medcitas\MedCitas\MedCitas.Core\Services\PacienteService.cs
	namespace 	
MedCitas
 
. 
Core 
. 
Services  
{ 
public 

class 
PacienteService  
{ 
private 
readonly 
IPacienteRepository ,
_repo- 2
;2 3
private 
readonly 
IEmailService &
_emailService' 4
;4 5
public 
PacienteService 
( 
IPacienteRepository 2
repo3 7
,7 8
IEmailService9 F
emailServiceG S
)S T
{ 	
_repo 
= 
repo 
; 
_emailService 
= 
emailService (
;( )
} 	
public 
async 
Task 
< 
Paciente "
>" #
RegistrarAsync$ 2
(2 3
Paciente3 ;
nuevo< A
,A B
stringC I
plainPasswordJ W
,W X
stringY _
confirmarPassword` q
)q r
{ 	
if 
( 
nuevo 
== 
null 
) 
throw $
new% (!
ArgumentNullException) >
(> ?
nameof? E
(E F
nuevoF K
)K L
)L M
;M N
ValidarCampos   
(   
nuevo   
,    
plainPassword  ! .
,  . /
confirmarPassword  0 A
)  A B
;  B C
var## 
	porCorreo## 
=## 
await## !
_repo##" '
.##' (!
ObtenerPorCorreoAsync##( =
(##= >
nuevo##> C
.##C D
CorreoElectronico##D U
)##U V
;##V W
if$$ 
($$ 
	porCorreo$$ 
!=$$ 
null$$ !
)$$! "
throw$$# (
new$$) ,%
InvalidOperationException$$- F
($$F G
$str$$G r
)$$r s
;$$s t
var&& 
porDoc&& 
=&& 
await&& 
_repo&& $
.&&$ %$
ObtenerPorDocumentoAsync&&% =
(&&= >
nuevo&&> C
.&&C D
NumeroDocumento&&D S
)&&S T
;&&T U
if'' 
('' 
porDoc'' 
!='' 
null'' 
)'' 
throw''  %
new''& )%
InvalidOperationException''* C
(''C D
$str''D p
)''p q
;''q r
nuevo** 
.** 
PasswordHash** 
=**  
BCrypt**! '
.**' (
Net**( +
.**+ ,
BCrypt**, 2
.**2 3
HashPassword**3 ?
(**? @
plainPassword**@ M
)**M N
;**N O
nuevo-- 
.-- 
TokenVerificacion-- #
=--$ %
Guid--& *
.--* +
NewGuid--+ 2
(--2 3
)--3 4
.--4 5
ToString--5 =
(--= >
)--> ?
;--? @
nuevo.. 
... 
EstaVerificado..  
=..! "
false..# (
;..( )
nuevo// 
.// 
FechaRegistro// 
=//  !
DateTime//" *
.//* +
UtcNow//+ 1
;//1 2
await22 
_repo22 
.22 
RegistrarAsync22 &
(22& '
nuevo22' ,
)22, -
;22- .
await55 
_emailService55 
.55  )
EnviarCorreoVerificacionAsync55  =
(55= >
nuevo55> C
.55C D
CorreoElectronico55D U
,55U V
nuevo55W \
.55\ ]
TokenVerificacion55] n
)55n o
;55o p
return77 
nuevo77 
;77 
}88 	
public== 
async== 
Task== 
<== 
Paciente== "
?==" #
>==# $

LoginAsync==% /
(==/ 0
string==0 6
correo==7 =
,=== >
string==? E
password==F N
)==N O
{>> 	
if?? 
(?? 
string?? 
.?? 
IsNullOrWhiteSpace?? )
(??) *
correo??* 0
)??0 1
||??2 4
string??5 ;
.??; <
IsNullOrWhiteSpace??< N
(??N O
password??O W
)??W X
)??X Y
throw@@ 
new@@ 
ArgumentException@@ +
(@@+ ,
$str@@, S
)@@S T
;@@T U
varBB 
pacienteBB 
=BB 
awaitBB  
_repoBB! &
.BB& '!
ObtenerPorCorreoAsyncBB' <
(BB< =
correoBB= C
)BBC D
;BBD E
ifCC 
(CC 
pacienteCC 
==CC 
nullCC  
)CC  !
returnCC" (
nullCC) -
;CC- .
ifEE 
(EE 
!EE 
pacienteEE 
.EE 
EstaVerificadoEE (
)EE( )
throwFF 
newFF %
InvalidOperationExceptionFF 3
(FF3 4
$strFF4 W
)FFW X
;FFX Y
boolHH 
passwordCorrectoHH !
=HH" #
BCryptHH$ *
.HH* +
NetHH+ .
.HH. /
BCryptHH/ 5
.HH5 6
VerifyHH6 <
(HH< =
passwordHH= E
,HHE F
pacienteHHG O
.HHO P
PasswordHashHHP \
)HH\ ]
;HH] ^
returnII 
passwordCorrectoII #
?II$ %
pacienteII& .
:II/ 0
nullII1 5
;II5 6
}JJ 	
publicOO 
asyncOO 
TaskOO 
<OO 
boolOO 
>OO 
ActivarCuentaAsyncOO  2
(OO2 3
stringOO3 9
tokenOO: ?
)OO? @
{PP 	
ifQQ 
(QQ 
stringQQ 
.QQ 
IsNullOrWhiteSpaceQQ )
(QQ) *
tokenQQ* /
)QQ/ 0
)QQ0 1
throwRR 
newRR 
ArgumentExceptionRR +
(RR+ ,
$strRR, =
)RR= >
;RR> ?
returnTT 
awaitTT 
_repoTT 
.TT 
ActivarCuentaAsyncTT 1
(TT1 2
tokenTT2 7
)TT7 8
;TT8 9
}UU 	
privateZZ 
voidZZ 
ValidarCamposZZ "
(ZZ" #
PacienteZZ# +
pZZ, -
,ZZ- .
stringZZ/ 5
passwordZZ6 >
,ZZ> ?
stringZZ@ F
	confirmarZZG P
)ZZP Q
{[[ 	
var]] 
regexTimeout]] 
=]] 
TimeSpan]] '
.]]' (
FromMilliseconds]]( 8
(]]8 9
$num]]9 <
)]]< =
;]]= >
if__ 
(__ 
string__ 
.__ 
IsNullOrWhiteSpace__ )
(__) *
p__* +
.__+ ,
NombreCompleto__, :
)__: ;
)__; <
throw`` 
new`` 
ArgumentException`` +
(``+ ,
$str``, P
)``P Q
;``Q R
ifbb 
(bb 
!bb 
Regexbb 
.bb 
IsMatchbb 
(bb 
pbb  
.bb  !
NumeroDocumentobb! 0
,bb0 1
$strbb2 :
,bb: ;
RegexOptionsbb< H
.bbH I
NonebbI M
,bbM N
regexTimeoutbbO [
)bb[ \
)bb\ ]
throwcc 
newcc 
ArgumentExceptioncc +
(cc+ ,
$strcc, `
)cc` a
;cca b
ifee 
(ee 
!ee 
Regexee 
.ee 
IsMatchee 
(ee 
pee  
.ee  !
Telefonoee! )
,ee) *
$stree+ 8
,ee8 9
RegexOptionsee: F
.eeF G
NoneeeG K
,eeK L
regexTimeouteeM Y
)eeY Z
)eeZ [
throwff 
newff 
ArgumentExceptionff +
(ff+ ,
$strff, ]
)ff] ^
;ff^ _
ifhh 
(hh 
!hh 
Regexhh 
.hh 
IsMatchhh 
(hh 
phh  
.hh  !
CorreoElectronicohh! 2
,hh2 3
$strhh4 Q
,hhQ R
RegexOptionshhS _
.hh_ `
Nonehh` d
,hhd e
regexTimeouthhf r
)hhr s
)hhs t
throwii 
newii 
ArgumentExceptionii +
(ii+ ,
$strii, I
)iiI J
;iiJ K
ifkk 
(kk 
passwordkk 
!=kk 
	confirmarkk %
)kk% &
throwll 
newll 
ArgumentExceptionll +
(ll+ ,
$strll, K
)llK L
;llL M
ifnn 
(nn 
!nn 
Regexnn 
.nn 
IsMatchnn 
(nn 
passwordnn '
,nn' (
$strnn) b
,nnb c
RegexOptionsnnd p
.nnp q
Nonennq u
,nnu v
regexTimeout	nnw ƒ
)
nnƒ „
)
nn„ …
throwoo 
newoo 
ArgumentExceptionoo +
(oo+ ,
$str	oo, ‘
)
oo‘ ’
;
oo’ “
}pp 	
}qq 
}rr Í
ZC:\Users\Usuario\Desktop\medcitas\MedCitas\MedCitas.Core\Interfaces\IPacienteRepository.cs
	namespace 	
MedCitas
 
. 
Core 
. 

Interfaces "
{		 
public

 

	interface

 
IPacienteRepository

 (
{ 
Task 
< 
Paciente 
? 
> $
ObtenerPorDocumentoAsync 0
(0 1
string1 7
numeroDocumento8 G
)G H
;H I
Task 
< 
Paciente 
? 
> !
ObtenerPorCorreoAsync -
(- .
string. 4
correoElectronico5 F
)F G
;G H
Task 
RegistrarAsync 
( 
Paciente $
paciente% -
)- .
;. /
Task 
< 
bool 
> 
ActivarCuentaAsync %
(% &
string& ,
tokenVerificacion- >
)> ?
;? @
} 
} –1
MC:\Users\Usuario\Desktop\medcitas\MedCitas\MedCitas.Core\Entities\Paciente.cs
	namespace 	
MedCitas
 
. 
Core 
. 
Entities  
{		 
public

 

class

 
Paciente

 
{ 
public 
Guid 
Id 
{ 
get 
; 
set !
;! "
}# $
=% &
Guid' +
.+ ,
NewGuid, 3
(3 4
)4 5
;5 6
[ 	
Required	 
] 
public 
string 
NombreCompleto $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
string5 ;
.; <
Empty< A
;A B
[ 	
Required	 
] 
public 
string 
TipoDocumento #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
string4 :
.: ;
Empty; @
;@ A
[ 	
Required	 
, 
	MaxLength 
( 
$num 
)  
]  !
public 
string 
NumeroDocumento %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
=4 5
string6 <
.< =
Empty= B
;B C
[ 	
Required	 
] 
public 
DateTime 
FechaNacimiento '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	
Required	 
] 
public 
string 
Sexo 
{ 
get  
;  !
set" %
;% &
}' (
=) *
string+ 1
.1 2
Empty2 7
;7 8
[ 	
Required	 
, 
	MaxLength 
( 
$num 
)  
]  !
public 
string 
Telefono 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
string/ 5
.5 6
Empty6 ;
;; <
[   	
Required  	 
,   
EmailAddress   
]    
public!! 
string!! 
CorreoElectronico!! '
{!!( )
get!!* -
;!!- .
set!!/ 2
;!!2 3
}!!4 5
=!!6 7
string!!8 >
.!!> ?
Empty!!? D
;!!D E
[## 	
Required##	 
,## 
	MaxLength## 
(## 
$num## 
)##  
]##  !
public$$ 
string$$ 
PasswordHash$$ "
{$$# $
get$$% (
;$$( )
set$$* -
;$$- .
}$$/ 0
=$$1 2
string$$3 9
.$$9 :
Empty$$: ?
;$$? @
[&& 	
Required&&	 
]&& 
public'' 
string'' 
Eps'' 
{'' 
get'' 
;''  
set''! $
;''$ %
}''& '
=''( )
string''* 0
.''0 1
Empty''1 6
;''6 7
[)) 	
Required))	 
])) 
public** 
string** 

TipoSangre**  
{**! "
get**# &
;**& '
set**( +
;**+ ,
}**- .
=**/ 0
string**1 7
.**7 8
Empty**8 =
;**= >
public,, 
bool,, 
EstaVerificado,, "
{,,# $
get,,% (
;,,( )
set,,* -
;,,- .
},,/ 0
=,,1 2
false,,3 8
;,,8 9
public-- 
string-- 
?-- 
TokenVerificacion-- (
{--) *
get--+ .
;--. /
set--0 3
;--3 4
}--5 6
public.. 
DateTime.. 
FechaRegistro.. %
{..& '
get..( +
;..+ ,
set..- 0
;..0 1
}..2 3
=..4 5
DateTime..6 >
...> ?
UtcNow..? E
;..E F
public00 
string00 
ToString00 
(00 
)00  
{11 	
return22 
$"22 
$str22 
{22  
NombreCompleto22  .
}22. /
$str22/ <
{22< =
TipoDocumento22= J
}22J K
$str22K L
{22L M
NumeroDocumento22M \
}22\ ]
$str22] k
{22k l
FechaNacimiento22l {
.22{ |
ToShortDateString	22| 
(
22 Ž
)
22Ž 
}
22 
$str
22 ˜
{
22˜ ™
Sexo
22™ 
}
22 ž
$str
22ž ª
{
22ª «
Telefono
22« ³
}
22³ ´
$str
22´ ¾
{
22¾ ¿
CorreoElectronico
22¿ Ð
}
22Ð Ñ
$str
22Ñ Ø
{
22Ø Ù
Eps
22Ù Ü
}
22Ü Ý
$str
22Ý ï
{
22ï ð

TipoSangre
22ð ú
}
22ú û
$str
22û ‰
{
22‰ Š
EstaVerificado
22Š ˜
}
22˜ ™
$str
22™ ®
{
22® ¯
FechaRegistro
22¯ ¼
}
22¼ ½
"
22½ ¾
;
22¾ ¿
}33 	
public55 
int55 
CalcularEdad55 
(55  
)55  !
{66 	
var77 
hoy77 
=77 
DateTime77 
.77 
Today77 $
;77$ %
var88 
edad88 
=88 
hoy88 
.88 
Year88 
-88  !
FechaNacimiento88" 1
.881 2
Year882 6
;886 7
if99 
(99 
FechaNacimiento99 
.99  
Date99  $
>99% &
hoy99' *
.99* +
AddYears99+ 3
(993 4
-994 5
edad995 9
)999 :
)99: ;
edad99< @
--99@ B
;99B C
return:: 
edad:: 
;:: 
};; 	
}== 
}?? ¡
TC:\Users\Usuario\Desktop\medcitas\MedCitas\MedCitas.Core\Interfaces\IEmailService.cs
	namespace 	
MedCitas
 
. 
Core 
. 

Interfaces "
{ 
public		 

	interface		 
IEmailService		 "
{

 
Task )
EnviarCorreoVerificacionAsync *
(* +
string+ 1
destinatario2 >
,> ?
string@ F
tokenVerificacionG X
)X Y
;Y Z
} 
} 
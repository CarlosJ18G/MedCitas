ÿn
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
{ 	!
ArgumentNullException !
.! "
ThrowIfNull" -
(- .
nuevo. 3
)3 4
;4 5
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
nuevo.. 
... 
	CodigoOTP.. 
=.. 

OtpService.. (
...( )

GenerarOTP..) 3
(..3 4
)..4 5
;..5 6
nuevo// 
.// 
OTPExpiracion// 
=//  !

OtpService//" ,
.//, -"
ObtenerFechaExpiracion//- C
(//C D
)//D E
;//E F
nuevo00 
.00 
IntentosOTPFallidos00 %
=00& '
$num00( )
;00) *
nuevo11 
.11 
EstaVerificado11  
=11! "
false11# (
;11( )
nuevo22 
.22 
FechaRegistro22 
=22  !
DateTime22" *
.22* +
UtcNow22+ 1
;221 2
await55 
_repo55 
.55 
RegistrarAsync55 &
(55& '
nuevo55' ,
)55, -
;55- .
await88 
_emailService88 
.88  
EnviarOTPAsync88  .
(88. /
nuevo99 
.99 
CorreoElectronico99 '
,99' (
nuevo:: 
.:: 
	CodigoOTP:: 
,::  
nuevo;; 
.;; 
NombreCompleto;; $
)<< 
;<< 
return>> 
nuevo>> 
;>> 
}?? 	
publicDD 
asyncDD 
TaskDD 
<DD 
PacienteDD "
?DD" #
>DD# $

LoginAsyncDD% /
(DD/ 0
stringDD0 6
correoDD7 =
,DD= >
stringDD? E
passwordDDF N
)DDN O
{EE 	
ifFF 
(FF 
stringFF 
.FF 
IsNullOrWhiteSpaceFF )
(FF) *
correoFF* 0
)FF0 1
||FF2 4
stringFF5 ;
.FF; <
IsNullOrWhiteSpaceFF< N
(FFN O
passwordFFO W
)FFW X
)FFX Y
throwGG 
newGG 
ArgumentExceptionGG +
(GG+ ,
$strGG, S
)GGS T
;GGT U
varII 
pacienteII 
=II 
awaitII  
_repoII! &
.II& '!
ObtenerPorCorreoAsyncII' <
(II< =
correoII= C
)IIC D
;IID E
ifJJ 
(JJ 
pacienteJJ 
==JJ 
nullJJ  
)JJ  !
returnJJ" (
nullJJ) -
;JJ- .
ifLL 
(LL 
!LL 
pacienteLL 
.LL 
EstaVerificadoLL (
)LL( )
throwMM 
newMM %
InvalidOperationExceptionMM 3
(MM3 4
$strMM4 W
)MMW X
;MMX Y
boolOO 
passwordCorrectoOO !
=OO" #
BCryptOO$ *
.OO* +
NetOO+ .
.OO. /
BCryptOO/ 5
.OO5 6
VerifyOO6 <
(OO< =
passwordOO= E
,OOE F
pacienteOOG O
.OOO P
PasswordHashOOP \
)OO\ ]
;OO] ^
returnPP 
passwordCorrectoPP #
?PP$ %
pacientePP& .
:PP/ 0
nullPP1 5
;PP5 6
}QQ 	
publicVV 
asyncVV 
TaskVV 
<VV 
boolVV 
>VV 
ActivarCuentaAsyncVV  2
(VV2 3
stringVV3 9
tokenVV: ?
)VV? @
{WW 	
ifXX 
(XX 
stringXX 
.XX 
IsNullOrWhiteSpaceXX )
(XX) *
tokenXX* /
)XX/ 0
)XX0 1
throwYY 
newYY 
ArgumentExceptionYY +
(YY+ ,
$strYY, =
)YY= >
;YY> ?
return[[ 
await[[ 
_repo[[ 
.[[ 
ActivarCuentaAsync[[ 1
([[1 2
token[[2 7
)[[7 8
;[[8 9
}\\ 	
publicaa 
staticaa 
voidaa 
ValidarCamposaa (
(aa( )
Pacienteaa) 1
paa2 3
,aa3 4
stringaa5 ;
passwordaa< D
,aaD E
stringaaF L
	confirmaraaM V
)aaV W
{bb 	
vardd 
regexTimeoutdd 
=dd 
TimeSpandd '
.dd' (
FromMillisecondsdd( 8
(dd8 9
$numdd9 <
)dd< =
;dd= >
ifff 
(ff 
stringff 
.ff 
IsNullOrWhiteSpaceff )
(ff) *
pff* +
.ff+ ,
NombreCompletoff, :
)ff: ;
)ff; <
throwgg 
newgg 
ArgumentExceptiongg +
(gg+ ,
$strgg, P
)ggP Q
;ggQ R
ifii 
(ii 
!ii 
Regexii 
.ii 
IsMatchii 
(ii 
pii  
.ii  !
NumeroDocumentoii! 0
,ii0 1
$strii2 :
,ii: ;
RegexOptionsii< H
.iiH I
NoneiiI M
,iiM N
regexTimeoutiiO [
)ii[ \
)ii\ ]
throwjj 
newjj 
ArgumentExceptionjj +
(jj+ ,
$strjj, `
)jj` a
;jja b
ifll 
(ll 
!ll 
Regexll 
.ll 
IsMatchll 
(ll 
pll  
.ll  !
Telefonoll! )
,ll) *
$strll+ 8
,ll8 9
RegexOptionsll: F
.llF G
NonellG K
,llK L
regexTimeoutllM Y
)llY Z
)llZ [
throwmm 
newmm 
ArgumentExceptionmm +
(mm+ ,
$strmm, ]
)mm] ^
;mm^ _
ifoo 
(oo 
!oo 
Regexoo 
.oo 
IsMatchoo 
(oo 
poo  
.oo  !
CorreoElectronicooo! 2
,oo2 3
$stroo4 Q
,ooQ R
RegexOptionsooS _
.oo_ `
Noneoo` d
,ood e
regexTimeoutoof r
)oor s
)oos t
throwpp 
newpp 
ArgumentExceptionpp +
(pp+ ,
$strpp, I
)ppI J
;ppJ K
ifrr 
(rr 
passwordrr 
!=rr 
	confirmarrr %
)rr% &
throwss 
newss 
ArgumentExceptionss +
(ss+ ,
$strss, K
)ssK L
;ssL M
ifuu 
(uu 
!uu 
Regexuu 
.uu 
IsMatchuu 
(uu 
passworduu '
,uu' (
$struu) b
,uub c
RegexOptionsuud p
.uup q
Noneuuq u
,uuu v
regexTimeout	uuw É
)
uuÉ Ñ
)
uuÑ Ö
throwvv 
newvv 
ArgumentExceptionvv +
(vv+ ,
$str	vv, ë
)
vvë í
;
vví ì
}ww 	
publicyy 
asyncyy 
Taskyy 
<yy 
boolyy 
>yy 
VerificarOTPAsyncyy  1
(yy1 2
stringyy2 8
correoyy9 ?
,yy? @
stringyyA G
	codigoOTPyyH Q
)yyQ R
{zz 	
if{{ 
({{ 
string{{ 
.{{ 
IsNullOrWhiteSpace{{ )
({{) *
correo{{* 0
){{0 1
||{{2 4
string{{5 ;
.{{; <
IsNullOrWhiteSpace{{< N
({{N O
	codigoOTP{{O X
){{X Y
){{Y Z
throw|| 
new|| 
ArgumentException|| +
(||+ ,
$str||, S
)||S T
;||T U
var~~ 
paciente~~ 
=~~ 
await~~  
_repo~~! &
.~~& '!
ObtenerPorCorreoAsync~~' <
(~~< =
correo~~= C
)~~C D
;~~D E
if 
( 
paciente 
== 
null  
)  !
throw
ÄÄ 
new
ÄÄ '
InvalidOperationException
ÄÄ 3
(
ÄÄ3 4
$str
ÄÄ4 L
)
ÄÄL M
;
ÄÄM N
if
ÇÇ 
(
ÇÇ 
paciente
ÇÇ 
.
ÇÇ !
IntentosOTPFallidos
ÇÇ ,
>=
ÇÇ- /
$num
ÇÇ0 1
)
ÇÇ1 2
throw
ÉÉ 
new
ÉÉ '
InvalidOperationException
ÉÉ 3
(
ÉÉ3 4
$str
ÉÉ4 m
)
ÉÉm n
;
ÉÉn o
if
ÖÖ 
(
ÖÖ 
!
ÖÖ 

OtpService
ÖÖ 
.
ÖÖ 

ValidarOTP
ÖÖ &
(
ÖÖ& '
	codigoOTP
ÖÖ' 0
,
ÖÖ0 1
paciente
ÖÖ2 :
.
ÖÖ: ;
	CodigoOTP
ÖÖ; D
!
ÖÖD E
,
ÖÖE F
paciente
ÖÖG O
.
ÖÖO P
OTPExpiracion
ÖÖP ]
)
ÖÖ] ^
)
ÖÖ^ _
{
ÜÜ 
paciente
áá 
.
áá !
IntentosOTPFallidos
áá ,
++
áá, .
;
áá. /
await
àà 
_repo
àà 
.
àà  
ActualizarOTPAsync
àà .
(
àà. /
paciente
àà/ 7
)
àà7 8
;
àà8 9
return
ââ 
false
ââ 
;
ââ 
}
ää 
return
åå 
await
åå 
_repo
åå 
.
åå 
VerificarOTPAsync
åå 0
(
åå0 1
correo
åå1 7
,
åå7 8
	codigoOTP
åå9 B
)
ååB C
;
ååC D
}
çç 	
public
êê 
async
êê 
Task
êê 
ReenviarOTPAsync
êê *
(
êê* +
string
êê+ 1
correo
êê2 8
)
êê8 9
{
ëë 	
var
íí 
paciente
íí 
=
íí 
await
íí  
_repo
íí! &
.
íí& '#
ObtenerPorCorreoAsync
íí' <
(
íí< =
correo
íí= C
)
ííC D
;
ííD E
if
ìì 
(
ìì 
paciente
ìì 
==
ìì 
null
ìì  
)
ìì  !
throw
îî 
new
îî '
InvalidOperationException
îî 3
(
îî3 4
$str
îî4 L
)
îîL M
;
îîM N
if
ññ 
(
ññ 
paciente
ññ 
.
ññ 
EstaVerificado
ññ '
)
ññ' (
throw
óó 
new
óó '
InvalidOperationException
óó 3
(
óó3 4
$str
óó4 S
)
óóS T
;
óóT U
paciente
ôô 
.
ôô 
	CodigoOTP
ôô 
=
ôô  

OtpService
ôô! +
.
ôô+ ,

GenerarOTP
ôô, 6
(
ôô6 7
)
ôô7 8
;
ôô8 9
paciente
öö 
.
öö 
OTPExpiracion
öö "
=
öö# $

OtpService
öö% /
.
öö/ 0$
ObtenerFechaExpiracion
öö0 F
(
ööF G
)
ööG H
;
ööH I
paciente
õõ 
.
õõ !
IntentosOTPFallidos
õõ (
=
õõ) *
$num
õõ+ ,
;
õõ, -
await
ùù 
_repo
ùù 
.
ùù  
ActualizarOTPAsync
ùù *
(
ùù* +
paciente
ùù+ 3
)
ùù3 4
;
ùù4 5
await
ûû 
_emailService
ûû 
.
ûû  
EnviarOTPAsync
ûû  .
(
ûû. /
correo
ûû/ 5
,
ûû5 6
paciente
ûû7 ?
.
ûû? @
	CodigoOTP
ûû@ I
,
ûûI J
paciente
ûûK S
.
ûûS T
NombreCompleto
ûûT b
)
ûûb c
;
ûûc d
}
üü 	
}
†† 
}°° Û
OC:\Users\Usuario\Desktop\medcitas\MedCitas\MedCitas.Core\Services\OtpService.cs
	namespace 	
MedCitas
 
. 
Core 
. 
Services  
{		 
public

 

static

 
class

 

OtpService

 "
{ 
private 
const 
int "
OTP_EXPIRATION_MINUTES 0
=1 2
$num3 5
;5 6
public 
static 
string 

GenerarOTP '
(' (
)( )
{ 	
return !
RandomNumberGenerator (
.( )
GetInt32) 1
(1 2
$num2 8
,8 9
$num: @
)@ A
.A B
ToStringB J
(J K
)K L
;L M
} 	
public 
static 
DateTime "
ObtenerFechaExpiracion 5
(5 6
)6 7
{ 	
return 
DateTime 
. 
UtcNow "
." #

AddMinutes# -
(- ."
OTP_EXPIRATION_MINUTES. D
)D E
;E F
} 	
public 
static 
bool 

ValidarOTP %
(% &
string& ,
otpIngresado- 9
,9 :
string; A
otpAlmacenadoB O
,O P
DateTimeQ Y
?Y Z

expiracion[ e
)e f
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
otpIngresado* 6
)6 7
||8 :
string 
. 
IsNullOrWhiteSpace )
() *
otpAlmacenado* 7
)7 8
||9 ;

expiracion 
== 
null "
)" #
return 
false 
; 
if 
( 
DateTime 
. 
UtcNow 
>  !

expiracion" ,
), -
return   
false   
;   
return"" 
otpIngresado"" 
==""  "
otpAlmacenado""# 0
;""0 1
}## 	
}$$ 
}%% »
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
;? @
Task 
< 
bool 
> 
VerificarOTPAsync $
($ %
string% +
correo, 2
,2 3
string4 :
	codigoOTP; D
)D E
;E F
Task 
ActualizarOTPAsync 
(  
Paciente  (
paciente) 1
)1 2
;2 3
} 
} ù
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
;Y Z
Task 
EnviarOTPAsync 
( 
string "
correo# )
,) *
string+ 1
	codigoOTP2 ;
,; <
string= C
nombreCompletoD R
)R S
;S T
} 
} €@
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
[## 	
	MaxLength##	 
(## 
$num## 
)## 
]## 
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
public-- 
string-- 
?-- 
	CodigoOTP--  
{--! "
get--# &
;--& '
set--( +
;--+ ,
}--- .
public.. 
DateTime.. 
?.. 
OTPExpiracion.. &
{..' (
get..) ,
;.., -
set... 1
;..1 2
}..3 4
public// 
int// 
IntentosOTPFallidos// &
{//' (
get//) ,
;//, -
set//. 1
;//1 2
}//3 4
=//5 6
$num//7 8
;//8 9
public11 
bool11 
EstaVerificado11 "
{11# $
get11% (
;11( )
set11* -
;11- .
}11/ 0
=111 2
false113 8
;118 9
public22 
string22 
?22 
TokenVerificacion22 (
{22) *
get22+ .
;22. /
set220 3
;223 4
}225 6
public33 
DateTime33 
FechaRegistro33 %
{33& '
get33( +
;33+ ,
set33- 0
;330 1
}332 3
=334 5
DateTime336 >
.33> ?
UtcNow33? E
;33E F
public77 
string77 
ToStringPaciente77 &
(77& '
)77' (
{88 	
return:: 
$":: 
$str:: 
{::  
NombreCompleto::  .
}::. /
$str::/ <
{::< =
TipoDocumento::= J
}::J K
$str::K L
{::L M
NumeroDocumento::M \
}::\ ]
$str::] k
{::k l
FechaNacimiento::l {
.::{ |
ToShortDateString	::| ç
(
::ç é
)
::é è
}
::è ê
$str
::ê ò
{
::ò ô
Sexo
::ô ù
}
::ù û
$str
::û ™
{
::™ ´
Telefono
::´ ≥
}
::≥ ¥
$str
::¥ æ
{
::æ ø
CorreoElectronico
::ø –
}
::– —
$str
::— ÿ
{
::ÿ Ÿ
Eps
::Ÿ ‹
}
::‹ ›
$str
::› Ô
{
::Ô 

TipoSangre
:: ˙
}
::˙ ˚
$str
::˚ â
{
::â ä
EstaVerificado
::ä ò
}
::ò ô
$str
::ô Æ
{
::Æ Ø
FechaRegistro
::Ø º
}
::º Ω
"
::Ω æ
;
::æ ø
};; 	
public== 
int== 
CalcularEdad== 
(==  
)==  !
{>> 	
var?? 
hoy?? 
=?? 
DateTime?? 
.?? 
Today?? $
;??$ %
var@@ 
edad@@ 
=@@ 
hoy@@ 
.@@ 
Year@@ 
-@@  !
FechaNacimiento@@" 1
.@@1 2
Year@@2 6
;@@6 7
ifAA 
(AA 
FechaNacimientoAA 
.AA  
DateAA  $
>AA% &
hoyAA' *
.AA* +
AddYearsAA+ 3
(AA3 4
-AA4 5
edadAA5 9
)AA9 :
)AA: ;
edadAA< @
--AA@ B
;AAB C
returnBB 
edadBB 
;BB 
}CC 	
publicEE 
boolEE 
EsMayorDeEdadEE !
(EE! "
)EE" #
{FF 	
returnGG 
CalcularEdadGG 
(GG  
)GG  !
>=GG" $
$numGG% '
;GG' (
}HH 	
publicJJ 
boolJJ "
EsPacientePreferencialJJ *
(JJ* +
)JJ+ ,
{KK 	
varLL 
edadLL 
=LL 
CalcularEdadLL #
(LL# $
)LL$ %
;LL% &
returnMM 
edadMM 
>=MM 
$numMM 
||MM  
edadMM! %
<=MM& (
$numMM) +
;MM+ ,
}NN 	
publicPP 
stringPP "
ObtenerResumenContactoPP ,
(PP, -
)PP- .
{QQ 	
returnRR 
$"RR 
{RR 
NombreCompletoRR $
}RR$ %
$strRR% -
{RR- .
TelefonoRR. 6
}RR6 7
$strRR7 @
{RR@ A
CorreoElectronicoRRA R
}RRR S
"RRS T
;RRT U
}SS 	
publicUU 
voidUU #
ActualizarDatosContactoUU +
(UU+ ,
stringUU, 2
telefonoUU3 ;
,UU; <
stringUU= C
correoUUD J
)UUJ K
{VV 	
TelefonoWW 
=WW 
telefonoWW 
;WW  
CorreoElectronicoXX 
=XX 
correoXX  &
;XX& '
}YY 	
}[[ 
}]] 
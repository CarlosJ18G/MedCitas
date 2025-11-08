ºW
VC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Services\EmailService.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "
Services" *
{ 
public 

class 
EmailService 
: 
IEmailService  -
{ 
private 
readonly 
ILogger  
<  !
EmailService! -
>- .
_logger/ 6
;6 7
private 
readonly 
EmailConfiguration +
_config, 3
;3 4
public 
EmailService 
( 
ILogger #
<# $
EmailService$ 0
>0 1
logger2 8
,8 9
IOptions: B
<B C
EmailConfigurationC U
>U V
configW ]
)] ^
{ 
_logger 
= 
logger 
; 
_config	 
= 
config 
. 
Value 
;  
if 
( 
! 
_config 
. 
IsValid 
( 
) 
) 
{ 
_logger 

.
 

LogWarning 
( 
$str F
,F G
_configH O
.O P
GetValidationErrorsP c
(c d
)d e
)e f
;f g
}	 

else 
{ 
_logger	 
. 
LogInformation 
(  
$str  K
)K L
;L M
} 
}   	
public"" 
async"" 
Task"" )
EnviarCorreoVerificacionAsync"" 7
(""7 8
string""8 >
destinatario""? K
,""K L
string""M S
tokenVerificacion""T e
)""e f
{## 	
var$$ 
asunto$$ 
=$$ 
$str$$ 8
;$$8 9
var%% 
urlVerificacion%%	 
=%% 
$"%% 
$str%% <
{%%< =
tokenVerificacion%%= N
}%%N O
"%%O P
;%%P Q
var''
 

cuerpoHtml'' 
='' #
GenerarHtmlVerificacion'' 2
(''2 3
urlVerificacion''3 B
)''B C
;''C D
await)) 	
EnviarEmailAsync))
 
()) 
destinatario)) '
,))' (
asunto))) /
,))/ 0

cuerpoHtml))1 ;
))); <
;))< =
}** 	
public,, 
async,, 
Task,, 
EnviarOTPAsync,, &
(,,& '
string,,' -
correo,,. 4
,,,4 5
string,,6 <
	codigoOTP,,= F
,,,F G
string,,H N
nombreCompleto,,O ]
),,] ^
{-- 	
var.. 
asunto.. 
=.. 
$str.. <
;..< =
var// 

cuerpoHtml// 
=// 
GenerarHtmlOTP// +
(//+ ,
nombreCompleto//, :
,//: ;
	codigoOTP//< E
)//E F
;//F G
await11 
EnviarEmailAsync11 
(11 
correo11 %
,11% &
asunto11' -
,11- .

cuerpoHtml11/ 9
)119 :
;11: ;
}22 
public44 
async44 
Task44 )
EnviarCorreoRecuperacionAsync44 7
(447 8
string448 >
correo44? E
,44E F
string44G M
nombreCompleto44N \
,44\ ]
string44^ d
urlRecuperacion44e t
)44t u
{55 	
var66	 
asunto66 
=66 
$str66 =
;66= >
var77 


cuerpoHtml77 
=77 #
GenerarHtmlRecuperacion77 /
(77/ 0
nombreCompleto770 >
,77> ?
urlRecuperacion77@ O
)77O P
;77P Q
await99 
EnviarEmailAsync99 "
(99" #
correo99# )
,99) *
asunto99+ 1
,991 2

cuerpoHtml993 =
)99= >
;99> ?
}:: 	
private<< 
async<< 
Task<< 
EnviarEmailAsync<< +
(<<+ ,
string<<, 2
destinatario<<3 ?
,<<? @
string<<A G
asunto<<H N
,<<N O
string<<P V

cuerpoHtml<<W a
)<<a b
{== 	
_logger>> 
.>> 	
LogInformation>>	 
(>> 
$str>> F
,>>F G
destinatario>>H T
,>>T U
asunto>>V \
)>>\ ]
;>>] ^
ifAA 
(AA 
!AA 
_configAA 
.AA 
IsValidAA 
(AA 
)AA 
)AA 
{BB 
varCC 
erroresCC	 
=CC 
_configCC 
.CC 
GetValidationErrorsCC .
(CC. /
)CC/ 0
;CC0 1
_loggerDD 
.DD 
LogErrorDD 
(DD 
$strDD K
,DDK L
erroresDDM T
)DDT U
;DDU V
throwEE 
newEE 
%
InvalidOperationExceptionEE $
(EE$ %
$"EE% '
$strEE' N
{EEN O
erroresEEO V
}EEV W
"EEW X
)EEX Y
;EEY Z
}FF 
tryHH 
{II 
usingJJ 
varJJ 	
clientJJ
 
=JJ 
newJJ 

SmtpClientJJ !
(JJ! "
_configJJ" )
.JJ) *
SmtpHostJJ* 2
,JJ2 3
_configJJ4 ;
.JJ; <
SmtpPortJJ< D
)JJD E
{KK 	
	EnableSslLL 
=LL 
trueLL 
,LL !
UseDefaultCredentialsMM 
=MM 
falseMM "
,MM" #
CredentialsNN 
=NN 
newNN 
NetworkCredentialNN '
(NN' (
_configNN( /
.NN/ 0
SmtpUserNN0 8
,NN8 9
_configNN: A
.NNA B
SmtpPasswordNNB N
)NNN O
,NNO P
DeliveryMethodOO 
=OO 
SmtpDeliveryMethodOO %
.OO% &
NetworkOO& -
,OO- .
TimeoutPP	 
=PP 
AppConstantsPP 
.PP  
EmailPP  %
.PP% &
SmtpTimeoutPP& 1
}QQ 
;QQ 
varSS 

mailMessageSS 
=SS 
newSS 
MailMessageSS (
{TT 	
FromUU 	
=UU
 
newUU 
MailAddressUU 
(UU 
_configUU #
.UU# $
	FromEmailUU$ -
,UU- .
_configUU/ 6
.UU6 7
FromNameUU7 ?
)UU? @
,UU@ A
SubjectVV 
=VV 
asuntoVV 
,VV 
BodyWW 
=WW 

cuerpoHtmlWW	 
,WW 

IsBodyHtmlXX 
=XX 
trueXX 
,XX 
PriorityYY	 
=YY 
MailPriorityYY  
.YY  !
NormalYY! '
}ZZ	 

;ZZ
 
mailMessage\\ 
.\\ 
To\\ 
.\\ 
Add\\ 
(\\ 
new\\ 
MailAddress\\ *
(\\* +
destinatario\\+ 7
)\\7 8
)\\8 9
;\\9 :
await^^ 
client^^ 
.^^ 
SendMailAsync^^ 
(^^ 
mailMessage^^ '
)^^' (
;^^( )
_logger`` 	
.``	 

LogInformation``
 
(`` 
$str`` H
,``H I
destinatario``J V
)``V W
;``W X
}aa 
catchbb 
(bb 
SmtpExceptionbb 
smtpExbb !
)bb! "
{cc 
_loggerdd 
.dd 
LogErrordd 
(dd 
smtpExdd 
,dd 
$strdd f
,ddf g
destinatarioee 
,ee 
smtpExee 
.ee 

StatusCodeee #
)ee# $
;ee$ %
throwff 
newff %
InvalidOperationExceptionff %
(ff% &
$"ff& (
$strff( D
{ffD E
smtpExffE K
.ffK L
MessageffL S
}ffS T
"ffT U
,ffU V
smtpExffW ]
)ff] ^
;ff^ _
}gg 
catchhh 
(hh 
	Exceptionhh 
exhh 
)hh  
whenhh! %
(hh& '
exhh' )
ishh* ,
nothh- 0
SmtpExceptionhh1 >
)hh> ?
{ii 
_loggerjj 
.jj 
LogErrorjj  
(jj  !
exjj! #
,jj# $
$strjj% c
,jjc d
exkk 
.kk 
GetTypekk 
(kk 
)kk 
.kk 
Namekk 
,kk 
destinatariokk $
)kk$ %
;kk% &
throwll 
newll %
InvalidOperationExceptionll )
(ll) *
$"ll* ,
$strll, D
{llD E
destinatariollE Q
}llQ R
$strllR T
{llT U
exllU W
.llW X
MessagellX _
}ll_ `
"ll` a
,lla b
exllc e
)lle f
;llf g
}mm 
}nn 	
privateqq 
staticqq 
stringqq #
GenerarHtmlVerificacionqq 5
(qq5 6
stringqq6 <
urlVerificacionqq= L
)qqL M
{rr 
returnss 
$@"ss 
$str	sá +
{
áá+ ,
urlVerificacion
áá, ;
}
áá; <
$str
áå< 
"
åå 
;
åå 	
}
çç 
private
èè 
static
èè 
string
èè 
GenerarHtmlOTP
èè ,
(
èè, -
string
èè- 3
nombreCompleto
èè4 B
,
èèB C
string
èèD J
	codigoOTP
èèK T
)
èèT U
{
êê 
return
ëë 
$@"
ëë 
$str
ë§ 
{
§§ 
nombreCompleto
§§ %
}
§§% &
$str
§¶& 
{
¶¶ 
	codigoOTP
¶¶ &
}
¶¶& '
$str
¶ß' V
{
ßßV W
AppConstants
ßßW c
.
ßßc d
Otp
ßßd g
.
ßßg h
ExpirationMinutes
ßßh y
}
ßßy z
$str
ß¨z 
"
¨¨ 
;
¨¨ 	
}
≠≠ 	
private
ØØ 
static
ØØ 
string
ØØ %
GenerarHtmlRecuperacion
ØØ 5
(
ØØ5 6
string
ØØ6 <
nombreCompleto
ØØ= K
,
ØØK L
string
ØØM S
urlRecuperacion
ØØT c
)
ØØc d
{
∞∞ 
return
±± 

$@"
±± 
$str
±ƒ 
{
ƒƒ 
nombreCompleto
ƒƒ 
}
ƒƒ 
$str
ƒ∆ ,
{
∆∆, -
urlRecuperacion
∆∆- <
}
∆∆< =
$str
∆«= Q
{
««Q R
AppConstants
««R ^
.
««^ _
RecoveryToken
««_ l
.
««l m
ExpirationMinutes
««m ~
}
««~ 
$str
«Ã 
"
ÃÃ 
;
ÃÃ 	
}
ÕÕ 	
}
ŒŒ 
}œœ éK
cC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Repositories\EfPacienteRepositorio.cs
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
class !
EfPacienteRepositorio &
:' (
IPacienteRepository) <
{ 
private 
readonly 
MedCitasDbContext *
_db+ .
;. /
public !
EfPacienteRepositorio $
($ %
MedCitasDbContext% 6
db7 9
)9 :
=>; =
_db> A
=B C
dbD F
;F G
public 
async 
Task 
< 
Paciente "
?" #
># $$
ObtenerPorDocumentoAsync% =
(= >
string> D
numeroDocumentoE T
)T U
=>V X
await 
_db 
. 
	Pacientes 
. 
FirstOrDefaultAsync -
(- .
p. /
=>0 2
p3 4
.4 5
NumeroDocumento5 D
==E G
numeroDocumentoH W
)W X
;X Y
[ 	
SuppressMessage	 
( 
$str $
,$ %
$str& -
,- .
Justification/ <
== >
$str? q
)q r
]r s
public 
async 
Task 
< 
Paciente 
? 
> !
ObtenerPorCorreoAsync 3
(3 4
string4 :
correoElectronico; L
)L M
=>N P
await 
_db 
. 
	Pacientes 
. 	
Where	 
( 
p 
=> 
p 
. 
CorreoElectronico '
.' (
ToLower( /
(/ 0
)0 1
==2 4
correoElectronico5 F
.F G
ToLowerG N
(N O
)O P
)P Q
. 
FirstOrDefaultAsync $
($ %
)% &
;& '
public 
async 
Task 
RegistrarAsync (
(( )
Paciente) 1
paciente2 :
): ;
{ 	
if 
( 
paciente 
. 
Id 
== 
Guid #
.# $
Empty$ )
)) *
{ 
paciente 
. 
Id 
= 
Guid 
. 
NewGuid "
(" #
)# $
;$ %
}   
_db!! 
.!! 
	Pacientes!! 
.!! 
Add!! 
(!! 
paciente!! 
)!! 
;!!  
await"" 	
_db""
 
."" 
SaveChangesAsync"" 
("" 
)""  
;""  !
}## 
public%% 
async%% 
Task%% 
<%% 
bool%% 
>%% 
ActivarCuentaAsync%%  2
(%%2 3
string%%3 9
tokenVerificacion%%: K
)%%K L
{&& 
var''	 
paciente'' 
='' 
await'' 
_db'' !
.''! "
	Pacientes''" +
.''+ ,
FirstOrDefaultAsync'', ?
(''? @
p''@ A
=>''B D
p''E F
.''F G
TokenVerificacion''G X
==''Y [
tokenVerificacion''\ m
)''m n
;''n o
if(( 
(((	 

paciente((
 
==(( 
null(( 
)(( 
{)) 
return**	 
false** 
;** 
}++ 
paciente,, 	
.,,	 

EstaVerificado,,
 
=,, 
true,, 
;,,  
paciente-- 
.-- 
TokenVerificacion-- 
=--  !
null--" &
;--& '
await.. 
_db.. 
... 
SaveChangesAsync..  
(..  !
)..! "
;.." #
return// 
true// 
;// 
}00 
public22 
async22 
Task22 
<22 
bool22 
>22 
VerificarOTPAsync22 .
(22. /
string22/ 5
correo226 <
,22< =
string22> D
	codigoOTP22E N
)22N O
{33 
var44 
paciente44 
=44 
await44 !
ObtenerPorCorreoAsync44 ,
(44, -
correo44- 3
)443 4
;444 5
if55 
(55 
paciente55 
==55 
null55 
)55 
{66 
return77 
false77 
;77 
}88 
if:: 
(:: 
paciente:: 
.:: 
	CodigoOTP:: "
!=::# %
	codigoOTP::& /
||::0 2
paciente;; 
.;; 
OTPExpiracion;; 
==;;  
null;;! %
||;;& (
DateTime<< 
.<< 
UtcNow<< 
><<  !
paciente<<" *
.<<* +
OTPExpiracion<<+ 8
)<<8 9
{== 
paciente>>
 
.>> 
IntentosOTPFallidos>> &
++>>& (
;>>( )
await?? 
_db?? 
.?? 
SaveChangesAsync?? !
(??! "
)??" #
;??# $
return@@ 
false@@ 
;@@ 
}AA 
pacienteCC 
.CC 
EstaVerificadoCC 
=CC 
trueCC #
;CC# $
pacienteDD 
.DD 
	CodigoOTPDD 
=DD  
nullDD! %
;DD% &
pacienteEE 
.EE 
OTPExpiracionEE "
=EE# $
nullEE% )
;EE) *
pacienteFF 
.FF 
IntentosOTPFallidosFF  
=FF! "
$numFF# $
;FF$ %
awaitGG 
_dbGG 
.GG 
SaveChangesAsyncGG  
(GG  !
)GG! "
;GG" #
returnHH 
trueHH 
;HH 
}II 
publicKK 
asyncKK 
TaskKK 
ActualizarOTPAsyncKK ,
(KK, -
PacienteKK- 5
pacienteKK6 >
)KK> ?
{LL !
ArgumentNullExceptionMM
 
.MM  
ThrowIfNullMM  +
(MM+ ,
pacienteMM, 4
)MM4 5
;MM5 6
_dbOO 
.OO 
	PacientesOO 
.OO 
UpdateOO  
(OO  !
pacienteOO! )
)OO) *
;OO* +
awaitPP	 
_dbPP 
.PP 
SaveChangesAsyncPP #
(PP# $
)PP$ %
;PP% &
}QQ 	
publicTT 
asyncTT 
TaskTT 
<TT 
PacienteTT "
?TT" #
>TT# $,
 ObtenerPorTokenRecuperacionAsyncTT% E
(TTE F
stringTTF L
tokenTTM R
)TTR S
=>TTT V
awaitUU 
_dbUU 
.UU 
	PacientesUU 
.UU  
FirstOrDefaultAsyncUU  3
(UU3 4
pUU4 5
=>UU6 8
pUU9 :
.UU: ;
TokenRecuperacionUU; L
==UUM O
tokenUUP U
)UUU V
;UUV W
publicWW 
asyncWW 
TaskWW ,
 ActualizarTokenRecuperacionAsyncWW :
(WW: ;
PacienteWW; C
pacienteWWD L
)WWL M
{XX !
ArgumentNullExceptionYY	 
.YY 
ThrowIfNullYY *
(YY* +
pacienteYY+ 3
)YY3 4
;YY4 5
if\\ 
(\\ 
string\\ 
.\\ 
IsNullOrEmpty\\ $
(\\$ %
paciente\\% -
.\\- .
TokenRecuperacion\\. ?
)\\? @
)\\@ A
{]] 
throw^^ 	
new^^
 
ArgumentException^^ 
(^^  
$str^^  P
,^^P Q
nameof^^R X
(^^X Y
paciente^^Y a
)^^a b
)^^b c
;^^c d
}__ 
_dbaa 
.aa 
	Pacientesaa 
.aa 
Updateaa  
(aa  !
pacienteaa! )
)aa) *
;aa* +
awaitbb 
_dbbb 
.bb 
SaveChangesAsyncbb !
(bb! "
)bb" #
;bb# $
}cc 
publicee 
asyncee 
Taskee #
ActualizarPasswordAsyncee 1
(ee1 2
Pacienteee2 :
pacienteee; C
)eeC D
{ff 	!
ArgumentNullExceptiongg 
.gg 
ThrowIfNullgg #
(gg# $
pacientegg$ ,
)gg, -
;gg- .
ifjj 
(jj 
stringjj 
.jj 
IsNullOrEmptyjj $
(jj$ %
pacientejj% -
.jj- .
PasswordHashjj. :
)jj: ;
)jj; <
{kk 
throwll 	
newll
 
ArgumentExceptionll 
(ll  
$strll  M
,llM N
nameofllO U
(llU V
pacientellV ^
)ll^ _
)ll_ `
;ll` a
}mm 
_dboo 	
.oo	 

	Pacientesoo
 
.oo 
Updateoo 
(oo 
pacienteoo #
)oo# $
;oo$ %
awaitpp 
_dbpp 
.pp 
SaveChangesAsyncpp &
(pp& '
)pp' (
;pp( )
}qq 	
}rr 
}ss £
vC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Migrations\20251106235209_AgregarRecuperacionPassword.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "

Migrations" ,
{ 
public		 

partial		 
class		 '
AgregarRecuperacionPassword		 4
:		5 6
	Migration		7 @
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
	AddColumn &
<& '
string' -
>- .
(. /
name 
: 
$str )
,) *
table 
: 
$str "
," #
type 
: 
$str -
,- .
	maxLength 
: 
$num 
, 
nullable 
: 
true 
) 
;  
migrationBuilder 
. 
	AddColumn &
<& '
DateTime' /
>/ 0
(0 1
name 
: 
$str 3
,3 4
table 
: 
$str "
," #
type 
: 
$str 0
,0 1
nullable 
: 
true 
) 
;  
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 

DropColumn '
(' (
name   
:   
$str   )
,  ) *
table!! 
:!! 
$str!! "
)!!" #
;!!# $
migrationBuilder## 
.## 

DropColumn## '
(##' (
name$$ 
:$$ 
$str$$ 3
,$$3 4
table%% 
:%% 
$str%% "
)%%" #
;%%# $
}&& 	
}'' 
}(( é
pC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Migrations\20251022032706_ConfigurarDateTimeUTC.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "

Migrations" ,
{ 
public		 

partial		 
class		 !
ConfigurarDateTimeUTC		 .
:		/ 0
	Migration		1 :
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
AlterColumn (
<( )
DateTime) 1
>1 2
(2 3
name 
: 
$str '
,' (
table 
: 
$str "
," #
type 
: 
$str 
, 
nullable 
: 
false 
,  

oldClrType 
: 
typeof "
(" #
DateTime# +
)+ ,
,, -
oldType 
: 
$str 3
)3 4
;4 5
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
AlterColumn (
<( )
DateTime) 1
>1 2
(2 3
name 
: 
$str '
,' (
table 
: 
$str "
," #
type 
: 
$str 0
,0 1
nullable 
: 
false 
,  

oldClrType 
: 
typeof "
(" #
DateTime# +
)+ ,
,, -
oldType   
:   
$str   
)    
;    !
}!! 	
}"" 
}## ¶J
rC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Migrations\20251022031055_AjustarLongitudesCampos.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "

Migrations" ,
{ 
public 

partial 
class #
AjustarLongitudesCampos 0
:1 2
	Migration3 <
{		 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
AlterColumn (
<( )
string) /
>/ 0
(0 1
name 
: 
$str %
,% &
table 
: 
$str "
," #
type 
: 
$str ,
,, -
	maxLength 
: 
$num 
, 
nullable 
: 
false 
,  

oldClrType 
: 
typeof "
(" #
string# )
)) *
,* +
oldType 
: 
$str 
)  
;  !
migrationBuilder 
. 
AlterColumn (
<( )
string) /
>/ 0
(0 1
name 
: 
$str  
,  !
table 
: 
$str "
," #
type 
: 
$str -
,- .
	maxLength 
: 
$num 
, 
nullable 
: 
false 
,  

oldClrType 
: 
typeof "
(" #
string# )
)) *
,* +
oldType 
: 
$str 0
,0 1
oldMaxLength 
: 
$num  
)  !
;! "
migrationBuilder   
.   
AlterColumn   (
<  ( )
string  ) /
>  / 0
(  0 1
name!! 
:!! 
$str!! 
,!! 
table"" 
:"" 
$str"" "
,""" #
type## 
:## 
$str## ,
,##, -
	maxLength$$ 
:$$ 
$num$$ 
,$$ 
nullable%% 
:%% 
false%% 
,%%  

oldClrType&& 
:&& 
typeof&& "
(&&" #
string&&# )
)&&) *
,&&* +
oldType'' 
:'' 
$str'' 
)''  
;''  !
migrationBuilder)) 
.)) 
AlterColumn)) (
<))( )
string))) /
>))/ 0
())0 1
name** 
:** 
$str** $
,**$ %
table++ 
:++ 
$str++ "
,++" #
type,, 
:,, 
$str,, .
,,,. /
	maxLength-- 
:-- 
$num-- 
,-- 
nullable.. 
:.. 
false.. 
,..  

oldClrType// 
:// 
typeof// "
(//" #
string//# )
)//) *
,//* +
oldType00 
:00 
$str00 0
,000 1
oldMaxLength11 
:11 
$num11  
)11  !
;11! "
migrationBuilder33 
.33 
AlterColumn33 (
<33( )
int33) ,
>33, -
(33- .
name44 
:44 
$str44 +
,44+ ,
table55 
:55 
$str55 "
,55" #
type66 
:66 
$str66 
,66  
nullable77 
:77 
false77 
,77  
defaultValue88 
:88 
$num88 
,88  

oldClrType99 
:99 
typeof99 "
(99" #
int99# &
)99& '
,99' (
oldType:: 
::: 
$str:: "
)::" #
;::# $
migrationBuilder<< 
.<< 
AlterColumn<< (
<<<( )
string<<) /
><</ 0
(<<0 1
name== 
:== 
$str== !
,==! "
table>> 
:>> 
$str>> "
,>>" #
type?? 
:?? 
$str?? ,
,??, -
	maxLength@@ 
:@@ 
$num@@ 
,@@ 
nullableAA 
:AA 
trueAA 
,AA 

oldClrTypeBB 
:BB 
typeofBB "
(BB" #
stringBB# )
)BB) *
,BB* +
oldTypeCC 
:CC 
$strCC 
,CC  
oldNullableDD 
:DD 
trueDD !
)DD! "
;DD" #
}EE 	
	protectedHH 
overrideHH 
voidHH 
DownHH  $
(HH$ %
MigrationBuilderHH% 5
migrationBuilderHH6 F
)HHF G
{II 	
migrationBuilderJJ 
.JJ 
AlterColumnJJ (
<JJ( )
stringJJ) /
>JJ/ 0
(JJ0 1
nameKK 
:KK 
$strKK %
,KK% &
tableLL 
:LL 
$strLL "
,LL" #
typeMM 
:MM 
$strMM 
,MM 
nullableNN 
:NN 
falseNN 
,NN  

oldClrTypeOO 
:OO 
typeofOO "
(OO" #
stringOO# )
)OO) *
,OO* +
oldTypePP 
:PP 
$strPP /
,PP/ 0
oldMaxLengthQQ 
:QQ 
$numQQ 
)QQ  
;QQ  !
migrationBuilderSS 
.SS 
AlterColumnSS (
<SS( )
stringSS) /
>SS/ 0
(SS0 1
nameTT 
:TT 
$strTT  
,TT  !
tableUU 
:UU 
$strUU "
,UU" #
typeVV 
:VV 
$strVV -
,VV- .
	maxLengthWW 
:WW 
$numWW 
,WW 
nullableXX 
:XX 
falseXX 
,XX  

oldClrTypeYY 
:YY 
typeofYY "
(YY" #
stringYY# )
)YY) *
,YY* +
oldTypeZZ 
:ZZ 
$strZZ 0
,ZZ0 1
oldMaxLength[[ 
:[[ 
$num[[  
)[[  !
;[[! "
migrationBuilder]] 
.]] 
AlterColumn]] (
<]]( )
string]]) /
>]]/ 0
(]]0 1
name^^ 
:^^ 
$str^^ 
,^^ 
table__ 
:__ 
$str__ "
,__" #
type`` 
:`` 
$str`` 
,`` 
nullableaa 
:aa 
falseaa 
,aa  

oldClrTypebb 
:bb 
typeofbb "
(bb" #
stringbb# )
)bb) *
,bb* +
oldTypecc 
:cc 
$strcc /
,cc/ 0
oldMaxLengthdd 
:dd 
$numdd 
)dd  
;dd  !
migrationBuilderff 
.ff 
AlterColumnff (
<ff( )
stringff) /
>ff/ 0
(ff0 1
namegg 
:gg 
$strgg $
,gg$ %
tablehh 
:hh 
$strhh "
,hh" #
typeii 
:ii 
$strii -
,ii- .
	maxLengthjj 
:jj 
$numjj 
,jj 
nullablekk 
:kk 
falsekk 
,kk  

oldClrTypell 
:ll 
typeofll "
(ll" #
stringll# )
)ll) *
,ll* +
oldTypemm 
:mm 
$strmm 1
,mm1 2
oldMaxLengthnn 
:nn 
$numnn !
)nn! "
;nn" #
migrationBuilderpp 
.pp 
AlterColumnpp (
<pp( )
intpp) ,
>pp, -
(pp- .
nameqq 
:qq 
$strqq +
,qq+ ,
tablerr 
:rr 
$strrr "
,rr" #
typess 
:ss 
$strss 
,ss  
nullablett 
:tt 
falsett 
,tt  

oldClrTypeuu 
:uu 
typeofuu "
(uu" #
intuu# &
)uu& '
,uu' (
oldTypevv 
:vv 
$strvv "
,vv" #
oldDefaultValueww 
:ww  
$numww! "
)ww" #
;ww# $
migrationBuilderyy 
.yy 
AlterColumnyy (
<yy( )
stringyy) /
>yy/ 0
(yy0 1
namezz 
:zz 
$strzz !
,zz! "
table{{ 
:{{ 
$str{{ "
,{{" #
type|| 
:|| 
$str|| 
,|| 
nullable}} 
:}} 
true}} 
,}} 

oldClrType~~ 
:~~ 
typeof~~ "
(~~" #
string~~# )
)~~) *
,~~* +
oldType 
: 
$str /
,/ 0
oldMaxLength
ÄÄ 
:
ÄÄ 
$num
ÄÄ 
,
ÄÄ  
oldNullable
ÅÅ 
:
ÅÅ 
true
ÅÅ !
)
ÅÅ! "
;
ÅÅ" #
}
ÇÇ 	
}
ÉÉ 
}ÑÑ ó
kC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Migrations\20251022023702_AgregarCamposOTP.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "

Migrations" ,
{ 
public		 

partial		 
class		 
AgregarCamposOTP		 )
:		* +
	Migration		, 5
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
	AddColumn &
<& '
string' -
>- .
(. /
name 
: 
$str !
,! "
table 
: 
$str "
," #
type 
: 
$str 
, 
nullable 
: 
true 
) 
;  
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str +
,+ ,
table 
: 
$str "
," #
type 
: 
$str 
,  
nullable 
: 
false 
,  
defaultValue 
: 
$num 
)  
;  !
migrationBuilder 
. 
	AddColumn &
<& '
DateTime' /
>/ 0
(0 1
name 
: 
$str %
,% &
table 
: 
$str "
," #
type 
: 
$str 0
,0 1
nullable 
: 
true 
) 
;  
}   	
	protected## 
override## 
void## 
Down##  $
(##$ %
MigrationBuilder##% 5
migrationBuilder##6 F
)##F G
{$$ 	
migrationBuilder%% 
.%% 

DropColumn%% '
(%%' (
name&& 
:&& 
$str&& !
,&&! "
table'' 
:'' 
$str'' "
)''" #
;''# $
migrationBuilder)) 
.)) 

DropColumn)) '
())' (
name** 
:** 
$str** +
,**+ ,
table++ 
:++ 
$str++ "
)++" #
;++# $
migrationBuilder-- 
.-- 

DropColumn-- '
(--' (
name.. 
:.. 
$str.. %
,..% &
table// 
:// 
$str// "
)//" #
;//# $
}00 	
}11 
}22 Ÿ0
hC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Migrations\20251020203133_InitialCreate.cs
	namespace 	
MedCitas
 
. 
Infrastructure !
.! "

Migrations" ,
{ 
public		 

partial		 
class		 
InitialCreate		 &
:		' (
	Migration		) 2
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str !
,! "
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
Guid& *
>* +
(+ ,
type, 0
:0 1
$str2 8
,8 9
nullable: B
:B C
falseD I
)I J
,J K
NombreCompleto "
=# $
table% *
.* +
Column+ 1
<1 2
string2 8
>8 9
(9 :
type: >
:> ?
$str@ F
,F G
nullableH P
:P Q
falseR W
)W X
,X Y
TipoDocumento !
=" #
table$ )
.) *
Column* 0
<0 1
string1 7
>7 8
(8 9
type9 =
:= >
$str? E
,E F
nullableG O
:O P
falseQ V
)V W
,W X
NumeroDocumento #
=$ %
table& +
.+ ,
Column, 2
<2 3
string3 9
>9 :
(: ;
type; ?
:? @
$strA X
,X Y
	maxLengthZ c
:c d
$nume g
,g h
nullablei q
:q r
falses x
)x y
,y z
FechaNacimiento #
=$ %
table& +
.+ ,
Column, 2
<2 3
DateTime3 ;
>; <
(< =
type= A
:A B
$strC ]
,] ^
nullable_ g
:g h
falsei n
)n o
,o p
Sexo 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
,N O
Telefono 
= 
table $
.$ %
Column% +
<+ ,
string, 2
>2 3
(3 4
type4 8
:8 9
$str: Q
,Q R
	maxLengthS \
:\ ]
$num^ `
,` a
nullableb j
:j k
falsel q
)q r
,r s
CorreoElectronico %
=& '
table( -
.- .
Column. 4
<4 5
string5 ;
>; <
(< =
type= A
:A B
$strC [
,[ \
	maxLength] f
:f g
$numh k
,k l
nullablem u
:u v
falsew |
)| }
,} ~
PasswordHash  
=! "
table# (
.( )
Column) /
</ 0
string0 6
>6 7
(7 8
type8 <
:< =
$str> U
,U V
	maxLengthW `
:` a
$numb d
,d e
nullablef n
:n o
falsep u
)u v
,v w
Eps 
= 
table 
.  
Column  &
<& '
string' -
>- .
(. /
type/ 3
:3 4
$str5 ;
,; <
nullable= E
:E F
falseG L
)L M
,M N

TipoSangre 
=  
table! &
.& '
Column' -
<- .
string. 4
>4 5
(5 6
type6 :
:: ;
$str< B
,B C
nullableD L
:L M
falseN S
)S T
,T U
EstaVerificado "
=# $
table% *
.* +
Column+ 1
<1 2
bool2 6
>6 7
(7 8
type8 <
:< =
$str> G
,G H
nullableI Q
:Q R
falseS X
)X Y
,Y Z
TokenVerificacion %
=& '
table( -
.- .
Column. 4
<4 5
string5 ;
>; <
(< =
type= A
:A B
$strC I
,I J
nullableK S
:S T
trueU Y
)Y Z
,Z [
FechaRegistro !
=" #
table$ )
.) *
Column* 0
<0 1
DateTime1 9
>9 :
(: ;
type; ?
:? @
$strA [
,[ \
nullable] e
:e f
falseg l
)l m
}   
,   
constraints!! 
:!! 
table!! "
=>!!# %
{"" 
table## 
.## 

PrimaryKey## $
(##$ %
$str##% 3
,##3 4
x##5 6
=>##7 9
x##: ;
.##; <
Id##< >
)##> ?
;##? @
}$$ 
)$$ 
;$$ 
}%% 	
	protected(( 
override(( 
void(( 
Down((  $
((($ %
MigrationBuilder((% 5
migrationBuilder((6 F
)((F G
{)) 	
migrationBuilder** 
.** 
	DropTable** &
(**& '
name++ 
:++ 
$str++ !
)++! "
;++" #
},, 	
}-- 
}.. ˜5
YC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\DataDb\MedCitasDbContext.cs
	namespace		 	
MedCitas		
 
.		 
Infrastructure		 !
.		! "
DataDb		" (
{

 
public 

class 
MedCitasDbContext "
:# $
	DbContext% .
{ 
public 
MedCitasDbContext  
(  !
DbContextOptions! 1
<1 2
MedCitasDbContext2 C
>C D
optionsE L
)L M
:N O
baseP T
(T U
optionsU \
)\ ]
{^ _
}` a
public 
DbSet 
< 
Paciente 
> 
	Pacientes (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
null9 =
!= >
;> ?
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
modelBuilder 
. 
Entity 
<  
Paciente  (
>( )
() *
entity* 0
=>1 3
{ 
entity 
. 
HasKey 
( 
e 
=>  "
e# $
.$ %
Id% '
)' (
;( )
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
NombreCompleto' 5
)5 6
.6 7

IsRequired7 A
(A B
)B C
;C D
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
TipoDocumento' 4
)4 5
.5 6

IsRequired6 @
(@ A
)A B
.B C
HasMaxLengthC O
(O P
$numP Q
)Q R
;R S
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
NumeroDocumento' 6
)6 7
.7 8

IsRequired8 B
(B C
)C D
.D E
HasMaxLengthE Q
(Q R
$numR T
)T U
;U V
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
FechaNacimiento' 6
)6 7
. 

IsRequired 
(  
)  !
. 
HasColumnType "
(" #
$str# )
)) *
;* +
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
Sexo' +
)+ ,
., -

IsRequired- 7
(7 8
)8 9
.9 :
HasMaxLength: F
(F G
$numG H
)H I
;I J
entity   
.   
Property   
(    
e    !
=>  " $
e  % &
.  & '
Telefono  ' /
)  / 0
.  0 1

IsRequired  1 ;
(  ; <
)  < =
.  = >
HasMaxLength  > J
(  J K
$num  K M
)  M N
;  N O
entity!! 
.!! 
Property!! 
(!!  
e!!  !
=>!!" $
e!!% &
.!!& '
CorreoElectronico!!' 8
)!!8 9
.!!9 :

IsRequired!!: D
(!!D E
)!!E F
.!!F G
HasMaxLength!!G S
(!!S T
$num!!T W
)!!W X
;!!X Y
entity"" 
."" 
Property"" 
(""  
e""  !
=>""" $
e""% &
.""& '
PasswordHash""' 3
)""3 4
.""4 5
HasMaxLength""5 A
(""A B
$num""B E
)""E F
;""F G
entity## 
.## 
Property## 
(##  
e##  !
=>##" $
e##% &
.##& '
Eps##' *
)##* +
.##+ ,

IsRequired##, 6
(##6 7
)##7 8
;##8 9
entity$$ 
.$$ 
Property$$ 
($$  
e$$  !
=>$$" $
e$$% &
.$$& '

TipoSangre$$' 1
)$$1 2
.$$2 3

IsRequired$$3 =
($$= >
)$$> ?
;$$? @
entity%% 
.%% 
Property%% 
(%%  
e%%  !
=>%%" $
e%%% &
.%%& '
EstaVerificado%%' 5
)%%5 6
;%%6 7
entity&& 
.&& 
Property&& 
(&&  
e&&  !
=>&&" $
e&&% &
.&&& '
TokenVerificacion&&' 8
)&&8 9
;&&9 :
entity)) 
.)) 
Property)) 
())  
e))  !
=>))" $
e))% &
.))& '
FechaRegistro))' 4
)))4 5
.** 
HasColumnType** "
(**" #
$str**# =
)**= >
;**> ?
entity,, 
.,, 
Property,, 
(,,  
e,,  !
=>,," $
e,,% &
.,,& '
	CodigoOTP,,' 0
),,0 1
.,,1 2
HasMaxLength,,2 >
(,,> ?
$num,,? @
),,@ A
;,,A B
entity// 
.// 
Property// 
(//  
e//  !
=>//" $
e//% &
.//& '
OTPExpiracion//' 4
)//4 5
.00 
HasColumnType00 "
(00" #
$str00# =
)00= >
;00> ?
entity22 
.22 
Property22 
(22  
e22  !
=>22" $
e22% &
.22& '
IntentosOTPFallidos22' :
)22: ;
.22; <
HasDefaultValue22< K
(22K L
$num22L M
)22M N
;22N O
entity55 
.55 
Property55 
(55  
e55  !
=>55" $
e55% &
.55& '
TokenRecuperacion55' 8
)558 9
.559 :
HasMaxLength55: F
(55F G
$num55G I
)55I J
;55J K
entity66 
.66 
Property66 
(66  
e66  !
=>66" $
e66% &
.66& ''
TokenRecuperacionExpiracion66' B
)66B C
.77 
HasColumnType77 "
(77" #
$str77# =
)77= >
;77> ?
}88 
)88 
;88 
base:: 
.:: 
OnModelCreating::  
(::  !
modelBuilder::! -
)::- .
;::. /
};; 	
}<< 
}== 
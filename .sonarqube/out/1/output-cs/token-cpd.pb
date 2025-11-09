¬Ñ
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
$str C
,C D
_configE L
.L M
GetValidationErrorsM `
(` a
)a b
)b c
;c d
}	 

else 
{ 
_logger	 
. 
LogInformation 
(  
$str  I
)I J
;J K
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
$str>> C
,>>C D
destinatario>>E Q
,>>Q R
asunto>>S Y
)>>Y Z
;>>Z [
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
$strDD I
,DDI J
erroresDDK R
)DDR S
;DDS T
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
$str`` F
,``F G
destinatario``H T
)``T U
;``U V
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
$strdd d
,ddd e
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
$strjj% a
,jja b
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
¶ß' T
{
ßßT U
AppConstants
ßßU a
.
ßßa b
Otp
ßßb e
.
ßße f
ExpirationMinutes
ßßf w
}
ßßw x
$str
ß¨x 
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
∆«= O
{
««O P
AppConstants
««P \
.
««\ ]
RecoveryToken
««] j
.
««j k
ExpirationMinutes
««k |
}
««| }
$str
«Ã} 
"
ÃÃ 
;
ÃÃ 	
}
ÕÕ 
public
œœ 
async
œœ 
Task
œœ 5
'EnviarNotificacionCambiosSensiblesAsync
œœ A
(
œœA B
string
œœB H
correo
œœI O
,
œœO P
string
œœQ W
nombreCompleto
œœX f
)
œœf g
{
–– 
var
—— 
asunto
—— 
=
—— 
$str
—— :
;
——: ;
var
““ 


cuerpoHtml
““ 
=
““ )
GenerarHtmlCambiosSensibles
““ 3
(
““3 4
nombreCompleto
““4 B
)
““B C
;
““C D
await
”” 
EnviarEmailAsync
”” 
(
”” 
correo
”” 
,
”” 
asunto
””  &
,
””& '

cuerpoHtml
””( 2
)
””2 3
;
””3 4
}
‘‘ 
public
÷÷ 
async
÷÷ 
Task
÷÷ )
EnviarConfirmacionCitaAsync
÷÷ 5
(
÷÷5 6
string
◊◊ 
correo
◊◊ 
,
◊◊ 
string
ÿÿ 

nombrePaciente
ÿÿ 
,
ÿÿ 
string
ŸŸ
 
nombreDoctor
ŸŸ 
,
ŸŸ 
string
⁄⁄ 

especialidad
⁄⁄ 
,
⁄⁄ 
DateTime
€€
 
	fechaCita
€€ 
,
€€ 
TimeSpan
‹‹ 
horaCita
‹‹ 
)
‹‹ 
{
›› 
var
ﬁﬁ 
asunto
ﬁﬁ 
=
ﬁﬁ 
$str
ﬁﬁ A
;
ﬁﬁA B
var
ﬂﬂ 

cuerpoHtml
ﬂﬂ 
=
ﬂﬂ )
GenerarHtmlConfirmacionCita
ﬂﬂ 8
(
ﬂﬂ8 9
nombrePaciente
ﬂﬂ9 G
,
ﬂﬂG H
nombreDoctor
ﬂﬂI U
,
ﬂﬂU V
especialidad
ﬂﬂW c
,
ﬂﬂc d
	fechaCita
ﬂﬂe n
,
ﬂﬂn o
horaCita
ﬂﬂp x
)
ﬂﬂx y
;
ﬂﬂy z
await
‡‡ 
EnviarEmailAsync
‡‡ "
(
‡‡" #
correo
‡‡# )
,
‡‡) *
asunto
‡‡+ 1
,
‡‡1 2

cuerpoHtml
‡‡3 =
)
‡‡= >
;
‡‡> ?
}
·· 	
public
„„ 
async
„„ 
Task
„„ 0
"EnviarNotificacionCancelacionAsync
„„ <
(
„„< =
string
‰‰ 
correo
‰‰ 
,
‰‰ 
string
ÂÂ 
nombrePaciente
ÂÂ !
,
ÂÂ! "
string
ÊÊ 
nombreDoctor
ÊÊ 
,
ÊÊ  
string
ÁÁ 

especialidad
ÁÁ 
,
ÁÁ 
DateTime
ËË 
	fechaCita
ËË 
,
ËË 
TimeSpanÈÈ 
horaCita
ÈÈ	 
)
ÈÈ 
{
ÍÍ 
var
ÎÎ 
asunto
ÎÎ 
=
ÎÎ 
$str
ÎÎ 4
;
ÎÎ4 5
var
ÏÏ
 

cuerpoHtml
ÏÏ 
=
ÏÏ (
GenerarHtmlCancelacionCita
ÏÏ 5
(
ÏÏ5 6
nombrePaciente
ÏÏ6 D
,
ÏÏD E
nombreDoctor
ÏÏF R
,
ÏÏR S
especialidad
ÏÏT `
,
ÏÏ` a
	fechaCita
ÏÏb k
,
ÏÏk l
horaCita
ÏÏm u
)
ÏÏu v
;
ÏÏv w
await
ÌÌ 
EnviarEmailAsync
ÌÌ 
(
ÌÌ 
correo
ÌÌ #
,
ÌÌ# $
asunto
ÌÌ% +
,
ÌÌ+ ,

cuerpoHtml
ÌÌ- 7
)
ÌÌ7 8
;
ÌÌ8 9
}
ÓÓ 	
private
 
static
 
string
 )
GenerarHtmlCambiosSensibles
 9
(
9 :
string
: @
nombreCompleto
A O
)
O P
{
ÒÒ 	
return
ÚÚ 
$@"
ÚÚ 
$str
ÚÑ 
{
ÑÑ 
nombreCompleto
ÑÑ 
}
ÑÑ 
$str
Ñí 
"
íí 
;
íí 	
}
ìì 
private
ïï 
static
ïï 
string
ïï )
GenerarHtmlConfirmacionCita
ïï 9
(
ïï9 :
string
ññ 
nombrePaciente
ññ 
,
ññ 
string
óó 
nombreDoctor
óó 
,
óó 
string
òò 
especialidad
òò	 
,
òò 
DateTime
ôô 
	fechaCita
ôô 
,
ôô 
TimeSpan
öö 
horaCita
öö 
)
öö 
{
õõ 
return
úú 
$@"
úú 
$str
úÆ 
{
ÆÆ 
nombrePaciente
ÆÆ %
}
ÆÆ% &
$str
Æ±&  
{
±±  !
	fechaCita
±±! *
:
±±* +
$str
±±+ =
}
±±= >
$str
±≤> 
{
≤≤ 
horaCita
≤≤ '
:
≤≤' (
$str
≤≤( /
}
≤≤/ 0
$str
≤≥0 $
{
≥≥$ %
nombreDoctor
≥≥% 1
}
≥≥1 2
$str
≥¥2 (
{
¥¥( )
especialidad
¥¥) 5
}
¥¥5 6
$str
¥ª6 
"
ªª 
;
ªª 	
}
ºº 
private
ææ 
static
ææ 
string
ææ (
GenerarHtmlCancelacionCita
ææ 8
(
ææ8 9
string
øø 
nombrePaciente
øø	 
,
øø 
string
¿¿ 
nombreDoctor
¿¿ 
,
¿¿  
string
¡¡ 	
especialidad
¡¡
 
,
¡¡ 
DateTime
¬¬ 
	fechaCita
¬¬ 
,
¬¬ 
TimeSpan
√√ 
horaCita
√√ 
)
√√ 
{
ƒƒ 	
return
≈≈ 
$@"
≈≈ 
$str
≈◊ 
{
◊◊ 
nombrePaciente
◊◊  
}
◊◊  !
$str
◊⁄! *
{
⁄⁄* +
	fechaCita
⁄⁄+ 4
:
⁄⁄4 5
$str
⁄⁄5 G
}
⁄⁄G H
$str
⁄€H !
{
€€! "
horaCita
€€" *
:
€€* +
$str
€€+ 2
}
€€2 3
$str
€‹3 (
{
‹‹( )
nombreDoctor
‹‹) 5
}
‹‹5 6
$str
‹›6 .
{
››. /
especialidad
››/ ;
}
››; <
$str
›‰< 
"
‰‰ 
;
‰‰ 	
}
ÂÂ 
}
ÊÊ 
}ÁÁ ä
cC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Repositories\EfSpecialtyRepository.cs
	namespace

 	
MedCitas


 
.

 
Infrastructure

 !
.

! "
Repositories

" .
{ 
public 

class !
EfSpecialtyRepository &
:' ( 
ISpecialtyRepository) =
{ 
private 

readonly 
MedCitasDbContext %
_db& )
;) *
public !
EfSpecialtyRepository $
($ %
MedCitasDbContext% 6
db7 9
)9 :
=>; =
_db> A
=B C
dbD F
;F G
public 
async 
Task 
< 
	Specialty #
?# $
>$ %
ObtenerPorIdAsync& 7
(7 8
Guid8 <
id= ?
)? @
=>A C
await 
_db 
. 
Specialties 
. 
FirstOrDefaultAsync /
(/ 0
s0 1
=>2 4
s5 6
.6 7
Id7 9
==: <
id= ?
)? @
;@ A
public 
async	 
Task 
< 
List 
< 
	Specialty "
>" #
># $
ObtenerTodasAsync% 6
(6 7
)7 8
=>9 ;
await 
_db 
. 
Specialties 
.
 
Where 
( 
s 
=> 
s 
. 

EstaActiva "
)" #
. 
OrderBy 
( 
s 
=> 
s 
. 
Nombre 
) 
. 
ToListAsync 
( 
) 
; 
} 
} ∫O
cC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Repositories\EfPacienteRepositorio.cs
	namespace

 	
MedCitas


 
.

 
Infrastructure

 !
.

! "
Repositories

" .
{ 
public 

class !
EfPacienteRepositorio &
:' (
IPacienteRepository) <
{ 
private 
readonly 
MedCitasDbContext (
_db) ,
;, -
public !
EfPacienteRepositorio	 
( 
MedCitasDbContext 0
db1 3
)3 4
=>5 7
_db8 ;
=< =
db> @
;@ A
public 	
async
 
Task 
< 
Paciente 
? 
> 
ObtenerPorIdAsync  1
(1 2
Guid2 6
id7 9
)9 :
=>; =
await 
_db	 
. 
	Pacientes 
. 
FirstOrDefaultAsync *
(* +
p+ ,
=>- /
p0 1
.1 2
Id2 4
==5 7
id8 :
): ;
;; <
public 
async	 
Task 
< 
Paciente 
? 
> $
ObtenerPorDocumentoAsync 7
(7 8
string8 >
numeroDocumento? N
)N O
=>P R
await 

_db 
. 
	Pacientes 
. 
FirstOrDefaultAsync ,
(, -
p- .
=>/ 1
p2 3
.3 4
NumeroDocumento4 C
==D F
numeroDocumentoG V
)V W
;W X
[ 
SuppressMessage 
( 
$str #
,# $
$str% -
,- .
Justification/ <
== >
$str? w
)w x
]x y
public 
async 
Task 
< 
Paciente "
?" #
># $!
ObtenerPorCorreoAsync% :
(: ;
string; A
correoElectronicoB S
)S T
=>U W
await 
_db 
. 
	Pacientes 
. 
FirstOrDefaultAsync 
( 
p 
=> 
p 
.  
CorreoElectronico  1
.1 2
ToLower2 9
(9 :
): ;
==< >
correoElectronico? P
.P Q
ToLowerQ X
(X Y
)Y Z
)Z [
;[ \
public 
async 
Task 
RegistrarAsync !
(! "
Paciente" *
paciente+ 3
)3 4
{   
if!! 
(!! 
paciente!! 
.!! 
Id!! 
==!! 
Guid!! 
.!! 
Empty!!  
)!!  !
{"" 
paciente## 	
.##	 

Id##
 
=## 
Guid## 
.## 
NewGuid## 
(## 
)## 
;## 
}$$ 
_db%% 
.%% 
	Pacientes%% 
.%% 
Add%% 
(%% 
paciente%% 
)%% 
;%%  
await&& 	
_db&&
 
.&& 
SaveChangesAsync&& 
(&& 
)&&  
;&&  !
}'' 
public)) 
async)) 
Task)) 
<)) 
bool)) 
>)) 
ActivarCuentaAsync))  2
())2 3
string))3 9
tokenVerificacion)): K
)))K L
{** 
var++ 
paciente++ 
=++ 
await++ 
_db++ 
.++ 
	Pacientes++ #
.++# $
FirstOrDefaultAsync++$ 7
(++7 8
p++8 9
=>++: <
p++= >
.++> ?
TokenVerificacion++? P
==++Q S
tokenVerificacion++T e
)++e f
;++f g
if,, 
(,, 
paciente,, 
==,, 
null,, 
),, 
{-- 
return.. 

false.. 
;.. 
}// 
paciente00 	
.00	 

EstaVerificado00
 
=00 
true00 
;00  
paciente11 

.11
 
TokenVerificacion11 
=11 
null11 #
;11# $
await22 
_db22 
.22 
SaveChangesAsync22  
(22  !
)22! "
;22" #
return33 	
true33
 
;33 
}44 
public66 
async66 
Task66 
<66 
bool66 
>66 
VerificarOTPAsync66 .
(66. /
string66/ 5
correo666 <
,66< =
string66> D
	codigoOTP66E N
)66N O
{77 
var88 
paciente88 
=88 
await88 !
ObtenerPorCorreoAsync88 ,
(88, -
correo88- 3
)883 4
;884 5
if99 
(99 
paciente99 
==99 
null99 
)99 
{:: 
return;; 
false;; 
;;; 
}<< 
if>> 
(>> 
paciente>> 
.>> 
	CodigoOTP>> 
!=>> 
	codigoOTP>> '
||>>( *
paciente?? 
.?? 
OTPExpiracion?? 
==??  
null??! %
||??& (
DateTime@@ 
.@@ 
UtcNow@@ 
>@@ 
paciente@@ 
.@@  
OTPExpiracion@@  -
)@@- .
{AA 
pacienteBB 
.BB 
IntentosOTPFallidosBB  
++BB  "
;BB" #
awaitCC 
_dbCC 

.CC
 
SaveChangesAsyncCC 
(CC 
)CC 
;CC 
returnDD 
falseDD 
;DD 
}EE 
pacienteGG 
.GG 
EstaVerificadoGG 
=GG 
trueGG #
;GG# $
pacienteHH	 
.HH 
	CodigoOTPHH 
=HH 
nullHH "
;HH" #
pacienteII 
.II 
OTPExpiracionII 
=II 
nullII "
;II" #
pacienteJJ 
.JJ 
IntentosOTPFallidosJJ  
=JJ! "
$numJJ# $
;JJ$ %
awaitKK 
_dbKK 
.KK 
SaveChangesAsyncKK  
(KK  !
)KK! "
;KK" #
returnLL 
trueLL	 
;LL 
}MM 
publicPP 
asyncPP 
TaskPP 
ActualizarAsyncPP )
(PP) *
PacientePP* 2
pacientePP3 ;
)PP; <
{QQ !
ArgumentNullExceptionRR 
.RR 
ThrowIfNullRR '
(RR' (
pacienteRR( 0
)RR0 1
;RR1 2
_dbTT 
.TT 
	PacientesTT 
.TT 
UpdateTT 
(TT 
pacienteTT  
)TT  !
;TT! "
awaitUU 	
_dbUU
 
.UU 
SaveChangesAsyncUU 
(UU 
)UU  
;UU  !
}VV 
publicYY 
asyncYY	 
TaskYY 
ActualizarOTPAsyncYY &
(YY& '
PacienteYY' /
pacienteYY0 8
)YY8 9
{ZZ !
ArgumentNullException[[ 
.[[ 
ThrowIfNull[[ &
([[& '
paciente[[' /
)[[/ 0
;[[0 1
await\\ 

ActualizarAsync\\ 
(\\ 
paciente\\ #
)\\# $
;\\$ %
}]] 	
public`` 
async`` 
Task`` 
<`` 
Paciente`` "
?``" #
>``# $,
 ObtenerPorTokenRecuperacionAsync``% E
(``E F
string``F L
token``M R
)``R S
=>``T V
awaitaa 	
_dbaa
 
.aa 
	Pacientesaa 
.aa 
FirstOrDefaultAsyncaa +
(aa+ ,
paa, -
=>aa. 0
paa1 2
.aa2 3
TokenRecuperacionaa3 D
==aaE G
tokenaaH M
)aaM N
;aaN O
publicdd 
asyncdd 
Taskdd ,
 ActualizarTokenRecuperacionAsyncdd 7
(dd7 8
Pacientedd8 @
pacienteddA I
)ddI J
{ee !
ArgumentNullExceptionff	 
.ff 
ThrowIfNullff *
(ff* +
pacienteff+ 3
)ff3 4
;ff4 5
ifii 
(ii 
stringii 
.ii 
IsNullOrEmptyii 
(ii 
pacienteii #
.ii# $
TokenRecuperacionii$ 5
)ii5 6
)ii6 7
{jj 
throwkk 	
newkk
 
ArgumentExceptionkk 
(kk  
$strkk  P
,kkP Q
nameofkkR X
(kkX Y
pacientekkY a
)kka b
)kkb c
;kkc d
}ll 
awaitnn 
ActualizarAsyncnn 
(nn 
pacientenn  
)nn  !
;nn! "
}oo 
publicrr 
asyncrr	 
Taskrr #
ActualizarPasswordAsyncrr +
(rr+ ,
Pacienterr, 4
pacienterr5 =
)rr= >
{ss 	!
ArgumentNullExceptiontt 
.tt 
ThrowIfNulltt #
(tt# $
pacientett$ ,
)tt, -
;tt- .
ifww 
(ww 
stringww 
.ww 
IsNullOrEmptyww 
(ww 
pacienteww "
.ww" #
PasswordHashww# /
)ww/ 0
)ww0 1
{xx 
throwyy 	
newyy
 
ArgumentExceptionyy 
(yy  
$stryy  M
,yyM N
nameofyyO U
(yyU V
pacienteyyV ^
)yy^ _
)yy_ `
;yy` a
}zz 
await|| 
ActualizarAsync||	 
(|| 
paciente|| !
)||! "
;||" #
}}} 
}~~ 
} ò
`C:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Repositories\EfDoctorRepository.cs
	namespace

 	
MedCitas


 
.

 
Infrastructure

 !
.

! "
Repositories

" .
{ 
public 

class 
EfDoctorRepository #
:$ %
IDoctorRepository& 7
{ 
private 
readonly 
MedCitasDbContext *
_db+ .
;. /
public 
EfDoctorRepository !
(! "
MedCitasDbContext" 3
db4 6
)6 7
=>8 :
_db; >
=? @
dbA C
;C D
public 
async 
Task 
< 
Doctor  
?  !
>! "
ObtenerPorIdAsync# 4
(4 5
Guid5 9
id: <
)< =
=>> @
await 
_db 
. 
Doctors 
. 
Include 
( 
d 
=> 
d 
. 
	Specialty  
)  !
. 
FirstOrDefaultAsync $
($ %
d% &
=>' )
d* +
.+ ,
Id, .
==/ 1
id2 4
)4 5
;5 6
public 
async 
Task 
< 
List 
< 
Doctor %
>% &
>& '
ObtenerTodosAsync( 9
(9 :
): ;
=>< >
await 
_db 	
.	 

Doctors
 
. 
Include 	
(	 

d
 
=> 
d 
. 
	Specialty 
) 
. 
Where 
( 
d 
=> 
d 
. 

EstaActivo 
) 
. 
OrderBy 

(
 
d 
=> 
d 
. 
NombreCompleto  
)  !
. 
ToListAsync 
( 
) 
; 
public 	
async
 
Task 
< 
List 
< 
Doctor  
>  !
>! "'
ObtenerPorEspecialidadAsync# >
(> ?
Guid? C
especialidadIdD R
)R S
=>T V
await 
_db 

.
 
Doctors 
.   
Include   
(   
d   
=>   
d   
.    
	Specialty    )
)  ) *
.!! 
Where!! 
(!! 
d!! 
=>!! 
d!! 
.!! 
SpecialtyId!! $
==!!% '
especialidadId!!( 6
&&!!7 9
d!!: ;
.!!; <

EstaActivo!!< F
)!!F G
."" 
OrderBy"" 
("" 
d"" 
=>"" 
d"" 
.""  
NombreCompleto""  .
)"". /
.## 
ToListAsync## 
(## 
)## 
;## 
}$$ 
}%% ∂p
eC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Repositories\EfAppointmentRepository.cs
	namespace

 	
MedCitas


 
.

 
Infrastructure

 !
.

! "
Repositories

" .
{ 
public 

class #
EfAppointmentRepository (
:) *"
IAppointmentRepository+ A
{ 
private 
readonly	 
MedCitasDbContext #
_db$ '
;' (
public #
EfAppointmentRepository &
(& '
MedCitasDbContext' 8
db9 ;
); <
=>= ?
_db@ C
=D E
dbF H
;H I
public 
async 
Task 
< 
Appointment #
?# $
>$ %
ObtenerPorIdAsync& 7
(7 8
Guid8 <
id= ?
)? @
=>A C
await 
_db 
. 
Appointments 
. 
Include 
( 
a 
=> 
a 
. 
Paciente #
)# $
. 
Include 
( 
a 
=> 
a 
. 
Doctor 
) 
. 
Include 
( 
a 
=> 
a 
. 
	Specialty  
)  !
. 
FirstOrDefaultAsync 
( 
a 
=>  
a! "
." #
Id# %
==& (
id) +
)+ ,
;, -
public 
async 
Task 
< 
List 
< 
Appointment (
>( )
>) *#
ObtenerPorPacienteAsync+ B
(B C
Guid 	

pacienteId
 
, 
string 
? 
estado 
= 
null 
, 
DateTime 
? 
desde 
= 
null 
, 
DateTime 
? 
hasta 
= 
null 
) 
{ 
var 
query	 
= 
_db 
. 
Appointments !
.   
Include   
(   
a   
=>   
a   
.    
Doctor    &
)  & '
.!! 
Include!! 
(!! 
a!! 
=>!! 
a!! 
.!! 
	Specialty!! 
)!! 
."" 
Where"" 
("" 
a"" 
=>"" 
a"" 
."" 

PacienteId"" 
==""  

pacienteId""! +
)""+ ,
;"", -
if$$ 
($$ 
!$$ 
string$$ 
.$$ 
IsNullOrWhiteSpace$$ !
($$! "
estado$$" (
)$$( )
)$$) *
{%% 
query&& 
=&& 
query&& 
.&& 
Where&& 
(&& 
a&& 
=>&& 
a&&  !
.&&! "
Estado&&" (
.&&( )
Equals&&) /
(&&/ 0
estado&&0 6
,&&6 7
StringComparison&&8 H
.&&H I
OrdinalIgnoreCase&&I Z
)&&Z [
)&&[ \
;&&\ ]
}'' 
if)) 
())	 

desde))
 
.)) 
HasValue)) 
))) 
{** 
query++ 
=++ 	
query++
 
.++ 
Where++ 
(++ 
a++ 
=>++ 
a++ 
.++ 
	FechaCita++ &
>=++' )
desde++* /
.++/ 0
Value++0 5
)++5 6
;++6 7
},, 
if.. 
(..	 

hasta..
 
... 
HasValue.. 
).. 
{// 
query00 
=00 	
query00
 
.00 
Where00 
(00 
a00 
=>00 
a00 
.00 
	FechaCita00 &
<=00' )
hasta00* /
.00/ 0
Value000 5
)005 6
;006 7
}11 
return33	 
await33 
query33 
.44 
OrderBy44 
(44 
a44 
=>44 
a44 
.44 
	FechaCita44 
)44 
.55 
ThenBy55 
(55 
a55 
=>55 
a55 
.55 

HoraInicio55 
)55 
.66 
ToListAsync66 
(66 
)66 
;66 
}77 
public99 
async99 
Task99 
<99 
List99 
<99 
TimeSlot99 '
>99' (
>99( )&
ObtenerDisponibilidadAsync99* D
(99D E
Guid99E I
doctorId99J R
,99R S
DateTime99T \
fecha99] b
)99b c
{:: 
var<< 	
citasDelDia<<
 
=<< 
await<< 
_db<< !
.<<! "
Appointments<<" .
.== 
Where== 	
(==	 

a==
 
=>== 
a== 
.== 
DoctorId== 
==== 
doctorId== %
&&==& (
a>> 
.>> 
	FechaCita>> 
.>> 
Date>> 
==>> 
fecha>> 
.>> 
Date>>  
&&>>! #
a?? 
.?? 
Estado?? 
==?? 
$str?? $
)??$ %
.@@ 
OrderBy@@ 
(@@ 
a@@ 
=>@@ 
a@@ 
.@@ 

HoraInicio@@ !
)@@! "
.AA
 
ToListAsyncAA 
(AA 
)AA 
;AA 
varDD 
slotsDD	 
=DD 
newDD 
ListDD 
<DD 
TimeSlotDD "
>DD" #
(DD# $
)DD$ %
;DD% &
varEE 

horaInicioEE 
=EE 
newEE 
TimeSpanEE !
(EE! "
$numEE" #
,EE# $
$numEE% &
,EE& '
$numEE( )
)EE) *
;EE* +
varFF 	
horaFinFF
 
=FF 
newFF 
TimeSpanFF  
(FF  !
$numFF! #
,FF# $
$numFF% &
,FF& '
$numFF( )
)FF) *
;FF* +
whileHH 	
(HH
 

horaInicioHH 
<HH 
horaFinHH 
)HH  
{II 	
varJJ	 
slotFinJJ 
=JJ 

horaInicioJJ !
.JJ! "
AddJJ" %
(JJ% &
TimeSpanJJ& .
.JJ. /
FromMinutesJJ/ :
(JJ: ;
$numJJ; =
)JJ= >
)JJ> ?
;JJ? @
varKK 
estaOcupadoKK 
=KK 
citasDelDiaKK !
.KK! "
AnyKK" %
(KK% &
cKK& '
=>KK( *
(LL 	

horaInicioLL	 
>=LL 
cLL 
.LL 

HoraInicioLL #
&&LL$ &

horaInicioLL' 1
<LL2 3
cLL4 5
.LL5 6
HoraFinLL6 =
)LL= >
||LL? A
(MM 
slotFinMM 
>MM 
cMM 
.MM 

HoraInicioMM 
&&MM 
slotFinMM  '
<=MM( *
cMM+ ,
.MM, -
HoraFinMM- 4
)MM4 5
||MM6 8
(NN 

horaInicioNN 
<=NN 
cNN 
.NN 

HoraInicioNN !
&&NN" $
slotFinNN% ,
>=NN- /
cNN0 1
.NN1 2
HoraFinNN2 9
)NN9 :
)NN: ;
;NN; <
slotsPP 
.PP 
AddPP 
(PP 
newPP 
TimeSlotPP !
{QQ 

HoraInicioRR 
=RR 

horaInicioRR 
,RR 
HoraFinSS 
=SS 
slotFinSS 
,SS 
EstaDisponibleTT 
=TT 
!TT 
estaOcupadoTT 
}UU 
)UU 
;UU 

horaInicioWW 
=WW 
slotFinWW 
;WW 
}XX 
returnZZ 

slotsZZ 
;ZZ 
}[[ 
public]] 
async]] 
Task]] 
<]] 
bool]] 
>]] &
ValidarDisponibilidadAsync]]  :
(]]: ;
Guid^^ 
doctorId^^ 
,^^ 
DateTime__ 

fecha__ 
,__ 
TimeSpan`` 

horaInicio`` 
,`` 
TimeSpanaa 
horaFinaa 
)aa 
{bb 
varcc 
citaExistentecc 
=cc 
awaitcc 
_dbcc  
.cc  !
Appointmentscc! -
.dd 
Wheredd 
(dd 
add 
=>dd 
add 
.dd 
DoctorIddd 
==dd  
doctorIddd! )
&&dd* ,
aee 
.ee 
	FechaCitaee 
.ee 
Dateee 
==ee 
fechaee 
.ee  
Dateee  $
&&ee% '
aff 
.ff 
Estadoff 
==ff 
$strff 
)ff 
.gg 	
AnyAsyncgg	 
(gg 
agg 
=>gg 
(hh 

horaIniciohh 
>=hh 
ahh 
.hh 

HoraIniciohh !
&&hh" $

horaIniciohh% /
<hh0 1
ahh2 3
.hh3 4
HoraFinhh4 ;
)hh; <
||hh= ?
(ii
 
horaFinii 
>ii 
aii 
.ii 

HoraInicioii !
&&ii" $
horaFinii% ,
<=ii- /
aii0 1
.ii1 2
HoraFinii2 9
)ii9 :
||ii; =
(jj 

horaIniciojj 
<=jj 
ajj 
.jj 

HoraIniciojj "
&&jj# %
horaFinjj& -
>=jj. 0
ajj1 2
.jj2 3
HoraFinjj3 :
)jj: ;
)jj; <
;jj< =
returnll 

!ll 
citaExistentell 
;ll 
}mm 	
publicoo 	
asyncoo
 
Taskoo 
<oo 
booloo 
>oo +
PacienteTieneCitaEnHorarioAsyncoo :
(oo: ;
Guidpp 

pacienteIdpp	 
,pp 
DateTimeqq 

fechaqq 
,qq 
TimeSpanrr 

horaIniciorr 
,rr 
TimeSpanss 	
horaFinss
 
)ss 
{tt 	
returnuu 	
awaituu
 
_dbuu 
.uu 
Appointmentsuu  
.vv 
Wherevv 
(vv 
avv 
=>vv 
avv 
.vv 

PacienteIdvv 
==vv !

pacienteIdvv" ,
&&vv- /
aww 
.ww 
	FechaCitaww 
.ww 
Dateww 
==ww 
fechaww 
.ww 
Dateww #
&&ww$ &
axx 
.xx 
Estadoxx 
==xx 
$strxx 
)xx 
.yy 
AnyAsyncyy 
(yy 
ayy 
=>yy 
(zz 

horaIniciozz 
>=zz 
azz 
.zz 

HoraIniciozz "
&&zz# %

horaIniciozz& 0
<zz1 2
azz3 4
.zz4 5
HoraFinzz5 <
)zz< =
||zz> @
({{ 
horaFin{{ 
>{{ 
a{{ 
.{{ 

HoraInicio{{ $
&&{{% '
horaFin{{( /
<={{0 2
a{{3 4
.{{4 5
HoraFin{{5 <
){{< =
||{{> @
(|| 

horaInicio|| 
<=|| 
a|| 
.|| 

HoraInicio||  
&&||! #
horaFin||$ +
>=||, .
a||/ 0
.||0 1
HoraFin||1 8
)||8 9
)||9 :
;||: ;
}}} 
public 
async 
Task 

CrearAsync $
($ %
Appointment% 0
appointment1 <
)< =
{
ÄÄ 	!
ArgumentNullExceptionÅÅ 
.
ÅÅ 
ThrowIfNull
ÅÅ !
(
ÅÅ! "
appointment
ÅÅ" -
)
ÅÅ- .
;
ÅÅ. /
_db
ÉÉ 
.
ÉÉ 	
Appointments
ÉÉ	 
.
ÉÉ 
Add
ÉÉ 
(
ÉÉ 
appointment
ÉÉ %
)
ÉÉ% &
;
ÉÉ& '
await
ÑÑ 
_db
ÑÑ 
.
ÑÑ 
SaveChangesAsync
ÑÑ &
(
ÑÑ& '
)
ÑÑ' (
;
ÑÑ( )
}
ÖÖ 	
public
áá 	
async
áá
 
Task
áá 
ActualizarAsync
áá $
(
áá$ %
Appointment
áá% 0
appointment
áá1 <
)
áá< =
{
àà #
ArgumentNullException
ââ 
.
ââ 
ThrowIfNull
ââ $
(
ââ$ %
appointment
ââ% 0
)
ââ0 1
;
ââ1 2
_db
ãã 
.
ãã 
Appointments
ãã 
.
ãã 
Update
ãã 
(
ãã 
appointment
ãã '
)
ãã' (
;
ãã( )
await
åå 
_db
åå 
.
åå 
SaveChangesAsync
åå !
(
åå! "
)
åå" #
;
åå# $
}
çç 
public
èè 
async
èè 
Task
èè 
EliminarAsync
èè '
(
èè' (
Guid
èè( ,
id
èè- /
)
èè/ 0
{
êê 
var
ëë 
appointment
ëë 
=
ëë 
await
ëë 
_db
ëë 
.
ëë  
Appointments
ëë  ,
.
ëë, -
	FindAsync
ëë- 6
(
ëë6 7
id
ëë7 9
)
ëë9 :
;
ëë: ;
if
íí 
(
íí 
appointment
íí 
!=
íí 
null
íí 
)
íí 
{
ìì 
appointment
îî 
.
îî 
Estado
îî 
=
îî  
$str
îî! ,
;
îî, -
await
ïï 
_db
ïï 
.
ïï 
SaveChangesAsync
ïï  
(
ïï  !
)
ïï! "
;
ïï" #
}
ññ 	
}
óó 
}
òò 
}ôô µè
pC:\Users\Carlos\source\repos\MedCitas\MedCitas.Infrastructure\Migrations\20251108164728_AgregarEntidadesCitas.cs
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
AgregarEntidadesCitas		 .
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
CreateTable (
(( )
name 
: 
$str #
,# $
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
,J K
Nombre 
= 
table "
." #
Column# )
<) *
string* 0
>0 1
(1 2
type2 6
:6 7
$str8 P
,P Q
	maxLengthR [
:[ \
$num] `
,` a
nullableb j
:j k
falsel q
)q r
,r s
Descripcion 
=  !
table" '
.' (
Column( .
<. /
string/ 5
>5 6
(6 7
type7 ;
:; <
$str= U
,U V
	maxLengthW `
:` a
$numb e
,e f
nullableg o
:o p
falseq v
)v w
,w x#
DuracionConsultaMinutos +
=, -
table. 3
.3 4
Column4 :
<: ;
int; >
>> ?
(? @
type@ D
:D E
$strF O
,O P
nullableQ Y
:Y Z
false[ `
)` a
,a b

EstaActiva 
=  
table! &
.& '
Column' -
<- .
bool. 2
>2 3
(3 4
type4 8
:8 9
$str: C
,C D
nullableE M
:M N
falseO T
,T U
defaultValueV b
:b c
trued h
)h i
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 5
,5 6
x7 8
=>9 ;
x< =
.= >
Id> @
)@ A
;A B
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
,  
columns 
: 
table 
=> !
new" %
{   
Id!! 
=!! 
table!! 
.!! 
Column!! %
<!!% &
Guid!!& *
>!!* +
(!!+ ,
type!!, 0
:!!0 1
$str!!2 8
,!!8 9
nullable!!: B
:!!B C
false!!D I
)!!I J
,!!J K
NombreCompleto"" "
=""# $
table""% *
.""* +
Column""+ 1
<""1 2
string""2 8
>""8 9
(""9 :
type"": >
:""> ?
$str""@ X
,""X Y
	maxLength""Z c
:""c d
$num""e h
,""h i
nullable""j r
:""r s
false""t y
)""y z
,""z {
SpecialtyId## 
=##  !
table##" '
.##' (
Column##( .
<##. /
Guid##/ 3
>##3 4
(##4 5
type##5 9
:##9 :
$str##; A
,##A B
nullable##C K
:##K L
false##M R
)##R S
,##S T
NumeroLicencia$$ "
=$$# $
table$$% *
.$$* +
Column$$+ 1
<$$1 2
string$$2 8
>$$8 9
($$9 :
type$$: >
:$$> ?
$str$$@ W
,$$W X
	maxLength$$Y b
:$$b c
$num$$d f
,$$f g
nullable$$h p
:$$p q
false$$r w
)$$w x
,$$x y
CorreoElectronico%% %
=%%& '
table%%( -
.%%- .
Column%%. 4
<%%4 5
string%%5 ;
>%%; <
(%%< =
type%%= A
:%%A B
$str%%C [
,%%[ \
	maxLength%%] f
:%%f g
$num%%h k
,%%k l
nullable%%m u
:%%u v
true%%w {
)%%{ |
,%%| }
Telefono&& 
=&& 
table&& $
.&&$ %
Column&&% +
<&&+ ,
string&&, 2
>&&2 3
(&&3 4
type&&4 8
:&&8 9
$str&&: Q
,&&Q R
	maxLength&&S \
:&&\ ]
$num&&^ `
,&&` a
nullable&&b j
:&&j k
true&&l p
)&&p q
,&&q r

EstaActivo'' 
=''  
table''! &
.''& '
Column''' -
<''- .
bool''. 2
>''2 3
(''3 4
type''4 8
:''8 9
$str'': C
,''C D
nullable''E M
:''M N
false''O T
,''T U
defaultValue''V b
:''b c
true''d h
)''h i
,''i j
FechaRegistro(( !
=((" #
table(($ )
.(() *
Column((* 0
<((0 1
DateTime((1 9
>((9 :
(((: ;
type((; ?
:((? @
$str((A [
,(([ \
nullable((] e
:((e f
false((g l
)((l m
})) 
,)) 
constraints** 
:** 
table** "
=>**# %
{++ 
table,, 
.,, 

PrimaryKey,, $
(,,$ %
$str,,% 1
,,,1 2
x,,3 4
=>,,5 7
x,,8 9
.,,9 :
Id,,: <
),,< =
;,,= >
table-- 
.-- 

ForeignKey-- $
(--$ %
name.. 
:.. 
$str.. B
,..B C
column// 
:// 
x//  !
=>//" $
x//% &
.//& '
SpecialtyId//' 2
,//2 3
principalTable00 &
:00& '
$str00( 5
,005 6
principalColumn11 '
:11' (
$str11) -
,11- .
onDelete22  
:22  !
ReferentialAction22" 3
.223 4
Restrict224 <
)22< =
;22= >
}33 
)33 
;33 
migrationBuilder55 
.55 
CreateTable55 (
(55( )
name66 
:66 
$str66 $
,66$ %
columns77 
:77 
table77 
=>77 !
new77" %
{88 
Id99 
=99 
table99 
.99 
Column99 %
<99% &
Guid99& *
>99* +
(99+ ,
type99, 0
:990 1
$str992 8
,998 9
nullable99: B
:99B C
false99D I
)99I J
,99J K

PacienteId:: 
=::  
table::! &
.::& '
Column::' -
<::- .
Guid::. 2
>::2 3
(::3 4
type::4 8
:::8 9
$str::: @
,::@ A
nullable::B J
:::J K
false::L Q
)::Q R
,::R S
DoctorId;; 
=;; 
table;; $
.;;$ %
Column;;% +
<;;+ ,
Guid;;, 0
>;;0 1
(;;1 2
type;;2 6
:;;6 7
$str;;8 >
,;;> ?
nullable;;@ H
:;;H I
false;;J O
);;O P
,;;P Q
SpecialtyId<< 
=<<  !
table<<" '
.<<' (
Column<<( .
<<<. /
Guid<</ 3
><<3 4
(<<4 5
type<<5 9
:<<9 :
$str<<; A
,<<A B
nullable<<C K
:<<K L
false<<M R
)<<R S
,<<S T
	FechaCita== 
=== 
table==  %
.==% &
Column==& ,
<==, -
DateTime==- 5
>==5 6
(==6 7
type==7 ;
:==; <
$str=== C
,==C D
nullable==E M
:==M N
false==O T
)==T U
,==U V

HoraInicio>> 
=>>  
table>>! &
.>>& '
Column>>' -
<>>- .
TimeSpan>>. 6
>>>6 7
(>>7 8
type>>8 <
:>>< =
$str>>> H
,>>H I
nullable>>J R
:>>R S
false>>T Y
)>>Y Z
,>>Z [
HoraFin?? 
=?? 
table?? #
.??# $
Column??$ *
<??* +
TimeSpan??+ 3
>??3 4
(??4 5
type??5 9
:??9 :
$str??; E
,??E F
nullable??G O
:??O P
false??Q V
)??V W
,??W X
	Modalidad@@ 
=@@ 
table@@  %
.@@% &
Column@@& ,
<@@, -
string@@- 3
>@@3 4
(@@4 5
type@@5 9
:@@9 :
$str@@; R
,@@R S
	maxLength@@T ]
:@@] ^
$num@@_ a
,@@a b
nullable@@c k
:@@k l
false@@m r
)@@r s
,@@s t
EstadoAA 
=AA 
tableAA "
.AA" #
ColumnAA# )
<AA) *
stringAA* 0
>AA0 1
(AA1 2
typeAA2 6
:AA6 7
$strAA8 O
,AAO P
	maxLengthAAQ Z
:AAZ [
$numAA\ ^
,AA^ _
nullableAA` h
:AAh i
falseAAj o
)AAo p
,AAp q
MotivoConsultaBB "
=BB# $
tableBB% *
.BB* +
ColumnBB+ 1
<BB1 2
stringBB2 8
>BB8 9
(BB9 :
typeBB: >
:BB> ?
$strBB@ X
,BBX Y
	maxLengthBBZ c
:BBc d
$numBBe h
,BBh i
nullableBBj r
:BBr s
trueBBt x
)BBx y
,BBy z
ObservacionesCC !
=CC" #
tableCC$ )
.CC) *
ColumnCC* 0
<CC0 1
stringCC1 7
>CC7 8
(CC8 9
typeCC9 =
:CC= >
$strCC? X
,CCX Y
	maxLengthCCZ c
:CCc d
$numCCe i
,CCi j
nullableCCk s
:CCs t
trueCCu y
)CCy z
,CCz {
FechaCreacionDD !
=DD" #
tableDD$ )
.DD) *
ColumnDD* 0
<DD0 1
DateTimeDD1 9
>DD9 :
(DD: ;
typeDD; ?
:DD? @
$strDDA [
,DD[ \
nullableDD] e
:DDe f
falseDDg l
)DDl m
,DDm n
FechaCancelacionEE $
=EE% &
tableEE' ,
.EE, -
ColumnEE- 3
<EE3 4
DateTimeEE4 <
>EE< =
(EE= >
typeEE> B
:EEB C
$strEED ^
,EE^ _
nullableEE` h
:EEh i
trueEEj n
)EEn o
,EEo p
MotivoCancelacionFF %
=FF& '
tableFF( -
.FF- .
ColumnFF. 4
<FF4 5
stringFF5 ;
>FF; <
(FF< =
typeFF= A
:FFA B
$strFFC [
,FF[ \
	maxLengthFF] f
:FFf g
$numFFh k
,FFk l
nullableFFm u
:FFu v
trueFFw {
)FF{ |
}GG 
,GG 
constraintsHH 
:HH 
tableHH "
=>HH# %
{II 
tableJJ 
.JJ 

PrimaryKeyJJ $
(JJ$ %
$strJJ% 6
,JJ6 7
xJJ8 9
=>JJ: <
xJJ= >
.JJ> ?
IdJJ? A
)JJA B
;JJB C
tableKK 
.KK 

ForeignKeyKK $
(KK$ %
nameLL 
:LL 
$strLL @
,LL@ A
columnMM 
:MM 
xMM  !
=>MM" $
xMM% &
.MM& '
DoctorIdMM' /
,MM/ 0
principalTableNN &
:NN& '
$strNN( 1
,NN1 2
principalColumnOO '
:OO' (
$strOO) -
,OO- .
onDeletePP  
:PP  !
ReferentialActionPP" 3
.PP3 4
RestrictPP4 <
)PP< =
;PP= >
tableQQ 
.QQ 

ForeignKeyQQ $
(QQ$ %
nameRR 
:RR 
$strRR D
,RRD E
columnSS 
:SS 
xSS  !
=>SS" $
xSS% &
.SS& '

PacienteIdSS' 1
,SS1 2
principalTableTT &
:TT& '
$strTT( 3
,TT3 4
principalColumnUU '
:UU' (
$strUU) -
,UU- .
onDeleteVV  
:VV  !
ReferentialActionVV" 3
.VV3 4
RestrictVV4 <
)VV< =
;VV= >
tableWW 
.WW 

ForeignKeyWW $
(WW$ %
nameXX 
:XX 
$strXX G
,XXG H
columnYY 
:YY 
xYY  !
=>YY" $
xYY% &
.YY& '
SpecialtyIdYY' 2
,YY2 3
principalTableZZ &
:ZZ& '
$strZZ( 5
,ZZ5 6
principalColumn[[ '
:[[' (
$str[[) -
,[[- .
onDelete\\  
:\\  !
ReferentialAction\\" 3
.\\3 4
Restrict\\4 <
)\\< =
;\\= >
}]] 
)]] 
;]] 
migrationBuilder__ 
.__ 
CreateIndex__ (
(__( )
name`` 
:`` 
$str`` 6
,``6 7
tableaa 
:aa 
$straa "
,aa" #
columnbb 
:bb 
$strbb +
,bb+ ,
uniquecc 
:cc 
truecc 
)cc 
;cc 
migrationBuilderee 
.ee 
CreateIndexee (
(ee( )
nameff 
:ff 
$strff 4
,ff4 5
tablegg 
:gg 
$strgg "
,gg" #
columnhh 
:hh 
$strhh )
,hh) *
uniqueii 
:ii 
trueii 
)ii 
;ii 
migrationBuilderkk 
.kk 
CreateIndexkk (
(kk( )
namell 
:ll 
$strll A
,llA B
tablemm 
:mm 
$strmm %
,mm% &
columnsnn 
:nn 
newnn 
[nn 
]nn 
{nn  
$strnn! +
,nn+ ,
$strnn- 8
,nn8 9
$strnn: B
}nnC D
)nnD E
;nnE F
migrationBuilderpp 
.pp 
CreateIndexpp (
(pp( )
nameqq 
:qq 
$strqq C
,qqC D
tablerr 
:rr 
$strrr %
,rr% &
columnsss 
:ss 
newss 
[ss 
]ss 
{ss  
$strss! -
,ss- .
$strss/ :
,ss: ;
$strss< D
}ssE F
)ssF G
;ssG H
migrationBuilderuu 
.uu 
CreateIndexuu (
(uu( )
namevv 
:vv 
$strvv 3
,vv3 4
tableww 
:ww 
$strww %
,ww% &
columnxx 
:xx 
$strxx %
)xx% &
;xx& '
migrationBuilderzz 
.zz 
CreateIndexzz (
(zz( )
name{{ 
:{{ 
$str{{ 1
,{{1 2
table|| 
:|| 
$str||  
,||  !
column}} 
:}} 
$str}} (
,}}( )
unique~~ 
:~~ 
true~~ 
)~~ 
;~~ 
migrationBuilder
ÄÄ 
.
ÄÄ 
CreateIndex
ÄÄ (
(
ÄÄ( )
name
ÅÅ 
:
ÅÅ 
$str
ÅÅ .
,
ÅÅ. /
table
ÇÇ 
:
ÇÇ 
$str
ÇÇ  
,
ÇÇ  !
column
ÉÉ 
:
ÉÉ 
$str
ÉÉ %
)
ÉÉ% &
;
ÉÉ& '
migrationBuilder
ÖÖ 
.
ÖÖ 
CreateIndex
ÖÖ (
(
ÖÖ( )
name
ÜÜ 
:
ÜÜ 
$str
ÜÜ -
,
ÜÜ- .
table
áá 
:
áá 
$str
áá $
,
áá$ %
column
àà 
:
àà 
$str
àà  
,
àà  !
unique
ââ 
:
ââ 
true
ââ 
)
ââ 
;
ââ 
}
ää 	
	protected
çç 
override
çç 
void
çç 
Down
çç  $
(
çç$ %
MigrationBuilder
çç% 5
migrationBuilder
çç6 F
)
ççF G
{
éé 	
migrationBuilder
èè 
.
èè 
	DropTable
èè &
(
èè& '
name
êê 
:
êê 
$str
êê $
)
êê$ %
;
êê% &
migrationBuilder
íí 
.
íí 
	DropTable
íí &
(
íí& '
name
ìì 
:
ìì 
$str
ìì 
)
ìì  
;
ìì  !
migrationBuilder
ïï 
.
ïï 
	DropTable
ïï &
(
ïï& '
name
ññ 
:
ññ 
$str
ññ #
)
ññ# $
;
ññ$ %
migrationBuilder
òò 
.
òò 
	DropIndex
òò &
(
òò& '
name
ôô 
:
ôô 
$str
ôô 6
,
ôô6 7
table
öö 
:
öö 
$str
öö "
)
öö" #
;
öö# $
migrationBuilder
úú 
.
úú 
	DropIndex
úú &
(
úú& '
name
ùù 
:
ùù 
$str
ùù 4
,
ùù4 5
table
ûû 
:
ûû 
$str
ûû "
)
ûû" #
;
ûû# $
}
üü 	
}
†† 
}°° £
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
}.. ˙ñ
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
{ 
private 
const 
string 
TimestampColumnType 0
=1 2
$str3 M
;M N
private 
const 
string 
DateColumnType +
=, -
$str. 4
;4 5
public 
MedCitasDbContext  
(  !
DbContextOptions! 1
<1 2
MedCitasDbContext2 C
>C D
optionsE L
)L M
:N O
baseP T
(T U
optionsU \
)\ ]
{^ _
}` a
public 
DbSet 
< 
Paciente 
> 
	Pacientes (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
=7 8
null9 =
!= >
;> ?
public 
DbSet 
< 
	Specialty 
> 
Specialties  +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
=: ;
null< @
!@ A
;A B
public 
DbSet 
< 
Doctor 
> 
Doctors $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
null5 9
!9 :
;: ;
public 
DbSet 
< 
Appointment  
>  !
Appointments" .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
== >
null? C
!C D
;D E
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
modelBuilder 
. 
Entity 
<  
Paciente  (
>( )
() *
entity* 0
=>1 3
{ 
entity 
. 
HasKey 
( 
e 
=>  "
e# $
.$ %
Id% '
)' (
;( )
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
NombreCompleto' 5
)5 6
.6 7

IsRequired7 A
(A B
)B C
;C D
entity 
. 
Property 
(  
e  !
=>" $
e% &
.& '
TipoDocumento' 4
)4 5
.5 6

IsRequired6 @
(@ A
)A B
.B C
HasMaxLengthC O
(O P
$numP Q
)Q R
;R S
entity   
.   
Property   
(    
e    !
=>  " $
e  % &
.  & '
NumeroDocumento  ' 6
)  6 7
.  7 8

IsRequired  8 B
(  B C
)  C D
.  D E
HasMaxLength  E Q
(  Q R
$num  R T
)  T U
;  U V
entity!! 
.!! 
Property!! 
(!!  
e!!  !
=>!!" $
e!!% &
.!!& '
FechaNacimiento!!' 6
)!!6 7
.!!7 8

IsRequired!!8 B
(!!B C
)!!C D
.!!D E
HasColumnType!!E R
(!!R S
DateColumnType!!S a
)!!a b
;!!b c
entity"" 
."" 
Property"" 
(""  
e""  !
=>""" $
e""% &
.""& '
Sexo""' +
)""+ ,
."", -

IsRequired""- 7
(""7 8
)""8 9
.""9 :
HasMaxLength"": F
(""F G
$num""G H
)""H I
;""I J
entity## 
.## 
Property## 
(##  
e##  !
=>##" $
e##% &
.##& '
Telefono##' /
)##/ 0
.##0 1

IsRequired##1 ;
(##; <
)##< =
.##= >
HasMaxLength##> J
(##J K
$num##K M
)##M N
;##N O
entity$$ 
.$$ 
Property$$ 
($$  
e$$  !
=>$$" $
e$$% &
.$$& '
CorreoElectronico$$' 8
)$$8 9
.$$9 :

IsRequired$$: D
($$D E
)$$E F
.$$F G
HasMaxLength$$G S
($$S T
$num$$T W
)$$W X
;$$X Y
entity%% 
.%% 
Property%% 
(%%  
e%%  !
=>%%" $
e%%% &
.%%& '
PasswordHash%%' 3
)%%3 4
.%%4 5
HasMaxLength%%5 A
(%%A B
$num%%B E
)%%E F
;%%F G
entity&& 
.&& 
Property&& 
(&&  
e&&  !
=>&&" $
e&&% &
.&&& '
Eps&&' *
)&&* +
.&&+ ,

IsRequired&&, 6
(&&6 7
)&&7 8
;&&8 9
entity'' 
.'' 
Property'' 
(''  
e''  !
=>''" $
e''% &
.''& '

TipoSangre''' 1
)''1 2
.''2 3

IsRequired''3 =
(''= >
)''> ?
;''? @
entity(( 
.(( 
Property(( 
(((  
e((  !
=>((" $
e((% &
.((& '
EstaVerificado((' 5
)((5 6
;((6 7
entity)) 
.)) 
Property)) 
())  
e))  !
=>))" $
e))% &
.))& '
TokenVerificacion))' 8
)))8 9
;))9 :
entity** 
.** 
Property** 
(**  
e**  !
=>**" $
e**% &
.**& '
FechaRegistro**' 4
)**4 5
.**5 6
HasColumnType**6 C
(**C D
TimestampColumnType**D W
)**W X
;**X Y
entity++ 
.++ 
Property++ 
(++  
e++  !
=>++" $
e++% &
.++& '
	CodigoOTP++' 0
)++0 1
.++1 2
HasMaxLength++2 >
(++> ?
$num++? @
)++@ A
;++A B
entity,, 
.,, 
Property,, 
(,,  
e,,  !
=>,," $
e,,% &
.,,& '
OTPExpiracion,,' 4
),,4 5
.,,5 6
HasColumnType,,6 C
(,,C D
TimestampColumnType,,D W
),,W X
;,,X Y
entity-- 
.-- 
Property-- 
(--  
e--  !
=>--" $
e--% &
.--& '
IntentosOTPFallidos--' :
)--: ;
.--; <
HasDefaultValue--< K
(--K L
$num--L M
)--M N
;--N O
entity.. 
... 
Property.. 
(..  
e..  !
=>.." $
e..% &
...& '
TokenRecuperacion..' 8
)..8 9
...9 :
HasMaxLength..: F
(..F G
$num..G I
)..I J
;..J K
entity// 
.// 
Property// 
(//  
e//  !
=>//" $
e//% &
.//& ''
TokenRecuperacionExpiracion//' B
)//B C
.//C D
HasColumnType//D Q
(//Q R
TimestampColumnType//R e
)//e f
;//f g
entity22 
.22 
HasIndex22 
(22  
e22  !
=>22" $
e22% &
.22& '
CorreoElectronico22' 8
)228 9
.229 :
IsUnique22: B
(22B C
)22C D
;22D E
entity33 
.33 
HasIndex33 
(33  
e33  !
=>33" $
e33% &
.33& '
NumeroDocumento33' 6
)336 7
.337 8
IsUnique338 @
(33@ A
)33A B
;33B C
}44 
)44 
;44 
modelBuilder77 
.77 
Entity77 
<77  
	Specialty77  )
>77) *
(77* +
entity77+ 1
=>772 4
{88 
entity99 
.99 
HasKey99 
(99 
e99 
=>99  "
e99# $
.99$ %
Id99% '
)99' (
;99( )
entity:: 
.:: 
Property:: 
(::  
e::  !
=>::" $
e::% &
.::& '
Nombre::' -
)::- .
.::. /

IsRequired::/ 9
(::9 :
)::: ;
.::; <
HasMaxLength::< H
(::H I
$num::I L
)::L M
;::M N
entity;; 
.;; 
Property;; 
(;;  
e;;  !
=>;;" $
e;;% &
.;;& '
Descripcion;;' 2
);;2 3
.;;3 4
HasMaxLength;;4 @
(;;@ A
$num;;A D
);;D E
;;;E F
entity<< 
.<< 
Property<< 
(<<  
e<<  !
=><<" $
e<<% &
.<<& '#
DuracionConsultaMinutos<<' >
)<<> ?
.<<? @

IsRequired<<@ J
(<<J K
)<<K L
;<<L M
entity== 
.== 
Property== 
(==  
e==  !
=>==" $
e==% &
.==& '

EstaActiva==' 1
)==1 2
.==2 3
HasDefaultValue==3 B
(==B C
true==C G
)==G H
;==H I
entity?? 
.?? 
HasIndex?? 
(??  
e??  !
=>??" $
e??% &
.??& '
Nombre??' -
)??- .
.??. /
IsUnique??/ 7
(??7 8
)??8 9
;??9 :
}@@ 
)@@ 
;@@ 
modelBuilderCC 
.CC 
EntityCC 
<CC  
DoctorCC  &
>CC& '
(CC' (
entityCC( .
=>CC/ 1
{DD 
entityEE 
.EE 
HasKeyEE 
(EE 
eEE 
=>EE  "
eEE# $
.EE$ %
IdEE% '
)EE' (
;EE( )
entityFF 
.FF 
PropertyFF 
(FF  
eFF  !
=>FF" $
eFF% &
.FF& '
NombreCompletoFF' 5
)FF5 6
.FF6 7

IsRequiredFF7 A
(FFA B
)FFB C
.FFC D
HasMaxLengthFFD P
(FFP Q
$numFFQ T
)FFT U
;FFU V
entityGG 
.GG 
PropertyGG 
(GG  
eGG  !
=>GG" $
eGG% &
.GG& '
NumeroLicenciaGG' 5
)GG5 6
.GG6 7

IsRequiredGG7 A
(GGA B
)GGB C
.GGC D
HasMaxLengthGGD P
(GGP Q
$numGGQ S
)GGS T
;GGT U
entityHH 
.HH 
PropertyHH 
(HH  
eHH  !
=>HH" $
eHH% &
.HH& '
CorreoElectronicoHH' 8
)HH8 9
.HH9 :
HasMaxLengthHH: F
(HHF G
$numHHG J
)HHJ K
;HHK L
entityII 
.II 
PropertyII 
(II  
eII  !
=>II" $
eII% &
.II& '
TelefonoII' /
)II/ 0
.II0 1
HasMaxLengthII1 =
(II= >
$numII> @
)II@ A
;IIA B
entityJJ 
.JJ 
PropertyJJ 
(JJ  
eJJ  !
=>JJ" $
eJJ% &
.JJ& '

EstaActivoJJ' 1
)JJ1 2
.JJ2 3
HasDefaultValueJJ3 B
(JJB C
trueJJC G
)JJG H
;JJH I
entityKK 
.KK 
PropertyKK 
(KK  
eKK  !
=>KK" $
eKK% &
.KK& '
FechaRegistroKK' 4
)KK4 5
.KK5 6
HasColumnTypeKK6 C
(KKC D
TimestampColumnTypeKKD W
)KKW X
;KKX Y
entityMM 
.MM 
HasOneMM 
(MM 
dMM 
=>MM  "
dMM# $
.MM$ %
	SpecialtyMM% .
)MM. /
.NN 
WithManyNN 
(NN 
sNN 
=>NN  "
sNN# $
.NN$ %
DoctorsNN% ,
)NN, -
.OO 
HasForeignKeyOO "
(OO" #
dOO# $
=>OO% '
dOO( )
.OO) *
SpecialtyIdOO* 5
)OO5 6
.PP 
OnDeletePP 
(PP 
DeleteBehaviorPP ,
.PP, -
RestrictPP- 5
)PP5 6
;PP6 7
entityRR 
.RR 
HasIndexRR 
(RR  
eRR  !
=>RR" $
eRR% &
.RR& '
NumeroLicenciaRR' 5
)RR5 6
.RR6 7
IsUniqueRR7 ?
(RR? @
)RR@ A
;RRA B
}SS 
)SS 
;SS 
modelBuilderVV 
.VV 
EntityVV 
<VV  
AppointmentVV  +
>VV+ ,
(VV, -
entityVV- 3
=>VV4 6
{WW 
entityXX 
.XX 
HasKeyXX 
(XX 
eXX 
=>XX  "
eXX# $
.XX$ %
IdXX% '
)XX' (
;XX( )
entityYY 
.YY 
PropertyYY 
(YY  
eYY  !
=>YY" $
eYY% &
.YY& '
	FechaCitaYY' 0
)YY0 1
.YY1 2

IsRequiredYY2 <
(YY< =
)YY= >
.YY> ?
HasColumnTypeYY? L
(YYL M
DateColumnTypeYYM [
)YY[ \
;YY\ ]
entityZZ 
.ZZ 
PropertyZZ 
(ZZ  
eZZ  !
=>ZZ" $
eZZ% &
.ZZ& '

HoraInicioZZ' 1
)ZZ1 2
.ZZ2 3

IsRequiredZZ3 =
(ZZ= >
)ZZ> ?
;ZZ? @
entity[[ 
.[[ 
Property[[ 
([[  
e[[  !
=>[[" $
e[[% &
.[[& '
HoraFin[[' .
)[[. /
.[[/ 0

IsRequired[[0 :
([[: ;
)[[; <
;[[< =
entity\\ 
.\\ 
Property\\ 
(\\  
e\\  !
=>\\" $
e\\% &
.\\& '
	Modalidad\\' 0
)\\0 1
.\\1 2

IsRequired\\2 <
(\\< =
)\\= >
.\\> ?
HasMaxLength\\? K
(\\K L
$num\\L N
)\\N O
;\\O P
entity]] 
.]] 
Property]] 
(]]  
e]]  !
=>]]" $
e]]% &
.]]& '
Estado]]' -
)]]- .
.]]. /

IsRequired]]/ 9
(]]9 :
)]]: ;
.]]; <
HasMaxLength]]< H
(]]H I
$num]]I K
)]]K L
;]]L M
entity^^ 
.^^ 
Property^^ 
(^^  
e^^  !
=>^^" $
e^^% &
.^^& '
MotivoConsulta^^' 5
)^^5 6
.^^6 7
HasMaxLength^^7 C
(^^C D
$num^^D G
)^^G H
;^^H I
entity__ 
.__ 
Property__ 
(__  
e__  !
=>__" $
e__% &
.__& '
Observaciones__' 4
)__4 5
.__5 6
HasMaxLength__6 B
(__B C
$num__C G
)__G H
;__H I
entity`` 
.`` 
Property`` 
(``  
e``  !
=>``" $
e``% &
.``& '
FechaCreacion``' 4
)``4 5
.``5 6
HasColumnType``6 C
(``C D
TimestampColumnType``D W
)``W X
;``X Y
entityaa 
.aa 
Propertyaa 
(aa  
eaa  !
=>aa" $
eaa% &
.aa& '
FechaCancelacionaa' 7
)aa7 8
.aa8 9
HasColumnTypeaa9 F
(aaF G
TimestampColumnTypeaaG Z
)aaZ [
;aa[ \
entitybb 
.bb 
Propertybb 
(bb  
ebb  !
=>bb" $
ebb% &
.bb& '
MotivoCancelacionbb' 8
)bb8 9
.bb9 :
HasMaxLengthbb: F
(bbF G
$numbbG J
)bbJ K
;bbK L
entitydd 
.dd 
HasOnedd 
(dd 
add 
=>dd  "
add# $
.dd$ %
Pacientedd% -
)dd- .
.ee 
WithManyee 
(ee 
)ee 
.ff 
HasForeignKeyff "
(ff" #
aff# $
=>ff% '
aff( )
.ff) *

PacienteIdff* 4
)ff4 5
.gg 
OnDeletegg 
(gg 
DeleteBehaviorgg ,
.gg, -
Restrictgg- 5
)gg5 6
;gg6 7
entityii 
.ii 
HasOneii 
(ii 
aii 
=>ii  "
aii# $
.ii$ %
Doctorii% +
)ii+ ,
.jj 
WithManyjj 
(jj 
djj 
=>jj  "
djj# $
.jj$ %
Appointmentsjj% 1
)jj1 2
.kk 
HasForeignKeykk "
(kk" #
akk# $
=>kk% '
akk( )
.kk) *
DoctorIdkk* 2
)kk2 3
.ll 
OnDeletell 
(ll 
DeleteBehaviorll ,
.ll, -
Restrictll- 5
)ll5 6
;ll6 7
entitynn 
.nn 
HasOnenn 
(nn 
ann 
=>nn  "
ann# $
.nn$ %
	Specialtynn% .
)nn. /
.oo 
WithManyoo 
(oo 
)oo 
.pp 
HasForeignKeypp "
(pp" #
app# $
=>pp% '
app( )
.pp) *
SpecialtyIdpp* 5
)pp5 6
.qq 
OnDeleteqq 
(qq 
DeleteBehaviorqq ,
.qq, -
Restrictqq- 5
)qq5 6
;qq6 7
entitytt 
.tt 
HasIndextt 
(tt  
ett  !
=>tt" $
newtt% (
{tt) *
ett+ ,
.tt, -
DoctorIdtt- 5
,tt5 6
ett7 8
.tt8 9
	FechaCitatt9 B
,ttB C
ettD E
.ttE F
EstadottF L
}ttM N
)ttN O
;ttO P
entityuu 
.uu 
HasIndexuu 
(uu  
euu  !
=>uu" $
newuu% (
{uu) *
euu+ ,
.uu, -

PacienteIduu- 7
,uu7 8
euu9 :
.uu: ;
	FechaCitauu; D
,uuD E
euuF G
.uuG H
EstadouuH N
}uuO P
)uuP Q
;uuQ R
}vv 
)vv 
;vv 
basexx 
.xx 
OnModelCreatingxx  
(xx  !
modelBuilderxx! -
)xx- .
;xx. /
}yy 	
}zz 
}{{ 
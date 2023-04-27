!classDefinition: #TDDBabyStepsGameWindow category: 'TDDBabyStepsGame'!
SystemWindow subclass: #TDDBabyStepsGameWindow
	instanceVariableNames: 'stepResultTextBoxMorph nextButtonMorph forceNextButtonMorph definitionButtonMorph gameJourneyTextBoxMorph testNumberLabel pointsLabel helpButtonMorph lastStepPoints'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 9/28/2022 17:04:19'!
refreshWindow
	
	stepResultTextBoxMorph updateAcceptedContents.
	gameJourneyTextBoxMorph updateAcceptedContents.
	
	self updateStepAndPoints.
	self updateStepResultBorderColor.
	
	lastStepPoints := model score.! !

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 9/28/2022 17:04:54'!
updateStepAndPoints

	| currentStepToShow |
	
	currentStepToShow := model currentStep.
	(currentStepToShow > model numberOfTests) ifTrue: [currentStepToShow := model numberOfTests].
	
	testNumberLabel contents: 'Test Number: ', currentStepToShow asString,'/', model numberOfTests asString.
	pointsLabel contents: 'Points: ', model score asString! !

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 9/28/2022 17:04:43'!
updateStepResultBorderColor

	lastStepPoints > model score ifTrue: [stepResultTextBoxMorph borderColor: Color lightRed].
	lastStepPoints = model score ifTrue: [stepResultTextBoxMorph borderColor: Color lightBlue].
	lastStepPoints < model score ifTrue: [stepResultTextBoxMorph borderColor: Color lightGreen]! !


!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:33:36'!
build1stRow
	
	| firstRow |

	testNumberLabel := LabelMorph contents:'Test Number:'.
	pointsLabel := LabelMorph contents:'Points:'.
	
	firstRow := LayoutMorph newRow.
	firstRow separation: 15;
	axisEdgeWeight: 1;
	addMorph: testNumberLabel;
	addMorph: pointsLabel.
	
	firstRow layoutSpec proportionalHeight: 0.	

	^firstRow
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 22:19:46'!
build2ndRow
		
	| row |
	
	stepResultTextBoxMorph := TextModelMorph textProvider: self model textGetter: #stepResultText textSetter: nil. 
	stepResultTextBoxMorph  innerTextMorph setProperty: #keyStroke: toValue: [ :key | stepResultTextBoxMorph innerTextMorph acceptContents ].
	stepResultTextBoxMorph borderWidth: 2; borderColor: Color lightBlue.
	stepResultTextBoxMorph layoutSpec proportionalWidth: 1.
	stepResultTextBoxMorph layoutSpec proportionalHeight: 1.
		
	row := LayoutMorph newColumn.
	row separation: 5; 
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents:'Step Result');
	addMorph: stepResultTextBoxMorph.
	
	row layoutSpec fixedHeight: 187.
	
	^row.
	
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:31:26'!
build3rdRow

	| row |

	row := LayoutMorph newRow.
	row separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: self build3rdRow1stColumn;
	addMorph: self build3rdRow2ndColumn.
		
	^row	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:30:38'!
build3rdRow1stColumn

	| firstColumn |

	definitionButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #openDefinition label: 'Definition'.	
	nextButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #next label: 'Next'.	
	forceNextButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #forceNext label: 'Force Next'.	
		
	firstColumn := LayoutMorph newColumn.
	firstColumn separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: definitionButtonMorph;
	addMorph: nextButtonMorph;
	addMorph: forceNextButtonMorph.
	firstColumn layoutSpec fixedWidth: 10.
		
	^firstColumn! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:47:28'!
build3rdRow2ndColumn

	| secondColumn |
		
	gameJourneyTextBoxMorph := TextModelMorph textProvider: self model textGetter: #gameJourneyText textSetter: nil. 
	gameJourneyTextBoxMorph  innerTextMorph setProperty: #keyStroke: toValue: [ :key | gameJourneyTextBoxMorph innerTextMorph acceptContents ] .
	gameJourneyTextBoxMorph borderWidth: 1; borderColor: Color lightBlue.
	gameJourneyTextBoxMorph layoutSpec proportionalWidth: 1.
	gameJourneyTextBoxMorph layoutSpec proportionalHeight: 1.
				
	secondColumn := LayoutMorph newColumn.
	secondColumn  separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Game Journey');
	addMorph: gameJourneyTextBoxMorph.
		
	^secondColumn! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:32:54'!
buildMorphicWindow

	helpButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #openHelp label: 'Help!!'.	
	helpButtonMorph layoutSpec offAxisEdgeWeight: 1.

	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: helpButtonMorph.
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:07:21'!
defaultExtent

	^ 600@760
	! !


!TDDBabyStepsGameWindow methodsFor: 'initialization' stamp: 'NR 9/24/2022 19:59:05'!
initializeWith: aGameView gameName: aTitle 

	self setLabel: 'BabySteps: ',aTitle.
	self model: aGameView.
	self buildMorphicWindow.
	self openInWorld.
	self morphExtent: (self defaultExtent).
				
	self suscribeToModelEvents.
	
	lastStepPoints := model score.
	! !

!TDDBabyStepsGameWindow methodsFor: 'initialization' stamp: 'NR 9/24/2022 19:21:40'!
suscribeToModelEvents

	^ self model when: #gameChanged send: #refreshWindow to: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameWindow class' category: 'TDDBabyStepsGame'!
TDDBabyStepsGameWindow class
	instanceVariableNames: ''!

!TDDBabyStepsGameWindow class methodsFor: 'instance creation' stamp: 'NR 9/24/2022 06:11:26'!
openWithGameView: gameView name: gameName 

	^self new initializeWith: gameView gameName: gameName! !


!classDefinition: #TDDBabyStepsGame category: 'TDDBabyStepsGame'!
Object subclass: #TDDBabyStepsGame
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 5/3/2022 08:29:29'!
build
	
	^ TDDBabyStepsGameView for: self buildGame.! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 4/26/2023 19:30:55'!
buildGame
	
	^ TDDBabyStepsGameBase startNamed: self name withCases: self cases withExtraCase:self extraCase inCategory: 'TDDBabyStepsGame', self name capitalized withDefinition: self definition
	! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 5/3/2022 08:48:24'!
createGameContext
	
	"Compiler evaluate: self createTestCaseDefinition"! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 5/3/2022 08:30:14'!
createTestCaseDefinition

	^ 'TestCase subclass: #{1}
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''{2}''' format: {self name. game testCaseCategory }! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 9/25/2022 18:10:01'!
start

	game := self build.
	self createGameContext. 
	
	TDDBabyStepsGameWindow openWithGameView: game name: self name.
	
	^ game start! !


!TDDBabyStepsGame methodsFor: 'private - cases' stamp: 'NR 5/3/2022 08:32:10'!
cases

	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'private - cases' stamp: 'NR 5/3/2022 08:32:43'!
extraCase
	
	self subclassResponsibility ! !


!TDDBabyStepsGame methodsFor: 'private' stamp: 'NR 5/3/2022 08:34:42'!
definition
	
	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'private' stamp: 'NR 5/3/2022 08:32:39'!
name
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGame class' category: 'TDDBabyStepsGame'!
TDDBabyStepsGame class
	instanceVariableNames: ''!

!TDDBabyStepsGame class methodsFor: 'instance creation' stamp: 'NR 5/3/2022 08:46:01'!
start
	
	^ self new start! !


!classDefinition: #TDDBabyStepsGameAnagrams category: 'TDDBabyStepsGame'!
TDDBabyStepsGame subclass: #TDDBabyStepsGameAnagrams
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!
!TDDBabyStepsGameAnagrams commentStamp: '<historical>' prior: 0!
| game |
game  := TDDBabyStepsGameCuentaBancaria start.
game openHelp.
game openDefinition.
game next.!


!TDDBabyStepsGameAnagrams methodsFor: 'private' stamp: 'NR 9/24/2022 22:50:54'!
definition
	
	^ 'Debe obtenerse todos los anagramas de una palabra (string). Por ej. todos los potenciales anagramas de "kata" son:
	
	''ktaa'' ''atka'' ''akat'' ''atak'' ''akta'' ''taka'' ''kata'' ''aatk'' ''tkaa'' ''aakt'' ''kaat'' ''taak''

Ayuda: Considere utilizar el mensaje #copyFrom:to: cuando sea necesario.
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private' stamp: 'NR 5/4/2022 07:48:12'!
name 
	
	^ 'Anagrams'! !


!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/8/2022 15:25:00'!
case01
	
	^ 'test01EmptyStringAnagramIsJustACollectionWithTheEmptyString

	self assert: (Set with: '''') equals: '''' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:59:07'!
case02

	^ 'test02OneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	self assert: (Set with:''a'') equals: ''a'' anagrams
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:59:18'!
case03
	
	^ 'test03TwoCharStringAnagramReturnsTheOriginalStringAndAnotherOneFlipped

	self assert: (Set with:''ab'' with: ''ba'') equals: ''ab'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:59:42'!
case04
	
	^ 'test04ThreeCharStringAnagramReturnsAllThe6PossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: ''abc''.
	anagrams add: ''acb''.
	anagrams add: ''bac''.
	anagrams add: ''bca''.
	anagrams add: ''cab''.
	anagrams add: ''cba''.

	self assert: anagrams equals: ''abc'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 17:00:10'!
case05
	
	^ 'test05MoreThanThreeCharStringAnagramReturnsAllTheCorrectPossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: ''abcd''; add: ''abdc''; add: ''acbd''; add: ''acdb''; add: ''adbc''; add: ''adcb''; add: ''bacd''; add: ''badc''; add: ''bcad''; add: ''bcda''; add: ''bdac''; add: ''bdca''; add: ''cabd''; add: ''cadb''; add: ''cbad''; add: ''cbda''; add: ''cdab''; add: ''cdba''; add: ''dabc''; add: ''dacb''; add: ''dbac''; add: ''dbca''; add: ''dcab''; add: ''dcba''.

	self assert: anagrams equals: ''abcd'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:10:29'!
cases

	^ {self case01. self case02. self case03. self case04. self case05. }! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:58:23'!
extraCase
	
	^ 'testExtraToCheckGeneralizationOnKata

	self assert: 40320 equals:`''abcdefgh'' anagrams` size.
	
	self assert: (`''abcdefgh'' anagrams`) includes: ''cghdbeaf''.
	
	self assert: 10080 equals: `''abcdefab'' anagrams` size
	'! !


!classDefinition: #TDDBabyStepsGameContador category: 'TDDBabyStepsGame'!
TDDBabyStepsGame subclass: #TDDBabyStepsGameContador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!
!TDDBabyStepsGameContador commentStamp: '<historical>' prior: 0!
| game |
game  := TDDBabyStepsGameContador start.
game openHelp.
game openDefinition.
game next.!


!TDDBabyStepsGameContador methodsFor: 'private' stamp: 'NR 5/3/2022 08:40:17'!
definition
	
	^ ' Implementar un contador que recibe el mensaje incrementar para incrementar en 1 su valor.
	El contador debe comenzar en 0.
	El contador tambien sabe responder el mensaje value para obtener su valor.
'! !

!TDDBabyStepsGameContador methodsFor: 'private' stamp: 'FL 11/9/2021 20:23:07'!
name 
	^ 'Contador'! !


!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:45:51'!
case01
	^ 'test01UnNuevoContadorEmpiezaConValorCero

	| contador |
		
	contador := Contador new.
	self assert: 0 equals: contador valor.
	'! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:45:58'!
case02
	^ 'test02AlIncrementarUnaVezElContadorSuValorSubeUno

	| contador |

	contador := Contador new.
	contador incrementar.
	self assert: 1 equals: contador valor.
	' ! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:46:06'!
case03
	^ 'test03SePuedeIncrementarVariasVecesElContadorYSuValorIncrementaEnUnoEsaCantidadDeVeces

	| contador |

	contador := Contador new.
	contador incrementar.
	contador incrementar.
	contador incrementar.
	self assert: 3 equals: contador valor.
	'! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'FL 11/9/2021 20:22:50'!
cases
	^ {self case01. self case02. self case03. }! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:46:18'!
extraCase
	
	^ 'extraTest
	
	self assert: true.
	' ! !


!classDefinition: #TDDBabyStepsGameCuentaBancaria category: 'TDDBabyStepsGame'!
TDDBabyStepsGame subclass: #TDDBabyStepsGameCuentaBancaria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!
!TDDBabyStepsGameCuentaBancaria commentStamp: '<historical>' prior: 0!
| game |
game  := TDDBabyStepsGameCuentaBancaria start.
game openHelp.
game openDefinition.
game next.!


!TDDBabyStepsGameCuentaBancaria methodsFor: 'private' stamp: 'FL 11/15/2021 18:31:13'!
definition
	^ 'Uno de nuestros clientes nos pide crear un modelo de una cuenta bancaria, de modo que nos permita las siguientes operaciones:
		- Realizar uno o mas depositos en pesos.
		- Realizar una o mas extracciones en pesos.
		- Otro punto importante, es que si la cuenta tiene un saldo menor al monto que se desea extraer,
		  debe levantarse un error indicando: "La cuenta no puede quedar en descubierto"
	'! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private' stamp: 'FL 11/12/2021 16:13:07'!
name 
	^ 'CuentaBancariaEnPesos'! !


!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'FL 11/12/2021 16:09:58'!
case01
	^ 'test01UnaNuevaCuentaComienzaConSaldoCero
	
	self assert: 0 * peso equals: CuentaBancariaEnPesos new saldo.
	'! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'FL 11/12/2021 16:10:18'!
case02
	^ 'test02AlHacerUnDepositoSeIncrementaElSaldoConElMontoDepositado
	
	| cuentaBancaria |
	cuentaBancaria := CuentaBancariaEnPesos new.
	cuentaBancaria depositar: 10 * peso.
 	self assert: 10 * peso equals: cuentaBancaria saldo.
	' ! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'FL 11/12/2021 16:10:30'!
case03
	^ 'test03AlHacerVariosDepositosSeIncrementaElSaldoConElTotalDepositado
	
	| cuentaBancaria |
	cuentaBancaria := CuentaBancariaEnPesos new.
	cuentaBancaria depositar: 10 * peso.
	cuentaBancaria depositar: 20 * peso.
 	self assert: 30 * peso equals: cuentaBancaria saldo.
	'! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'FL 11/12/2021 16:10:55'!
case04
	^ 'test04AlExtrerDisminuyeElSaldoSegunElMontoExtraido
	
	| cuentaBancaria |
	cuentaBancaria := CuentaBancariaEnPesos new.
	cuentaBancaria depositar: 30 * peso.
	cuentaBancaria extraer: 20 * peso.
 	self assert: 10 * peso equals: cuentaBancaria saldo.
	'! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'FL 11/12/2021 16:11:57'!
case05
	^ 'test05AlExtraerLaCuentaNoPuedeQuedarEnDescubierto
	
	| cuentaBancaria |
	cuentaBancaria := CuentaBancariaEnPesos new.
	cuentaBancaria depositar: 30 * peso.
	cuentaBancaria extraer: 20 * peso.
	self should: [cuentaBancaria extraer: 11 * peso.] 
		raise: Error  
		withExceptionDo: [:anException | 
			self assert: ''La cuenta no puede quedar en descubierto'' equals: anException messageText. 
			self assert: 10 * peso equals: cuentaBancaria saldo.
		].
	'! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'FL 11/12/2021 16:12:20'!
cases
	^ {self case01. self case02. self case03. self case04. self case05. }! !

!TDDBabyStepsGameCuentaBancaria methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:11:08'!
extraCase
	
	^ 'extraTest
	
	self assert: true.
	'! !


!classDefinition: #TDDBabyStepsGameDemo category: 'TDDBabyStepsGame'!
TDDBabyStepsGame subclass: #TDDBabyStepsGameDemo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!
!TDDBabyStepsGameDemo commentStamp: '<historical>' prior: 0!
| game |
game  := TDDBabyStepsGameDemo start.
game openHelp.
game openDefinition.
game next.!


!TDDBabyStepsGameDemo methodsFor: 'private' stamp: 'NR 5/1/2022 04:27:11'!
definition
	
	^ 'Definicion de demostracion.'! !

!TDDBabyStepsGameDemo methodsFor: 'private' stamp: 'NR 5/2/2022 02:07:42'!
name 
	
	^ 'Demo'! !


!TDDBabyStepsGameDemo methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:07:11'!
case01
	
	^ 'test01
	
	self assert: false.
	'! !

!TDDBabyStepsGameDemo methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:07:18'!
case02
	
	^ 'test02
	
	self assert: false.
	' ! !

!TDDBabyStepsGameDemo methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:07:21'!
case03
	
	^ 'test03
	
	self assert: false.
	'! !

!TDDBabyStepsGameDemo methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:07:24'!
case04
	
	^ 'test04
	
	self assert: false.
	'! !

!TDDBabyStepsGameDemo methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:04'!
cases

	^ {self case01. self case02. self case03. self case04. }! !

!TDDBabyStepsGameDemo methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:11:02'!
extraCase
	
	^ 'testExtra
	
	self assert: true.
	'! !


!classDefinition: #TDDBabyStepsGamePrimeFactors category: 'TDDBabyStepsGame'!
TDDBabyStepsGame subclass: #TDDBabyStepsGamePrimeFactors
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!
!TDDBabyStepsGamePrimeFactors commentStamp: '<historical>' prior: 0!
| game |
game  := TDDBabyStepsGameCuentaBancaria start.
game openHelp.
game openDefinition.
game next.!


!TDDBabyStepsGamePrimeFactors methodsFor: 'private' stamp: 'NR 9/29/2022 05:23:04'!
definition
	
	^ 'Deben obtenerse los factores primos de un número natural. Por ej. 850 factorize debe retornar 2,5,5 y 17.

Ayuda: Considere utilizar el mensaje #isDivisibleBy: cuando sea necesario.
'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private' stamp: 'NR 5/2/2022 02:05:56'!
name 
	
	^ 'PrimeFactors'! !


!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:15:28'!
case01
	
	^ 'test01OneHasNoPrimeFactors
	
	self assert: Bag new equals: 1 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/8/2022 16:43:51'!
case02

	^ 'test02FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 2) equals: 2 factorize
	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/8/2022 16:44:00'!
case03
	
	^ 'test03FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 3) equals: 3 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:26:12'!
case04
	
	^ 'test04CorrectlyFactorizesACompositeNumberWithTwoFactors2
	
	self assert: (Bag with: 2 with: 2) equals: 4 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:25:29'!
case05
	
	^ 'test08CorrectlyFactorizesACompositeNumberWithMoreThanTwoFactors2
	
	self assert: (Bag with: 2 with: 2 with: 2) equals: 8 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:26:29'!
case06
	
	^ 'test09CorrectlyFactorizesACompositeNumberWithMoreThanOneFactorsDifferentThan2
	
	self assert: (Bag with: 3 with: 3) equals: 9 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:11:29'!
cases
	
	^ {self case01. self case02. self case03. self case04. self case05. self case06. }! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:23'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata
	
	self assert: (Bag with: 2 with: 2 with: 3 with: 3 with: 5 with: 13) equals: (2*2*3*3*5*13) factorize
	'! !


!classDefinition: #TDDBabyStepsGameRot13 category: 'TDDBabyStepsGame'!
TDDBabyStepsGame subclass: #TDDBabyStepsGameRot13
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!
!TDDBabyStepsGameRot13 commentStamp: '<historical>' prior: 0!
| game |
game  := TDDBabyStepsGameCuentaBancaria start.
game openHelp.
game openDefinition.
game next.!


!TDDBabyStepsGameRot13 methodsFor: 'private' stamp: 'NR 9/25/2022 04:30:53'!
definition
	
	^ 'ROT13 («rotar 13 posiciones») es un sencillo cifrado César utilizado para ocultar un texto sustituyendo cada letra por la letra que está trece posiciones por delante en el alfabeto. 
	
- A se convierte en N, B se convierte en O y así hasta la M, que se convierte en Z. 
	
- Luego la secuencia se invierte: N se convierte en A, O se convierte en B y así hasta la Z, que se convierte en M. 

Ver gráfico en: https://es.wikipedia.org/wiki/ROT13
Probar en: https://rot13.com/

Ayuda: Considere utilizar los mensajes #asciiValue, #asciiValue: #between:and: cuando sea necesario.

'! !

!TDDBabyStepsGameRot13 methodsFor: 'private' stamp: 'NR 5/2/2022 02:06:01'!
name 
	
	^ 'Rot13'! !


!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:41'!
case01

	^ 'test01CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $n equals: $a asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:47'!
case02

	^ 'test02CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $z equals: $m asRot13
	'
	! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:51'!
case03
	
	^ 'test03CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $a equals: $n asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:55'!
case04
	
	^ 'test04CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $m equals: $z asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:59'!
case05

	^ 'test05CharOnTheBelowRangeDoesntChange
	
	self assert: $` equals: $` asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:03'!
case06

	^ 'test06CharOnTheUpperRangeDoesntChange
	
	self assert: ${ equals: ${ asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:06'!
case07
	
	^ 'test07CorrectlyEncodesAnUppercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $N equals: $A asRot13.
	self assert: $Z equals: $M asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:10'!
case08
	
	^ 'test08CorrectlyEncodesAnUppercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $A equals: $N asRot13.
	self assert: $M equals: $Z asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:14'!
case09

	^ 'test09TheEmptyStringDoesntChange
	
	self assert: '''' equals: '''' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:18'!
case10

	^ 'test10CorrectlyEncodesAOneCharString
	
	self assert: ''n'' equals: ''a'' asRot13.
	self assert: ''Z'' equals: ''M'' asRot13.
	self assert: ''a'' equals: ''n'' asRot13.
	self assert: ''{'' equals: ''{'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:23'!
case11
	
	^ 'test11CorrectlyEncodesATwoCharString
	
	self assert: ''nm'' equals: ''az'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:26'!
case12

	^ 'test12CorrectlyEncodesMoreThanTwoCharString
	
	self assert: ''uByN!!'' equals: ''hOlA!!'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:32'!
cases

	^ {self case01. self case02. self case03. self case04. self case05. self case06. self case07. self case08. self case09. self case10. self case11. self case12 }! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:37'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata
		
	self assert: ''Ju3er j3 4e3 t01at j3 q0ag a3rq e04q$...'' equals: ''Wh3re w3 4r3 g01ng w3 d0nt n3ed r04d$...'' asRot13
	'! !


!classDefinition: #TDDBabyStepsGameBase category: 'TDDBabyStepsGame'!
Object subclass: #TDDBabyStepsGameBase
	instanceVariableNames: 'name casesToTest currentStep currentStepReturnMessage category score currentTest journey definition extraTest state prematureDecisionVerifierStrategy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2022 23:07:11'!
addEntryToJourney

	currentStepReturnMessage ifNotEmpty: [ journey add: 	currentStepReturnMessage ]! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2022 20:11:49'!
clearCurrentStepReturnMessage

	currentStepReturnMessage := ''! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 9/24/2022 22:30:32'!
finalScoreLine

	| finalGrade |
	
	finalGrade := String streamContents: [ :strm | self grade printOn: strm fractionDigits: 2 ].

	^ 'Tu puntaje final es: {1} puntos de {2} posibles. Tu nota por la kata es un {3}/10.' format: { score.  self totalObtainablePoints. finalGrade }! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2022 23:02:37'!
informGrade
	
	self updateCurrentStepReturnMessage: self newLine, self finalScoreLine
	! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 9/25/2022 18:17:29'!
newLine

	^ String with: Character newLineCharacter
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2022 20:11:24'!
updateCurrentStepReturnMessage: aNewMessage

	currentStepReturnMessage := currentStepReturnMessage, aNewMessage! !


!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:40'!
forcedNextPointsCost

	^ 5! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 9/24/2022 22:31:32'!
grade
	
	| gradeableScore |
	
	gradeableScore := self score.
	gradeableScore  < 0 ifTrue: [ gradeableScore := 0 ].
	
	^ (gradeableScore / self totalObtainablePoints * 10) asFloat! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:31'!
prematureDecisionsMadePointsCost

	^ 1! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:37:09'!
testPassedEarlyBonusPoints

	^ 0! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:47'!
testsDoNotPassPointsCost

	^ 1! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:37:19'!
testsPassedBonusPoints

	^ 5! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 9/25/2022 18:18:11'!
totalObtainablePoints

	^ self numberOfTests * self testsPassedBonusPoints! !


!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 9/25/2022 18:14:23'!
finishGame

	state := GameEnded for: self.
	self hasPassedExtraTest ifTrue: [ self gameEndedGeneralizedCorrectly ] ifFalse: [ self gameEndedGeneralizedIncorrectly ].
	self informGrade.
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 05:09:50'!
forceNextOnNormalStep
	
	self tryToPassTestsAndEvaluate: [ self stepCompleted. self decreaseScoreAsForcedNext. ]
		
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 09:23:32'!
increaseScoreOnEndedGame
	
	self error: self class increaseScoreOnEndedGameErrorMessage.
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:09:23'!
increaseScoreOnNormalStep
	
	self increaseScoreAsCurrentTestsPassed
				
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 07:46:54'!
increaseScoreOnPrematureDecisionStep
	
	self increaseScoreAsLatestTestPassedEarly.
	state := OnNormalStep for: self.
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:13:48'!
increaseScoreOnStartingGame
	
	self error: self class increaseScoreOnStartingGameErrorMessage.
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:27:15'!
informGameStartsAnd1stTestCreated

	self clearCurrentStepReturnMessage.
	self updateCurrentStepReturnMessage: 'Test01 creado correctamente. Páselo y presione next para continuar.'.
	self addEntryToJourney.! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 07:48:00'!
nextOnEndedGame
	
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/8/2022 17:57:44'!
nextOnNormalStep
	
	self tryToPassTestsAndEvaluate: [	
		(self prematureDecisionMade)
			ifTrue:[ self decreaseScoreAsPrematureDecisionsMade. ]
			ifFalse:[ self stepCompleted ]
		]
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:18:23'!
nextOnStartingGame
	
	self informGameStartsAnd1stTestCreated.
	self increaseCurrentStep.
	self addTestToTheTestCaseClass.
	state := OnNormalStep for: self.
	! !


!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:27:55'!
currentNewTestPassesEarly
	
	^ currentTest isNil not and: [ self hasPassedCurrentTest ]! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:32:26'!
detectPrematureDecisionOnNewStep
	
	self currentNewTestPassesEarly ifTrue: [ 
		state := OnPrematureDecisionStep for: self]! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:29:50'!
forceNextMessage

	^ 'Pero has tomado decisiones prematuras (utilizaste el forceNext para avanzar) por lo que restás {1} puntos.'! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/1/2022 20:14:49'!
gameEndedGeneralizedCorrectly
	
	self updateCurrentStepReturnMessage: self newLine, '¡Felicitaciones!! ', self class endOfGameMessage, ' Has generalizado la solución correctamente.'
	! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/1/2022 20:15:03'!
gameEndedGeneralizedIncorrectly
	
	score > 0 ifTrue: [ score := 0 ].
	self updateCurrentStepReturnMessage: self newLine, self class endOfGameMessage, ' Pero si bien pasas los tests, no has generalizado la solución lo suficiente.'
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 9/25/2022 18:14:46'!
gameHasEnded

	^ currentStep > self numberOfTests! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 9/25/2022 18:14:52'!
increaseCurrentStep

	currentStep := currentStep  + 1
! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 9/25/2022 18:14:55'!
numberOfTests

	^ casesToTest size! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 4/27/2023 14:26:00'!
prematureDecisionMade
	
	^ currentStep < self numberOfTests and: [ prematureDecisionVerifierStrategy value ]! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:32:26'!
stepCompleted

	self increaseScore.
	self increaseCurrentStep.
	self gameHasEnded
		ifTrue: [ self finishGame ]
		ifFalse: [ self addTestToTheTestCaseClass.
			self detectPrematureDecisionOnNewStep ]
! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/3/2022 07:07:59'!
tryToPassTestsAndEvaluate: aTestsPassBlock
	
	self clearCurrentStepReturnMessage.
		
	self runSuiteIfPassDo: aTestsPassBlock
		ifDoesNotPass: [ self decreaseScoreAsTestsDoNotPass. ]
	
	
! !


!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:13:00'!
browseTestCase

	BrowserWindow fullOnClass: self testCaseClass
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:01'!
hasPassedCurrentTest

	^ self runCurrentTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:07'!
hasPassedExtraTest

	^ self runExtraTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:12'!
hasPassedNextTest

	^ self runNextTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:16'!
runCurrentTest

	^ self runTest: currentTest
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:20'!
runExtraTest

	^ self runTest: (self compileTestFromMethod: extraTest)
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:42:49'!
runNextTest

	^ self runNextTest: self nextTest
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:42:08'!
runNextTest: aCaseToTest

	| nextTestName results |
	nextTestName := (self compileTestFromMethod: aCaseToTest).
	results := self runTest: nextTestName.
	self testCaseClass removeSelector: nextTestName.
	^ results
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:44:25'!
runNextTestNumber: aTestNumber

	^ self runNextTest: (casesToTest at: aTestNumber)
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/24/2022 21:07:25'!
runSuiteIfPassDo: aTestsPassBlock ifDoesNotPass: aTestsDoesNotPassBlock
		
	| testResult |

	testResult _ self testSuite run.	
	
	testResult hasPassed 
		ifTrue: aTestsPassBlock
		ifFalse: aTestsDoesNotPassBlock.
	
	self addEntryToJourney.
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:51:21'!
runTest: aTestName

	| suite |
	suite _ TestSuite forCompiledMethod: self testCaseClass >> aTestName.
	^ suite run
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/4/2022 19:33:09'!
someOfTheNextTestsPass

	^ (currentStep + 1 to: self numberOfTests) anySatisfy: [ :numberOfTest | (self runNextTestNumber: numberOfTest) hasPassed]! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:34'!
testSuite

	^ TestSuite forClass: self testCaseClass! !


!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:12:52'!
addTestToTheTestCaseClass

	currentTest := self testCaseClass compile: self currentTest classified: 'tests'! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:12'!
compileTestFromMethod: aTestMethod

	^ self testCaseClass compile: aTestMethod classified: 'tests'! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:21'!
createTestCaseClass

	Compiler evaluate: self createTestCaseDefinition! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:30'!
createTestCaseDefinition

	^ 'TestCase subclass: #{1}
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''{2}''' format: {self testCaseName. self testCaseCategory }! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:36'!
currentStep

	^ currentStep! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'JMB 10/28/2021 19:56:16'!
currentTest

	^ casesToTest at: currentStep! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:42'!
nextTest

	^ casesToTest at: currentStep + 1! !


!TDDBabyStepsGameBase methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:15:34'!
testCaseCategory

	^ category! !

!TDDBabyStepsGameBase methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:12:44'!
testCaseClass

	^ Smalltalk at: self testCaseName ! !

!TDDBabyStepsGameBase methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:15:41'!
testCaseName

	^ ('TDDBabySteps{1}Test' format: {name capitalized}) asSymbol! !


!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 5/3/2022 08:13:17'!
forceNext
	
	state forceNext
		
! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:00'!
journey

	^ journey! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:04'!
lastStepTakenIfNone: exceptionBlock

	^ journey lastIfEmpty: exceptionBlock ! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:08'!
next

	state next
! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:11'!
score

	^ score! !


!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/25/2022 18:13:59'!
definition

	^ definition! !

!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/24/2022 22:45:28'!
help
	
	^ '0- Iniciar un juego. Si llegó hasta aquí es que ya hizo: 
	
	game:=TDDBabyStepsGameXXXX start.
	
1- Usted comienza con un puntaje de 0 puntos. Al comenzar se creará la clase de test y se abrirá un class browser.  

2- Para obtener el primer caso de test a pasar presione el botón "next".

3- Una vez finalizada la implementación para ese test presione nuevamente el botón de "next":

- Si sus tests pasan, ganará 5 puntos y se le presentará el próximo test.
- Si sus tests no pasan, perderá 1 punto y deberá seguir intentando haciendolos pasar.
- Si sus test pasan pero se adelantó con su implementación (no es mínima) perderá 1 punto y deberá intentar reformularla para no adelanterse pasos.

3''- IMPORTANTISIMO: Tenga SIEMPRE en mente que hacer "game next" le escribirá un nuevo test. Si desea hacer un "paso 3" de refactor/generalización, hagalo ANTES de presionar "next".

4- Si no logra llegar a la implementación mínima siempre puede presionar el botón "forceNext" para seguir avanzando. De esta manera se le presentará el próximo test (el cual pasará directamente con la implementación propuesta) y así entender en que se había adelantado. Pero ¡Atención!! De hacerlo se le restaran 5 puntos y ademas el nuevo test presentado no sumará puntos pues ya pasaba de entrada al efectuar el "forceNext".

5- Preste atención a las indicaciones descriptas en la sección "Step Result". En "Game Journey" podrá ir visualizando el resumen de su trayecto actual en el juego.

6- Cuando los tests se acaben el juego habrá terminado y se le presentará un puntaje junto a su nota final por el ejercicio. Pero ¡Atención nuevamente!! Si sólo se encargó de pasar los tests y nunca generalizó utilizando un paso 3, puede que pierda TODOS su puntos si no logra pasar un último test extra de generalización. Con lo que, ¡No se olviden de generalizar!!

Notas extras: 
a) Para practicar, antes de presionar "next" puede pensar y anotar en un papel cual cree que sería el próximo test a pasar y así comparar por el que presenta el juego.
b) Al terminar el juego puede pensar cuales de los tests presentados habría que mantener y cuales podrían eliminarse por estar repetidos. Verificar además los nombres de los mismos comparando dato de test con caso de test.
c) Si quiere recomenzar un mismo juego, no olvide eliminar manualmente 1. Todos los casos de tests generados automaticamente por el juego y 2. La implementación que haya escrito hasta el momento.
'! !

!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/25/2022 18:14:09'!
name

	^ name! !


!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 4/26/2023 19:36:36'!
initializeNamed: aName withCases: aCasesToTest withExtraCase: anExtraCase inCategory: aCategory withDefinition: aDefinition 
	
	name := aName.
	casesToTest := aCasesToTest.
	extraTest :=anExtraCase.
	category := aCategory.
	definition := aDefinition. 
	currentStep := 0.
	score := 0.
	state := GameStarting for: self.
	journey := OrderedCollection new.
	prematureDecisionVerifierStrategy  := [self hasPassedNextTest].
	"prematureDecisionVerifierStrategy  := [self someOfTheNextTestsPass]."
	self createTestCaseClass.! !


!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 10/13/2022 05:29:50'!
decreaseScoreAsForcedNext

	self decreaseScoreBy: self forcedNextPointsCost withMessage: self newLine, self forceNextMessage. ! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/3/2022 07:54:50'!
decreaseScoreAsPrematureDecisionsMade

	self decreaseScoreBy: self prematureDecisionsMadePointsCost withMessage: self class prematureDecisionsMadeErrorMessage, self newLine, 'Restás {1} punto.'.! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/3/2022 07:55:10'!
decreaseScoreAsTestsDoNotPass

	self decreaseScoreBy: self testsDoNotPassPointsCost withMessage:self class testsDoNotPassErrorMessage, self newLine, 'Restás {1} punto.'.! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2022 20:29:52'!
decreaseScoreBy: points withMessage: description
	
	score := score - points.
	self updateCurrentStepReturnMessage: (description,' Tu puntaje actual es de {2}.' format: {points. score}).
	
	! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/3/2022 07:44:57'!
increaseScore
	
	state increaseScore.
	

	

! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2022 19:37:19'!
increaseScoreAsCurrentTestsPassed

	self increaseScoreBy: self testsPassedBonusPoints withMessage: 'Has completado el test actual, sumás {1} puntos.'
	! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2022 20:28:44'!
increaseScoreAsLatestTestPassedEarly

	self increaseScoreBy: self testPassedEarlyBonusPoints withMessage: 'Sumás {1} puntos porque pasaste este test de entrada. Avanzás al siguiente test.'! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2022 20:29:04'!
increaseScoreBy: points withMessage: description
	
	score := score + points.
	self updateCurrentStepReturnMessage: (description,' Tu puntaje actual es de {2}.' format: {points. score})	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameBase class' category: 'TDDBabyStepsGame'!
TDDBabyStepsGameBase class
	instanceVariableNames: ''!

!TDDBabyStepsGameBase class methodsFor: 'instance creation' stamp: 'NR 5/1/2022 04:49:56'!
startNamed: aName withCases: casesToTest withExtraCase:extraCase inCategory: aCategory withDefinition: aDefinition  
	
	^self new initializeNamed: aName withCases: casesToTest withExtraCase: extraCase inCategory: aCategory withDefinition: aDefinition ! !


!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 4/30/2022 21:18:15'!
endOfGameMessage
	
	^ 'Has finalizado el juego/kata.'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 5/3/2022 09:20:42'!
increaseScoreOnEndedGameErrorMessage
	
	^ 'No se pueden sumar puntos de un juego terminado.'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 10/13/2022 06:13:34'!
increaseScoreOnStartingGameErrorMessage
	
	^ 'No se pueden sumar puntos de un juego que recíen comienza (sin tests).'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 4/30/2022 19:13:53'!
prematureDecisionsMadeErrorMessage
	
	^ '¡Te estás adelantando!! Para continuar modifica tu modelo actual por uno más sencillo y menos general.'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 4/30/2022 19:13:48'!
testsDoNotPassErrorMessage
	
	^ 'No se puede avanzar al próximo test si no pasan todos los tests actuales.'! !


!classDefinition: #TDDBabyStepsGameState category: 'TDDBabyStepsGame'!
Object subclass: #TDDBabyStepsGameState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameState methodsFor: 'initialization' stamp: 'NR 9/25/2022 18:18:51'!
initializeWith: aGame

	game := aGame! !


!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:07'!
forceNext
	
	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:49:44'!
increaseScore
	
	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 9/25/2022 18:18:58'!
next

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameState class' category: 'TDDBabyStepsGame'!
TDDBabyStepsGameState class
	instanceVariableNames: ''!

!TDDBabyStepsGameState class methodsFor: 'as yet unclassified' stamp: 'NR 5/3/2022 05:54:15'!
for: aGame
	
	^ self new initializeWith: aGame! !


!classDefinition: #GameEnded category: 'TDDBabyStepsGame'!
TDDBabyStepsGameState subclass: #GameEnded
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!GameEnded methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:26'!
forceNext
	
	game nextOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:41:42'!
increaseScore

	game increaseScoreOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:48:00'!
next
	
	game nextOnEndedGame! !


!classDefinition: #GameStarting category: 'TDDBabyStepsGame'!
TDDBabyStepsGameState subclass: #GameStarting
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2022 06:11:25'!
forceNext
	
	game nextOnStartingGame! !

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2022 06:12:04'!
increaseScore

	game increaseScoreOnStartingGame! !

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2022 06:10:11'!
next
	
	game nextOnStartingGame! !


!classDefinition: #OnNormalStep category: 'TDDBabyStepsGame'!
TDDBabyStepsGameState subclass: #OnNormalStep
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:47'!
forceNext

	game forceNextOnNormalStep! !

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:40:42'!
increaseScore

	game increaseScoreOnNormalStep! !

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 9/25/2022 18:19:12'!
next

	game nextOnNormalStep! !


!classDefinition: #OnPrematureDecisionStep category: 'TDDBabyStepsGame'!
TDDBabyStepsGameState subclass: #OnPrematureDecisionStep
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:12:15'!
forceNext

	game forceNextOnNormalStep! !

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:41:11'!
increaseScore

	game increaseScoreOnPrematureDecisionStep! !

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:31:28'!
next

	game nextOnNormalStep! !


!classDefinition: #TDDBabyStepsGameView category: 'TDDBabyStepsGame'!
Object subclass: #TDDBabyStepsGameView
	instanceVariableNames: 'model stepResult gameJourney'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameView methodsFor: 'initialization' stamp: 'NR 9/23/2022 23:02:01'!
initializeFor: aGame
	
	model := aGame.
	stepResult := ''.
	gameJourney := ''.! !


!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:32'!
currentStep

	^model currentStep! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:36'!
forceNext

	self informResultOf: [ model forceNext ]! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:40'!
informResultOf: aNextStepBlock

	aNextStepBlock value.
	
	self informStepResult! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/24/2022 20:39:39'!
next
	
	self informResultOf: [ model next ]
! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:45'!
numberOfTests

	^model numberOfTests ! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:50'!
score

	^model score! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:53'!
start

	model browseTestCase. 
	self informStart! !


!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/23/2022 23:30:25'!
formatJourney

	^ model journey reverse inject: '' into:[ :finalLog :line | finalLog, '- ', line, self newLine ]! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:02'!
newLine

	^ String with: Character newLineCharacter! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:07'!
openDefinition

	TextModel new contents: model definition; openLabel: 'Enunciado ', model name! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:10'!
openHelp

	TextModel new contents: model help; openLabel: model name, ' Ayuda'! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:13'!
openJourney
	
	TextModel new contents: self formatJourney; openLabel: model name, ' Journey Log'! !


!TDDBabyStepsGameView methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:20:41'!
testCaseCategory

	^ model testCaseCategory! !


!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/23/2022 22:57:51'!
gameJourneyText
	
	^gameJourney! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/23/2022 22:22:50'!
informStart
	
	"self inform: 'El juego/kata se inicia. Se ha creado la clase de test.', self newLine, 'Avance al siguiente paso (utilizando next) para generar el primer test a pasar.'"
	
	self notify: 'El juego/kata se inicia. Se ha creado la clase de test.', self newLine, 'Avance al siguiente paso (utilizando next) para generar el primer test a pasar.'.
	
	
	
	! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/23/2022 22:23:14'!
informStepResult
	
	| lastStepTaken |
	lastStepTaken := model lastStepTakenIfNone: [ ^self ].
	self notify: lastStepTaken! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/25/2022 18:20:28'!
notify: aMessage
	
	stepResult :=  aMessage.
	gameJourney := self formatJourney.
	
	self triggerEvent: #gameChanged.
	
	
	! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/23/2022 20:13:47'!
stepResultText
	
	^stepResult! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameView class' category: 'TDDBabyStepsGame'!
TDDBabyStepsGameView class
	instanceVariableNames: ''!

!TDDBabyStepsGameView class methodsFor: 'instance creation' stamp: 'JMB 11/14/2021 20:12:56'!
for: aGame
	^ self new initializeFor: aGame! !

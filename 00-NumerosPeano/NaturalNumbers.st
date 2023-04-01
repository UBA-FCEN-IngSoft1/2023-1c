!classDefinition: #I category: 'NaturalNumbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NaturalNumbers'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next & previous' stamp: 'JFGO 3/25/2023 19:00:37'!
next
	^II.! !

!I class methodsFor: 'next & previous' stamp: 'JFGO 3/28/2023 18:14:50'!
previous
	self error: self oneDontHavePrevErrorDescription.! !


!I class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/28/2023 17:46:07'!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
	"Caso 'Equal' del GreaterEqual"
	^self! !

!I class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 20:49:28'!
multiplyByBiggerThanOne: aNaturalNumberBiggerThanOne
	^aNaturalNumberBiggerThanOne! !

!I class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:59:30'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous.! !

!I class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/28/2023 17:30:14'!
timesDivideTo: aDividend
	^aDividend.
	! !


!I class methodsFor: 'error description' stamp: 'JFGO 3/28/2023 18:12:03'!
negativeNumbersNotSupportedErrorDescription

	^ 'In natural numbers, can not substract a number minus a bigger or equal number'! !

!I class methodsFor: 'error description' stamp: 'JFGO 3/28/2023 18:14:50'!
oneDontHavePrevErrorDescription

	^ 'El I no tiene previo'! !


!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 20:48:03'!
* aNaturalNumber
	^aNaturalNumber.! !

!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:13:50'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/28/2023 18:12:03'!
- aNaturalNumber
	self error: self negativeNumbersNotSupportedErrorDescription.
	! !

!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/28/2023 17:31:47'!
/ aDivisor
	^aDivisor timesDivideTo: self
	! !


!classDefinition: #II category: 'NaturalNumbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NaturalNumbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'next & previous' stamp: 'JFGO 4/1/2023 18:21:45'!
next
	next ifNil: [
		next := II createChildNamed: self name,'I'. 
		next previous: self.		
		].
	
	^next.! !

!II class methodsFor: 'next & previous' stamp: 'JFGO 3/25/2023 19:25:46'!
previous
	^previous.! !

!II class methodsFor: 'next & previous' stamp: 'JFGO 3/25/2023 19:36:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !


!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 20:48:33'!
* aNaturalNumber
	^aNaturalNumber multiplyByBiggerThanOne: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:27:09'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:58:08'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/28/2023 17:18:45'!
/ aDivisor
	
	^aDivisor timesDivideTo: self.! !


!II class methodsFor: 'clone removing' stamp: 'JFGO 3/27/2023 17:34:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'error descriptions' stamp: 'JFGO 3/28/2023 17:37:08'!
canNotDivideByBiggerNumberErrorDescription

	^ 'No se puede dividir'! !


!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/28/2023 17:55:18'!
divideWithDividendGreaterEqualThanDivisor: aDividend and: aDivisor
	^[(aDividend - aDivisor) / aDivisor + I
		] on:Error do: [I]! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 20:49:11'!
multiplyByBiggerThanOne: aNaturalNumberBiggerThanOne
	^aNaturalNumberBiggerThanOne + (self previous * aNaturalNumberBiggerThanOne)! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 20:54:19'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/28/2023 17:54:59'!
timesDivideTo: aDividend

"No tenemos comparacion disponible para saber si divisor es mas grande que dividendo, habra que ver si falla"
"El + I es para salvar el caso de division entre iguales"

	^ [(aDividend + I - self) divideWithDividendGreaterEqualThanDivisor:  aDividend and: self		] 
		on: Error 
		do: [self error: self canNotDivideByBiggerNumberErrorDescription]! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'JFGO 4/1/2023 18:22:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

II initializeAfterFileIn!
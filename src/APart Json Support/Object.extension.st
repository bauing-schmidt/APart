Extension { #name : #Object }

{ #category : #'*APart Json Support-converting' }
Object >> asJsonObject [

	^ APJsonParser parse: (self printJson). 
]

{ #category : #'*APart Json Support-converting' }
Object >> isAPJson [

	^false
]

{ #category : #'*APart Json Support' }
Object >> isJsonCollection [

	^false
]

{ #category : #'*APart Json Support' }
Object >> isJsonObject [

	^false
]

{ #category : #'*APart Json Support-converting' }
Object >> keysAndValuesForJson [
	"Generisches Verfahren, das alle Instanzvariablen mit Inhalt ~~ nil als JSON repräsentiert"

	| allIvarNames result slotsUsed |
	allIvarNames := self class allInstVarNames.
	result := Array new: allIvarNames size.
	slotsUsed := 0.
	allIvarNames doWithIndex: 
			[:ivarName :i |
			| getter |
			getter := ivarName asSymbol.
			((self respondsTo: getter)
				ifTrue: [self perform: getter]
				ifFalse: [self instVarAt: i])
					ifNotNil: 
						[:v |
						slotsUsed := slotsUsed + 1.
						result at: slotsUsed put: getter -> v]].
	^result copyFrom: 1 to: slotsUsed
]

{ #category : #'*APart Json Support-converting' }
Object >> printJson [

	| s |
	s := WriteStream on: String new.
	self printJsonOn: s.
	^s contents
]

{ #category : #'*APart Json Support-converting' }
Object >> printJsonOn: s [

	s nextPut: ${.
	self keysAndValuesForJson do: 
			[:assoc |
			s
				nextPutAll: assoc key surroundedByDoubleQuotes;
				nextPut: $:.
			assoc value printJsonOn: s]
		separatedBy: [s nextPut: $,].
	s nextPut: $}
]

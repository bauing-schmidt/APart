"
I am the base class for all kind of decorator styles that are used to compose the behavior of an APTrComposedDecorator.
"
Class {
	#name : #APRsDecoratorStyle,
	#superclass : #Object,
	#category : #'APart Roassal Support-Styles'
}

{ #category : #'instance creation' }
APRsDecoratorStyle class >> create [

	^self basicNew initialize
]

{ #category : #'instance creation' }
APRsDecoratorStyle class >> empty [

	^self basicNew
]

{ #category : #API }
APRsDecoratorStyle >> applyStyleTo: aWrapperOrCanvas [
	"Normal pattern: Dispatch back to object"
	
	self subclassResponsibility 
]

{ #category : #initialization }
APRsDecoratorStyle >> initialize [
]

{ #category : #API }
APRsDecoratorStyle >> isLabelStyle [

	^false
]

{ #category : #API }
APRsDecoratorStyle >> isLineStyle [

	^false
]

{ #category : #context }
APRsDecoratorStyle >> restore: aProperty after: aBlock [
	|state value|
	state := self perform: aProperty.
	value:=aBlock cull: self.
	self perform: aProperty asMutator with: state.
	^ value
]

{ #category : #API }
APRsDecoratorStyle >> styles [ 

	"for compatibility with APTrStyleSet"
	^ { self }
]

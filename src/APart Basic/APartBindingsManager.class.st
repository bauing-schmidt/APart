Class {
	#name : #APartBindingsManager,
	#superclass : #Object,
	#instVars : [
		'bindings',
		'source'
	],
	#category : #'APart Basic-Bindings'
}

{ #category : #accessing }
APartBindingsManager >> aspectAt: aKey [

	| binding rawAspect |
	binding := bindings at: aKey ifAbsent: [nil].
	binding ifNotNil: [^binding].
	source ifNil: [^nil].
	rawAspect := self safelyPerform: #aspectFor: key: aKey.
	binding := rawAspect ifNil: [ APAspect named: aKey for: nil ].
	binding subAdaptor ifNil: [
		^(self tryCompositeKey: aKey)
			ifNil: [ APAspect named: aKey for: nil ]].
	bindings at: aKey put: binding.
	^binding
]

{ #category : #accessing }
APartBindingsManager >> aspectAt: aKey put: value [ 

	^bindings at: aKey put: value
]

{ #category : #accessing }
APartBindingsManager >> bindings [
	^ bindings
]

{ #category : #accessing }
APartBindingsManager >> bindings: anObject [
	bindings := anObject
]

{ #category : #accessing }
APartBindingsManager >> findBindingFor: aKey selector: aSelector [

	| b |
	b := bindings at: aKey ifAbsent: [nil].
	b == nil ifFalse: [^b].
	source == nil ifTrue: [^nil].
	b := (self safelyPerform: aSelector key: aKey).
	b subAdaptor == nil ifTrue: [^nil].
	bindings at: aKey put: b.
	^b
]

{ #category : #accessing }
APartBindingsManager >> initialize [ 

	super initialize.
	
	bindings := Dictionary new.
]

{ #category : #accessing }
APartBindingsManager >> listAt: aKey [
	"Answer the binding for the list collection with the named key, either in the bindings cache, or from the source."

	^self findBindingFor: aKey selector: #listFor:
]

{ #category : #accessing }
APartBindingsManager >> safelyPerform: aSelector key: aKey [

	^[source perform: aSelector with: aKey] 
		on: MessageNotUnderstood
		do: [:ex | | sel |
			sel := ex message selector.
			(sel == aKey or: [sel == aSelector])
				ifTrue: [ex return: nil]
				ifFalse: [ex pass]]
]

{ #category : #accessing }
APartBindingsManager >> source [
	^ source
]

{ #category : #accessing }
APartBindingsManager >> source: anObject [
	source := anObject
]

{ #category : #accessing }
APartBindingsManager >> tryCompositeKey: aKey [ 

	| aPath head b aPathClass |
	
	aPathClass := APartPresenter aspectPathClass.
	aPathClass ifNil: [^nil].
	aPath := aPathClass forAspect: aKey fromBuilder: self.
	aPath tail ifNil: [^nil].
	b := bindings at: (head := aPath head) ifAbsent: [nil].
	b ifNil: 
			[b := self safelyPerform: #aspectFor: key: head.
			b ifNil: [^nil].
			bindings at: head put: b].
	b := aPath model.
	b ifNil: [^nil].
	bindings at: aKey put: (APAspect named: aKey for: b).
	^b
]

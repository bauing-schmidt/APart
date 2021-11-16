"
APAspectPath dient zur Transformation von Aspektpfaden, um deren Anteile von Sub-Parts auszufiltern und durch einen APRedirectedAspect abzubilden.
"
Class {
	#name : #APAspectPath,
	#superclass : #Object,
	#instVars : [
		'head',
		'tail',
		'trigger',
		'builder',
		'aspectKey'
	],
	#category : #'APart Basic-Bindings'
}

{ #category : #'instance creation' }
APAspectPath class >> forAspect: aSymbol fromBuilder: aBuilder [

	^self new
		builder: aBuilder;
		parsePathSyntaxFor: aSymbol;
		aspectKey: aSymbol;
		yourself
]

{ #category : #'instance creation' }
APAspectPath class >> forAspect: aSymbol useHead: aValueModel [

	| path |
	path := (super forAspect: aSymbol fromBuilder: nil)
				aspectKey: aSymbol;
				yourself.
	^path modelWithHead: aValueModel
]

{ #category : #'VisualWorks metadata' }
APAspectPath class >> visualWorksMetadata [

	^ #(
		'superclassNamespace' 'UI'
	)

]

{ #category : #private }
APAspectPath >> adaptorStartingAt: aValueModel [
	| path model getSel |
	head ifNil: [ ^ nil ].
	path := OrderedCollection new.
	1 to: tail size - 1 do: [ :index | path addLast: (tail at: index) ].
	tail isEmpty
		ifTrue: [ model := aValueModel ]
		ifFalse: [ (model := (getSel := tail at: tail size) isInteger
				ifTrue: [ APIndexedAdaptor forIndex: getSel path: path ]
				ifFalse: [ APAspectAdaptor forAspect: getSel path: path ])
				subjectChannel: aValueModel ].
	trigger notNil
		ifTrue: [ model := ValueHolder
				subject: model
				triggerChannel: (builder aspectAt: trigger)	"BufferedValueHolder" ].
	((model isKindOf: APAspectAdaptor)
		and: [ aValueModel respondsTo: #reworkAspectAdaptor: ])
		ifTrue: [ ^ aValueModel reworkAspectAdaptor: model ].
	^ model
]

{ #category : #accessing }
APAspectPath >> aspectKey [

	^aspectKey
]

{ #category : #accessing }
APAspectPath >> aspectKey: anObject [

	aspectKey := anObject
]

{ #category : #parsing }
APAspectPath >> builder: aBuilder [

	builder := aBuilder
]

{ #category : #parsing }
APAspectPath >> head [

	^head
]

{ #category : #accessing }
APAspectPath >> model [

	| headAspect |
	headAspect := builder aspectAt: head.
	^self modelWithHead: headAspect
]

{ #category : #accessing }
APAspectPath >> modelWithHead: headAspect [

	(headAspect hasAPValueAdaptor) ifTrue: [
		^ headAspect subAdaptor model partInterface description createAspectNamed: self aspectKey redirectTo: self aspectKey substrings.].
		
	^self adaptorStartingAt: (builder aspectAt: head)
]

{ #category : #parsing }
APAspectPath >> parsePathSyntaxFor: aKey [

	| tokens strm |
	(aKey isNil or: [(aKey indexOf: Character space) = 0])
		ifTrue: [^self].
	tokens := aKey substrings.
	head := tokens first.
	tokens size > 1
		ifTrue:
			[(strm := tokens readStream) skip: 1.
			tail := strm upTo: #|.
			strm atEnd
				ifFalse: [trigger := strm next]]
]

{ #category : #accessing }
APAspectPath >> part [

	^builder source partInterface part
]

{ #category : #parsing }
APAspectPath >> tail [

	^tail
]

{ #category : #private }
APAspectPath >> trigger [

	^trigger
]

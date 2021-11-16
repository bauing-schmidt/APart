Extension { #name : #SpAbstractFormButtonPresenter }

{ #category : #'*APart Pharo' }
SpAbstractFormButtonPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [
		
	| aValueAdaptor |
	aValueAdaptor := aspectObject subAdaptor.

	(self instVarNamed: #state) whenChangedDo: [ :newValue :oldValue |
		"aValueAdaptor ignoreChangesWhile: ["aValueAdaptor value: (newValue ifNil: [false])"]" ].
	
	aValueAdaptor addDependent: state.

	"initial update"
	state := (aValueAdaptor value)
]

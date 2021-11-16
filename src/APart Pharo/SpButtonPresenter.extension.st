Extension { #name : #SpButtonPresenter }

{ #category : #'*APart Pharo' }
SpButtonPresenter >> setAPartAction: anAction [

	self action: [ 
		| model |
		model := anAction.
		model isBlock ifTrue: [
			model cull: model value ]
			ifFalse: [ model value: model value ]
	 ]
]

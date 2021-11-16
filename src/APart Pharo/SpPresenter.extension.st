Extension { #name : #SpPresenter }

{ #category : #'*APart Pharo' }
SpPresenter >> getPresenterNamed: aSymbol argumetns: args [

	^ self perform: aSymbol withArguments: args
]

{ #category : #'*APart Pharo' }
SpPresenter >> isAPartPresenter [

	^ false
]

{ #category : #'*APart Pharo' }
SpPresenter >> localeChanged: locale [

	self additionalSubpresentersMap do: [ :aPresenter |
		aPresenter localeChanged: locale ].
	self localeChanged. 
]

{ #category : #'*APart Pharo' }
SpPresenter >> rawLayout: newLayout [ 

	(self rawValueHolderNamed: #layout) rawValue: newLayout
]

{ #category : #'*APart Pharo' }
SpPresenter >> rawValueHolderNamed: aSymbol [

	^ (self class slotNamed: aSymbol) rawRead: self.
]

{ #category : #'*APart Pharo' }
SpPresenter >> setValueAdaptor: aValueAdaptor aspect: anAspect parent: parentPresenter interface: toPart [

	"do nothing here"
]

{ #category : #'*APart Pharo' }
SpPresenter >> suggestAspectSymbol: aSymbol [

	"do nothing here, for use in subclasses"
	

]

{ #category : #'*APart Pharo' }
SpPresenter >> withAllSubpresenters [

	^ OrderedCollection with: self
]

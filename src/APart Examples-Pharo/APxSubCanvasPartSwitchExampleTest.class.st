Class {
	#name : #APxSubCanvasPartSwitchExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxSubCanvasPartSwitchExampleTest >> classToBeTested [

	^ APxSubCanvasPartSwitchExample
]

{ #category : #tests }
APxSubCanvasPartSwitchExampleTest >> testInitialState [

	self performTest: [ :part :form | 
			#(switchToTreeView switchToListView currentView)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(switchToNoView)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
				
			self assert: (form presenterNamed: #currentView) class equals: SpLabelPresenter.
		]
]

{ #category : #tests }
APxSubCanvasPartSwitchExampleTest >> testReselectNoView [

	self skip.

	self performTest: [ :part :form | 
		(form presenterNamed: #switchToListView) performAction.
		(form presenterNamed: #switchToNoView) performAction.
		#(switchToListView switchToTreeView currentView)
			do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
		#( switchToNoView)
			do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			
			self assert: (form presenterNamed: #currentView) class equals: SpLabelPresenter.
	]
]

{ #category : #tests }
APxSubCanvasPartSwitchExampleTest >> testSelectList [

	self skip.

	self performTest: [ :part :form | 
		(form presenterNamed: #switchToListView) performAction.
		#(switchToNoView switchToTreeView currentView)
			do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
		#(switchToListView)
			do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			
		"this check does not work with stub adapter"	
		"self assert: (form presenterNamed: #currentView) class equals: APartListPresenter."
	]
]

{ #category : #tests }
APxSubCanvasPartSwitchExampleTest >> testSelectTree [

	self skip.

	self performTest: [ :part :form | 
		(form presenterNamed: #switchToTreeView) performAction.
		#(switchToNoView switchToListView currentView)
			do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
		#(switchToTreeView)
			do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
				
		"this check does not work with stub adapter"	
		"self assert: (form presenterNamed: #currentView) class equals: APartTreeTablePresenter."
	]
]

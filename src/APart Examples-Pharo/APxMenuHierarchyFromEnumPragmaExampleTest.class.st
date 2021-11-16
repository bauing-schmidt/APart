Class {
	#name : #APxMenuHierarchyFromEnumPragmaExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxMenuHierarchyFromEnumPragmaExampleTest >> classToBeTested [

	^ APxMenuHierarchyFromEnumPragmaExample
]

{ #category : #tests }
APxMenuHierarchyFromEnumPragmaExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(actionMenu actionText peripheralActionText)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			self assert: (form presenterNamed: #actionText) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #peripheralActionText) text isEmptyOrNil ]
]

{ #category : #tests }
APxMenuHierarchyFromEnumPragmaExampleTest >> testPerformActionFromButton [
	self
		performTest: [ :part :form | 
			| anItem |
			anItem := (form presenterNamed: #actionMenu) menu menuGroups
				first menuItems first.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionText) text
				equals: 'Action Alice performed.'.
			self
				assert: (form presenterNamed: #peripheralActionText) text isEmptyOrNil.
			anItem := (form presenterNamed: #actionMenu) menu menuGroups
				first menuItems last.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionText) text
				equals: 'Action Eve performed.'.
			self
				assert: (form presenterNamed: #peripheralActionText) text isEmptyOrNil ]
]

{ #category : #tests }
APxMenuHierarchyFromEnumPragmaExampleTest >> testPerformActionFromButtonLabel [

	self skip.

	self
		performTest: [ :part :form | 
			| anItem |
			anItem := (form presenterNamed: #actionMenu) menu menuGroups
				first menuItems first.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionMenu) label
				equals: 'Action Alice performed.' ]
]

{ #category : #tests }
APxMenuHierarchyFromEnumPragmaExampleTest >> testSelectActionFromMenu [
	self
		performTest: [ :part :form | 
			| actionsMenu anItem |
			actionsMenu := (form presenterNamed: #menu) menuGroups first
				menuItems first subMenu.
			anItem := actionsMenu menuGroups first menuItems first.
			self assert: anItem name equals: 'lbActionAlice'.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionText) text
				equals: 'Action Alice performed.'.
			self
				assert: (form presenterNamed: #peripheralActionText) text isEmptyOrNil.
			anItem := actionsMenu menuGroups first menuItems last.
			self assert: anItem name equals: 'lbActionEve'.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionText) text
				equals: 'Action Eve performed.'.
			self
				assert: (form presenterNamed: #peripheralActionText) text isEmptyOrNil ]
]

{ #category : #tests }
APxMenuHierarchyFromEnumPragmaExampleTest >> testSelectPeripheralFromMenu [
	self
		performTest: [ :part :form | 
			| peripheralMenu anItem |
			peripheralMenu := (form presenterNamed: #menu) menuGroups first
				menuItems second subMenu.
			anItem := peripheralMenu menuGroups first menuItems last.
			self assert: anItem name equals: 'lbActionScreen'.
			anItem performMenuActionWith: anItem.
			self assert: (form presenterNamed: #actionText) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #peripheralActionText) text
				equals: 'Action Screen performed.'.
			anItem := peripheralMenu menuGroups first menuItems first.
			anItem := anItem subMenu menuGroups first menuItems last.
			self assert: anItem name equals: 'lbActionKeyboard'.
			anItem performMenuActionWith: anItem.
			self assert: (form presenterNamed: #actionText) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #peripheralActionText) text
				equals: 'Action Keyboard performed.' ]
]

Class {
	#name : #APxMenuNestedEnumerationTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxMenuNestedEnumerationTest >> classToBeTested [

	^ APxMenuNestedEnumeration
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(actionDisplay valueMenu valueDisplay)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			self
				assert: (form presenterNamed: #actionDisplay) text isEmptyOrNil.
			self assert: (form presenterNamed: #valueDisplay) text isEmptyOrNil ]
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testSelectActionFromMenu [
	self
		performTest: [ :part :form | 
			| actionsMenu anItem |
			actionsMenu := (form presenterNamed: #menu) menuGroups first
				menuItems first subMenu.
			anItem := actionsMenu menuGroups first menuItems first.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionDisplay) text
				equals: 'Action Apple performed'.
			self assert: (form presenterNamed: #valueDisplay) text isEmptyOrNil ]
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testSelectActionFromMenuSubmenu [
	self
		performTest: [ :part :form | 
			| actionsMenu submenu anItem |
			actionsMenu := (form presenterNamed: #menu) menuGroups first
				menuItems first subMenu.
			submenu := actionsMenu menuGroups first menuItems last subMenu.
			anItem := submenu menuGroups first menuItems last.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionDisplay) text
				equals: 'Action Strawberry box large performed'.
			self assert: (form presenterNamed: #valueDisplay) text isEmptyOrNil ]
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testSelectValueFromButton [
	self
		performTest: [ :part :form | 
			| anItem |
			anItem := (form presenterNamed: #valueMenu) menu menuGroups
				first menuItems first.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionDisplay) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #valueDisplay) text
				equals: 'One apple' ]
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testSelectValueFromButtonSubmenu [
	self
		performTest: [ :part :form | 
			| submenu anItem |
			submenu := (form presenterNamed: #valueMenu) menu menuGroups
				first menuItems last subMenu.
			anItem := submenu menuGroups first menuItems last.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionDisplay) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #valueDisplay) text
				equals: 'Large strawberry box' ]
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testSelectValueFromMenu [
	self
		performTest: [ :part :form | 
			| actionsMenu anItem |
			actionsMenu := (form presenterNamed: #menu) menuGroups first
				menuItems second subMenu.
			anItem := actionsMenu menuGroups first menuItems first.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionDisplay) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #valueDisplay) text
				equals: 'One apple' ]
]

{ #category : #tests }
APxMenuNestedEnumerationTest >> testSelectValueFromMenuSubmenu [
	self
		performTest: [ :part :form | 
			| actionsMenu submenu anItem |
			actionsMenu := (form presenterNamed: #menu) menuGroups first
				menuItems second subMenu.
			submenu := actionsMenu menuGroups first menuItems last subMenu.
			anItem := submenu menuGroups first menuItems last.
			anItem performMenuActionWith: anItem.
			self
				assert: (form presenterNamed: #actionDisplay) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #valueDisplay) text
				equals: 'Large strawberry box' ]
]

Extension { #name : #APMenuItem }

{ #category : #'*APart Pharo' }
APMenuItem >> setSpecMenuItem: spMenuItem [
		
	spMenuItem
		name: (self label translateFor: spMenuItem application locale);
		enabled: [ self value isActive ];
		action: [ self value executeWith: {  } ].
		
	(self labelImage notNil) ifTrue: [ 
		spMenuItem icon: self labelImage ].
		
	(self submenu notNil) ifTrue: [ 
		spMenuItem subMenu: (self submenu asSpecMenuIn: spMenuItem application) ]

]

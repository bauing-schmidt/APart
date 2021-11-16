Extension { #name : #MAStringDescription }

{ #category : #'*APart-Magritte' }
MAStringDescription class >> defaultPassword [

	^ false
]

{ #category : #'*APart-Magritte' }
MAStringDescription class >> defaultPlaceholder [

	^ ''
]

{ #category : #'*APart-Magritte' }
MAStringDescription >> descriptionPassword [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #password;
		label: 'Password';
		priority: 200;
		default: self class defaultPassword;
		yourself
]

{ #category : #'*APart-Magritte' }
MAStringDescription >> descriptionPlaceholder [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #placeholder;
		label: 'Placeholder';
		priority: 400;
		default: self class defaultPlaceholder;
		yourself
]

{ #category : #'*APart-Magritte' }
MAStringDescription >> password [
	^ self propertyAt: #password ifAbsent: [ self class defaultPassword ]
]

{ #category : #'*APart-Magritte' }
MAStringDescription >> password: aString [
	self propertyAt: #password put: aString
]

{ #category : #'*APart-Magritte' }
MAStringDescription >> placeholder [
	^ self propertyAt: #placeholder ifAbsent: [ self class defaultPlaceholder ]
]

{ #category : #'*APart-Magritte' }
MAStringDescription >> placeholder: aString [
	self propertyAt: #placeholder put: aString
]

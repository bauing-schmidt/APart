Class {
	#name : #APErrorTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APErrorTest >> testAPartError [

	self should: [ self aPartError: #someTag ] raiseAPartError: #someTag attribute: nil.
	self should: [ self aPartError: #someTag attribute: 42 ] raiseAPartError: #someTag attribute: 42.
	self should: [ self aPartError: #someTag text: 'some text' attribute: 42 ] raiseAPartError: #someTag attribute: 42.
	self should: [ self aPartError: #someTag text: 'some text' attribute: 42 ] raise: APError withExceptionDo: [ :ex | self assert: ex messageText equals: 'some text' ]
]

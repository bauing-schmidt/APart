"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxPathAndRedirectionExample,
	#superclass : #APartExampleGUI,
	#instVars : [
		'subView',
		'part1View',
		'part2View'
	],
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #API }
APxPathAndRedirectionExample class >> matchingPartClass [

	^APxPathAndRedirectionPart
]

{ #category : #'initialize-release' }
APxPathAndRedirectionExample >> initialize [

	super initialize.
	subView := APxPathAndRedirectionSubPartL1Example asSubViewOn: self
				subInterface: (self partInterface subInterfaceAtPath: #(#partL1)).
	part1View := APxPathAndRedirectionSubPartL1Example asSubViewOn: self
				subInterface: (self partInterface
						subInterfaceAtPath: #(#switchingPart #part1)).
	part2View := APxPathAndRedirectionSubPartL1Example asSubViewOn: self
				subInterface: (self partInterface
						subInterfaceAtPath: #(#switchingPart #part2))
]

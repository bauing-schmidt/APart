"
I add behavior of root parts like ability to register member groups
"
Trait {
	#name : #APTRootPart,
	#instVars : [
		'memberGroupsRegister'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #accessing }
APTRootPart >> memberGroupsRegistry [

	^ memberGroupsRegister ifNil: [ memberGroupsRegister := APMemberGroupsRegistry for: self ]
]

Class {
	#name : #APartAssociation,
	#superclass : #Association,
	#instVars : [
		'addString'
	],
	#category : #'APart Pharo'
}

{ #category : #'instance creation' }
APartAssociation class >> from: anAssociation [
	"Filed out as: '3X12XH.ST' "
	"Last change: Frank Winkler, 04.07.1997, 14:58:30 " 
	"Creator: Frank Winkler, 04.07.1997, 14:58:17 " 
	"Copyright © 1997 IMS GmbH"
	"Uncommented"

	^self 
		key: anAssociation key 
		value: anAssociation value.
]

{ #category : #'instance creation' }
APartAssociation class >> key: aKey value: aValue addKeyString: aString [
	"Filed out as: '2W8OIX.ST' "
	"Last change: Frank Winkler (20 July 1995 10:44:58 am) " 
	"Creator: Frank Winkler (6 July 1995 10:31:02 am) " 
	"Copyright © 1995 IMS GmbH"
	"Möglichkeit, eindeutige Associations durch zusätzliche Instanzvariable addString zu erreichen"

	| new |
	new := self key: aKey value: aValue.
	((aString notNil) and: [aString ~= ''])
		ifTrue:	[new addString: aString.].
	^new
]

{ #category : #comparing }
APartAssociation >> < anIMSAssociation [
	"Filed out as: '2UUY7N.ST' "
	"Creator: Frank Winkler (23 June 1995 2:14:12 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^(self key < anIMSAssociation key)
]

{ #category : #comparing }
APartAssociation >> <= anIMSAssociation [
	"Filed out as: '2UUY8R.ST' "
	"Last change: Frank Winkler (23 June 1995 2:14:52 pm) " 
	"Creator: Frank Winkler (23 June 1995 2:14:12 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^(self key <= anIMSAssociation key)
]

{ #category : #comparing }
APartAssociation >> = anIMSAssociation [
	"Filed out as: '2UUY9G.ST' "
	"Last change: Frank Winkler (23 June 1995 2:15:16 pm) " 
	"Creator: Frank Winkler (23 June 1995 2:14:12 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^(self key = anIMSAssociation key)
]

{ #category : #comparing }
APartAssociation >> > anIMSAssociation [
	"Filed out as: '2UUY82.ST' "
	"Last change: Frank Winkler (23 June 1995 2:14:27 pm) " 
	"Creator: Frank Winkler (23 June 1995 2:14:12 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^(self key > anIMSAssociation key)
]

{ #category : #comparing }
APartAssociation >> >= anIMSAssociation [
	"Filed out as: '2UUY97.ST' "
	"Last change: Frank Winkler (23 June 1995 2:15:08 pm) " 
	"Creator: Frank Winkler (23 June 1995 2:14:12 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^(self key >= anIMSAssociation key)
]

{ #category : #accessing }
APartAssociation >> addString [
	"Filed out as: '2W8OGW.ST' "
	"Creator: Frank Winkler (20 July 1995 10:43:45 am) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^addString
]

{ #category : #accessing }
APartAssociation >> addString: x [
	"Filed out as: '2W8OGJ.ST' "
	"Creator: Frank Winkler (20 July 1995 10:43:32 am) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^addString := x
]

{ #category : #printing }
APartAssociation >> asText [
	"Filed out as: '2ZC20S.ST' "
	"Creator: Frank Winkler (18 September 1995 2:10:05 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^self printString asText
]

{ #category : #copying }
APartAssociation >> imsCopyTo: aSymbol [
	"Filed out as: '2WWRGH.ST' "
	"Last change: Frank Winkler (2 August 1995 10:50:42 am) " 
	"Creator: Frank Winkler (1 August 1995 6:55:33 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Ergänzung der geerbten Methode."

	| new |
	new := APartAssociation 
			key: (self key imsCopyTo: aSymbol) 
			value: (self value imsCopyTo: aSymbol) 
			addKeyString: (self addString imsCopyTo: aSymbol).
	^new.
]

{ #category : #printing }
APartAssociation >> printOn: aStream [ 
	"Filed out as: '3IU367.ST' "
	"Last change: Frank Winkler, IMS GmbH , 01.10.1996, 16:30:08 " 
	"Append to the argument, aStream, the two elements of the 
	Association separated by a right arrow."

	aStream nextPutAll: self key.
	aStream nextPutAll: '->'.
	aStream nextPutAll: self value printString.
]

{ #category : #printing }
APartAssociation >> printString [
	"Rückgabe des Keys"

	^key printString
]

{ #category : #printing }
APartAssociation >> roleDisplayString [

	| result |
	result := self addString makeStringWithPixels: 100.
	result := result , ' -> ' , self key.
	^result
]

{ #category : #comparing }
APartAssociation >> ~= anIMSAssociation [
	"Filed out as: '2UUY9P.ST' "
	"Last change: Frank Winkler (23 June 1995 2:15:26 pm) " 
	"Creator: Frank Winkler (23 June 1995 2:14:12 pm) " 
	"Copyright © 1995 IMS GmbH"
	"Comment"

	^(self key ~= anIMSAssociation key)
]
